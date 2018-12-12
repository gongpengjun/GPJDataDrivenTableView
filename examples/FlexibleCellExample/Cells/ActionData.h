//
//  ActionData.h
//  Example
//

#import <GPJDataDrivenTableView/GPJDataDrivenTableView.h>

@interface ActionData : GPJTableViewData
@property (nonatomic, copy) NSString *actionName;
- (CGFloat)cellHeight;
@end

@interface ActionCell : GPJTableViewCell
@property (nonatomic, strong) UILabel *actionLabel;
@end
