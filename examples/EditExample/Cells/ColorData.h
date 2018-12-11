//
//  ColorData.h
//  Example
//

#import <GPJDataDrivenTableView/GPJDataDrivenTableView.h>

@interface ColorData : GPJBaseData
@property (nonatomic, strong) UIColor *bgColor;
@end

@interface ColorCell : GPJBaseCell
@property (nonatomic, strong) UIView *colorView;
@end
