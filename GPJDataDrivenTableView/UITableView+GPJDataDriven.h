//
//  UITableView+GPJDataDriven.h
//
//  Created by gongpengjun <frank.gongpengjun@gmail.com>
//

#import <UIKit/UIKit.h>

@interface GPJBaseData : NSObject
@property (nonatomic, copy) void (^didSelectAction)(id data); // data is subclass of GPJBaseData
- (CGFloat)cellHeight;
@end

@interface GPJBaseCell : UITableViewCell
@property (nonatomic, strong) id data; // data is subclass of GPJBaseData
- (void)configCell;
@end

@interface UITableView (GPJDataDriven) <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;

/* Initialize UITableView(GPJDataDriven), do the following setup:
 * 1. call [self initWithFrame:style:] with UITableViewStylePlain
 * 2. set `self` as `self.datasource`
 * 3. set `self` as `self.delegate`
 */
- (instancetype)initWithFrame:(CGRect)frame;

/* Reloads everything from scratch. Redisplays visible rows.
 * 1. self.dataArray = dataArray;
 * 2. [super reloadData];
 */
- (void)reloadDataArray:(NSArray *)dataArray;

@property (nonatomic, weak, nullable) id <UITableViewDataSource> gpjDataSource;
@property (nonatomic, weak, nullable) id <UITableViewDelegate>   gpjDelegate;

// DO ONT use the following initializers, since UITableView(GPJDataDriven) always use `UITableViewStylePlain`
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

@end

@interface UITableView (GPJDataCellMapping)
- (id)dataForIndexPath:(NSIndexPath *)indexPath;
- (Class)cellClassForIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)heightForIndexPath:(NSIndexPath *)indexPath;
- (Class)cellClassForDataClass:(Class)dataClass;
@end
