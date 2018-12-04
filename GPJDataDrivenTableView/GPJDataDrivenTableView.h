//
//  GPJDataDrivenTableView.h
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

@interface GPJDataDrivenTableView : UITableView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;

/* Initialize GPJDataDrivenTableView, do the following setup:
 * 1. call [super initWithFrame:style:] with UITableViewStylePlain
 * 2. set `self` as `super.datasource`
 * 3. set `self` as `super.delegate`
 */
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

/* Reloads everything from scratch. Redisplays visible rows.
 * 1. self.dataArray = dataArray;
 * 2. [super reloadData];
 */
- (void)reloadDataArray:(NSArray *)dataArray;

/* Use `dataArray` to get the data-driven-cell feature of GPJDataDrivenTableView
 * DO NOT assign `dataSource` or `delegate`, Use `gpjDataSource` and `gpjDelegate` instead
 * GPJDataDrivenTableView will assign `self` as `dataSource` and `delegate`
 */
@property (nonatomic, weak, nullable) id <UITableViewDataSource> dataSource NS_UNAVAILABLE; // use gpjDataSource
@property (nonatomic, weak, nullable) id <UITableViewDelegate> delegate NS_UNAVAILABLE; // use gpjDelegate

@property (nonatomic, weak, nullable) id <UITableViewDataSource> gpjDataSource;
@property (nonatomic, weak, nullable) id <UITableViewDelegate>   gpjDelegate;

// DO ONT use the following initializers, since GPJDataDrivenTableView always use `UITableViewStylePlain`
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

@end

@interface GPJDataDrivenTableView (DataCellMapping)
- (id)dataForIndexPath:(NSIndexPath *)indexPath;
- (Class)cellClassForIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)heightForIndexPath:(NSIndexPath *)indexPath;
- (Class)cellClassForDataClass:(Class)dataClass;
@end
