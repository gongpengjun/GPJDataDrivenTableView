//
//  GapData.h
//  Example
//

#import <GPJDataDrivenTableView/GPJDataDrivenTableView.h>

@interface GapData : GPJTableViewData
@property (nonatomic, assign) CGFloat height;
+ (instancetype)gapDataWithHeight:(CGFloat)height;
@end

@interface GapCell : GPJTableViewCell

@end

