//
//  CustomActionData.h
//  Example
//

#import <GPJDataDrivenTableView/GPJDataDrivenTableView.h>

@interface CustomActionData : GPJBaseData
- (CGFloat)cellHeight;
@property (nonatomic, copy) NSString *leftButtonName;
@property (nonatomic, copy) NSString *rightButtonName;
@property (nonatomic, copy) void (^leftButtonAction)(CustomActionData *data);
@property (nonatomic, copy) void (^rightButtonAction)(CustomActionData *data);
@end

@interface CustomActionCell : GPJBaseCell
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@end

