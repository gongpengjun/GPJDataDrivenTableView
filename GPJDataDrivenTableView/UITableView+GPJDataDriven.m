//
//  UITableView+GPJDataDriven.m
//
//  Created by gongpengjun <frank.gongpengjun@gmail.com>
//

#import "UITableView+GPJDataDriven.h"
#import <objc/runtime.h>

#define kDefaultCellHeight 44.0f

@implementation GPJBaseData

@synthesize didSelectAction;

- (CGFloat)cellHeight;
{
    return kDefaultCellHeight;
}

@end

@interface GPJBaseCell ()
+ (NSString *)GPJReuseIdentifier; // cell reuse identifier
@end

@implementation GPJBaseCell

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

static const void *kDataArray     = &kDataArray;
static const void *kGpjDataSource = &kGpjDataSource;
static const void *kGpjDelegate   = &kGpjDelegate;

@implementation UITableView (GPJDataDriven)

- (void)setDataArray:(NSArray *)dataArray
{
    objc_setAssociatedObject(self, kDataArray, dataArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)dataArray
{
    return objc_getAssociatedObject(self, kDataArray);
}

- (void)setGpjDataSource:(id<UITableViewDataSource>)gpjDataSource
{
    objc_setAssociatedObject(self, kGpjDataSource, gpjDataSource, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    // force UITableView to re-query dataSource's methods
    self.dataSource = nil; self.dataSource = self;
}

- (id<UITableViewDataSource>)gpjDataSource
{
    return objc_getAssociatedObject(self, kGpjDataSource);
}

- (void)setGpjDelegate:(id<UITableViewDelegate>)gpjDelegate
{
    objc_setAssociatedObject(self, kGpjDelegate, gpjDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    // force UITableView to re-query delegate's methods
    self.delegate = nil; self.delegate = self;
}

- (id<UITableViewDelegate>)gpjDelegate
{
    return objc_getAssociatedObject(self, kGpjDelegate);
}

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame;
{
    self = [self initWithFrame:frame style:UITableViewStylePlain];
    if(self) {
        self.delegate = self; // The delegate is not retained.
        self.dataSource = self; // The data source is not retained.
    }
    return self;
}

- (void)reloadDataArray:(NSArray *)dataArray;
{
    self.dataArray = dataArray;
    [self reloadData];
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
    if ([data isKindOfClass:[GPJBaseData class]]) {
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
    NSString *reuseIdentifier = [self reuseIdentifierForIndexPath:indexPath];
    Class     cellClass       = [self cellClassForIndexPath:indexPath];
    GPJBaseCell *cell = [self dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
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
    if (![data isKindOfClass:[GPJBaseData class]])
        return;
    GPJBaseData *baseData = (GPJBaseData *)data;
    if (baseData.didSelectAction) {
        baseData.didSelectAction(data);
    }
}

@end

#pragma mark -

@implementation UITableView (GPJMessageForward)

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
