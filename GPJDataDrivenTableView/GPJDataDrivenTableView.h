//
//  GPJDataDrivenTableView.h
//
//  Created by gongpengjun <frank.gongpengjun@gmail.com>
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GPJTableViewData : NSObject
@property (nonatomic, copy) void (^didSelectAction)(id data); // data is subclass of GPJTableViewData
- (CGFloat)cellPreferredMaxWidth; // Support for cell width autofit, If nonzero, this is used when determining tableView's content width
- (CGFloat)cellHeight;
@end

@interface GPJTableViewCell : UITableViewCell
@property (nonatomic, strong) id data; // data is subclass of GPJTableViewData
- (void)configCell;
@end

@interface GPJDataDrivenTableView : UITableView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSArray *dataArray;

/* Initialize GPJDataDrivenTableView, do the following setup:
 * 1. call [super initWithFrame:style:] with UITableViewStylePlain
 * 2. set `self` as `super.datasource`
 * 3. set `self` as `super.delegate`
 */
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;
// DO ONT use the following initializers, since GPJDataDrivenTableView always use `UITableViewStylePlain`
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

/* Reloads everything from scratch. Redisplays visible rows.
 * 1. self.dataArray = dataArray;
 * 2. [super reloadData];
 */
- (void)reloadDataArray:(NSArray *)dataArray;

/* GPJDataDrivenTableView assign `self` as `dataSource` and `delegate` to implement two-way data binding.
 * Use `gpjDataSource` and `gpjDelegate` if you want customize the behaviour.
 */
@property (nonatomic, weak, nullable) id <UITableViewDataSource> gpjDataSource;
@property (nonatomic, weak, nullable) id <UITableViewDelegate>   gpjDelegate;

@property (nonatomic, weak, nullable) id <UITableViewDataSource> dataSource NS_UNAVAILABLE; // use gpjDataSource
@property (nonatomic, weak, nullable) id <UITableViewDelegate> delegate NS_UNAVAILABLE; // use gpjDelegate

- (CGFloat)contentPreferredMaxWidth;
- (CGFloat)contentHeight;

// The following methods is for subclass or `gpjDataSource/gpjDelegate`
- (id)dataForIndexPath:(NSIndexPath *)indexPath; // safe way to access `data` in `dataArray`
- (Class)cellClassForIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)heightForIndexPath:(NSIndexPath *)indexPath;
- (Class)cellClassForDataClass:(Class)dataClass; // Data -> Cell name mapping

@end

NS_ASSUME_NONNULL_END
