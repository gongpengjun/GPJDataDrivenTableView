//
//  GPJDataDrivenTableView.m
//
//  Created by gongpengjun <frank.gongpengjun@gmail.com>
//

#import "GPJDataDrivenTableView.h"

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

@implementation GPJDataDrivenTableView

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame;
{
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    if(self) {
        self.delegate = self; // The delegate is not retained.
        self.dataSource = self; // The data source is not retained.
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style;
{
    NSAssert(UITableViewStylePlain == style, @"GPJDataDrivenTableView only support UITableViewStylePlain");
    self = [super initWithFrame:frame style:style];
    if(self) {
        self.delegate = self; // The delegate is not retained.
        self.dataSource = self; // The data source is not retained.
    }
    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder;
{
    self = [super initWithCoder:aDecoder];
    if(self) {
        NSAssert(UITableViewStylePlain == self.style, @"GPJDataDrivenTableView only support UITableViewStylePlain");
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

- (NSInteger)rowCountInSection:(NSInteger)section;
{
    return self.dataArray.count;
}

- (id)dataForIndexPath:(NSIndexPath *)indexPath;
{
    if(0 <= indexPath.row && indexPath.row < self.dataArray.count)
        return [self.dataArray objectAtIndex:indexPath.row];
    else
        return nil;
}

- (Class)cellClassForIndexPath:(NSIndexPath *)indexPath;
{
    id data = [self dataForIndexPath:indexPath];
    Class cellClass = [self cellClassForDataClass:[data class]];
    return cellClass;
}

- (NSString *)reuseIdentifierForIndexPath:(NSIndexPath *)indexPath;
{
    return [[self cellClassForIndexPath:indexPath] GPJReuseIdentifier];
}

- (CGFloat)heightForIndexPath:(NSIndexPath *)indexPath;
{
    id data  = [self dataForIndexPath:indexPath];
    if ([data isKindOfClass:[GPJBaseData class]]) {
        return [data cellHeight];
    } else {
        return kDefaultCellHeight;
    }
}

#pragma mark - Data -> Cell name mapping

- (Class)cellClassForDataClass:(Class)dataClass;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return [self heightForIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    id data = [self dataForIndexPath:indexPath];
    if (![data isKindOfClass:[GPJBaseData class]])
        return;
    GPJBaseData *baseData = (GPJBaseData *)data;
    if (baseData.didSelectAction) {
        baseData.didSelectAction(data);
    }
}

@end
