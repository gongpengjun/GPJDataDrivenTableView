//
//  GPJDataDrivenTableView.m
//
//  Created by gongpengjun <frank.gongpengjun@gmail.com>
//

#import "GPJDataDrivenTableView.h"
#import <objc/runtime.h>

#define kDefaultCellHeight 44.0f

@implementation GPJTableViewData

@synthesize didSelectAction;

- (CGFloat)cellHeight;
{
    return kDefaultCellHeight;
}

@end

@interface GPJTableViewCell ()
+ (NSString *)GPJReuseIdentifier; // cell reuse identifier
@end

@implementation GPJTableViewCell

+ (NSString *)GPJReuseIdentifier;
{
    return NSStringFromClass([self class]);
}

- (void)setData:(id)data
{
    _data = data;
    [self configCell];
}

- (void)configCell;
{
    // do nothing
}

@end

@implementation GPJDataDrivenTableView

@dynamic dataSource, delegate;

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame;
{
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    if(self) {
        super.delegate = self; // The delegate is not retained.
        super.dataSource = self; // The data source is not retained.
    }
    return self;
}

- (void)reloadDataArray:(NSArray *)dataArray;
{
    self.dataArray = dataArray;
    [super reloadData];
}

#pragma mark - Data to Cell Mapping

- (NSInteger)sectionCount
{
    return 1;
}

- (NSInteger)rowCountInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (id)dataForIndexPath:(NSIndexPath *)indexPath
{
    if(0 <= indexPath.row && indexPath.row < self.dataArray.count)
        return [self.dataArray objectAtIndex:indexPath.row];
    else
        return nil;
}

- (Class)cellClassForIndexPath:(NSIndexPath *)indexPath
{
    id data = [self dataForIndexPath:indexPath];
    Class cellClass = [self cellClassForDataClass:[data class]];
    return cellClass;
}

- (NSString *)reuseIdentifierForIndexPath:(NSIndexPath *)indexPath
{
    return [[self cellClassForIndexPath:indexPath] GPJReuseIdentifier];
}

- (CGFloat)heightForIndexPath:(NSIndexPath *)indexPath
{
    id data  = [self dataForIndexPath:indexPath];
    if ([data isKindOfClass:[GPJTableViewData class]]) {
        return [data cellHeight];
    } else {
        return kDefaultCellHeight;
    }
}

#pragma mark - Data -> Cell name mapping

- (Class)cellClassForDataClass:(Class)dataClass
{
    NSString *dataClassName = NSStringFromClass(dataClass);
    NSString *cellClassName = nil;
    if ([dataClassName hasSuffix:@"Data"]) {
        cellClassName = [[dataClassName substringToIndex:dataClassName.length-@"Data".length] stringByAppendingString:@"Cell"];
    }
    Class cellClass = NSClassFromString(cellClassName);
    NSAssert(cellClass, @"fatal error: NO cell class '%@' for data class '%@'",cellClassName,dataClassName);
    return cellClass;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self sectionCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self rowCountInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Class     cellClass  = [self cellClassForIndexPath:indexPath];
    NSString *identifier = [self reuseIdentifierForIndexPath:indexPath];
    [self registerClass:cellClass forCellReuseIdentifier:identifier];
    // the dequeue method guarantees a cell is returned and resized properly, assuming identifier is registered
    GPJTableViewCell *cell = [self dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.data = [self dataForIndexPath:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self heightForIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.gpjDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.gpjDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
    
    id data = [self dataForIndexPath:indexPath];
    if (![data isKindOfClass:[GPJTableViewData class]])
        return;
    GPJTableViewData *baseData = (GPJTableViewData *)data;
    if (baseData.didSelectAction) {
        baseData.didSelectAction(data);
    }
}

#pragma mark - DataSource/Delegate MessageForward

- (void)setGpjDataSource:(id<UITableViewDataSource>)gpjDataSource
{
    _gpjDataSource = gpjDataSource;
    // force UITableView to re-query dataSource's methods
    super.dataSource = nil; super.dataSource = self;
}

- (void)setGpjDelegate:(id<UITableViewDelegate>)gpjDelegate
{
    _gpjDelegate = gpjDelegate;
    // force UITableView to re-query delegate's methods
    super.delegate = nil; super.delegate = self;
}

- (BOOL)shouldForwardSelectorToDataSource:(SEL)aSelector
{
    // Only forward the selector to gpjDataSource if it's part of the UITableViewDataSource protocol.
    struct objc_method_description description = protocol_getMethodDescription(@protocol(UITableViewDataSource), aSelector, NO, YES);
    BOOL isSelectorInTableViewDataSource = (description.name != NULL && description.types != NULL);
    BOOL shouldForword = (isSelectorInTableViewDataSource && [self.gpjDataSource respondsToSelector:aSelector]);
    return shouldForword;
}

- (BOOL)shouldForwardSelectorToDelegate:(SEL)aSelector
{
    // Only forward the selector to gpjDelegate if it's part of the UITableViewDelegate protocol.
    struct objc_method_description description = protocol_getMethodDescription(@protocol(UITableViewDelegate), aSelector, NO, YES);
    BOOL isSelectorInTableViewDelegate = (description.name != NULL && description.types != NULL);
    BOOL shouldForword = (isSelectorInTableViewDelegate && [self.gpjDelegate respondsToSelector:aSelector]);
    return shouldForword;
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if ([self shouldForwardSelectorToDataSource:aSelector]) {
        return YES;
    }
    
    if ([self shouldForwardSelectorToDelegate:aSelector]) {
        return YES;
    }

    return [super respondsToSelector:aSelector];
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol
{
    if ([NSStringFromProtocol(aProtocol) isEqualToString:@"UITableViewDataSource"]) {
        return YES;
    }
    
    if ([NSStringFromProtocol(aProtocol) isEqualToString:@"UITableViewDelegate"]) {
        return YES;
    }
    
    return [super conformsToProtocol:aProtocol];
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    if ([self shouldForwardSelectorToDataSource:aSelector]) {
        return self.gpjDataSource;
    }
    
    if ([self shouldForwardSelectorToDelegate:aSelector]) {
        return self.gpjDelegate;
    }

    return [super forwardingTargetForSelector:aSelector];
}

@end
