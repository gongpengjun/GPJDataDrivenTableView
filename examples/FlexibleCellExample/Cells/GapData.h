//
//  GapData.h
//  Example
//

#import <GPJDataDrivenTableView/UITableView+GPJDataDriven.h>

@interface GapData : GPJBaseData
@property (nonatomic, assign) CGFloat height;
+ (instancetype)gapDataWithHeight:(CGFloat)height;
@end

@interface GapCell : GPJBaseCell

@end

