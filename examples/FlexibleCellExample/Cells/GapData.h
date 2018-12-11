//
//  GapData.h
//  Example
//

#import <GPJDataDrivenTableView/GPJDataDrivenTableView.h>

@interface GapData : GPJBaseData
@property (nonatomic, assign) CGFloat height;
+ (instancetype)gapDataWithHeight:(CGFloat)height;
@end

@interface GapCell : GPJBaseCell

@end

