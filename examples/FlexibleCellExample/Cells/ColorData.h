//
//  ColorData.h
//  Example
//

#import <GPJDataDrivenTableView/GPJDataDrivenTableView.h>

@interface ColorData : GPJTableViewData
@property (nonatomic, strong) UIColor *bgColor;
@end

@interface ColorCell : GPJTableViewCell
@property (nonatomic, strong) UIView *colorView;
@end
