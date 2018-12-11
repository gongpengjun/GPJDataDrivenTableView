//
//  ActionData.h
//  Example
//

#import <GPJDataDrivenTableView/GPJDataDrivenTableView.h>

@interface ActionData : GPJBaseData
@property (nonatomic, copy) NSString *actionName;
- (CGFloat)cellHeight;
@end

@interface ActionCell : GPJBaseCell
@property (nonatomic, strong) UILabel *actionLabel;
@end
