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
 * 2. set self.datasource to self
 * 3. set self.delegate to self
 */
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

// must specify style as UITableViewStylePlain
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style NS_DESIGNATED_INITIALIZER;

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

/* Reloads everything from scratch. Redisplays visible rows.
 * 1. GPJDataDrivenTableView.dataArray = dataArray;
 * 2. [GPJDataDrivenTableView reloadData];
 */
- (void)reloadDataArray:(NSArray *)dataArray;

@end
