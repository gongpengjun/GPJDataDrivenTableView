//
//  ColorData.h
//  Example
//

#import <GPJDataDrivenTableView/UITableView+GPJDataDriven.h>

@interface ColorData : GPJBaseData
@property (nonatomic, strong) UIColor *bgColor;
@end

@interface ColorCell : GPJBaseCell
@property (nonatomic, strong) UIView *colorView;
@end
