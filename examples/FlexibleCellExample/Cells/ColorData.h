//
//  ColorData.h
//  Example
//

#import <GPJDataDrivenTableView/GPJRoundCornerSeparatorData.h>

@interface ColorData : GPJRoundCornerSeparatorData
@property (nonatomic, strong) UIColor *bgColor;
@end

@interface ColorCell : GPJRoundCornerSeparatorCell
@property (nonatomic, strong) UIView *colorView;
@end
