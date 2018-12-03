//
//  GPJDataDrivenTableView.h
//
//  Created by gongpengjun <frank.gongpengjun@gmail.com>
//

#import <UIKit/UIKit.h>

@class GPJDataDrivenTableView;

typedef void (^GPJTableViewConfigBlock)(GPJDataDrivenTableView *tableContainerView, UITableView *tableView);

@interface GPJBaseData : NSObject
@property (nonatomic, copy) void (^didSelectAction)(id data);
- (CGFloat)cellHeight;
@end

@interface GPJBaseCell : UITableViewCell
@property (nonatomic, strong) id data;
- (void)configCell;
@end

@interface GPJDataDrivenTableView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray     *dataArray;

- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype)initWithFrame:(CGRect)frame configTableViewBlock:(GPJTableViewConfigBlock)configTableViewBlock;
- (void)reloadData;

@end
