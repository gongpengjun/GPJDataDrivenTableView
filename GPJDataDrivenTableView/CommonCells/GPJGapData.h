//
//  GPJGapData.h
//
//  Created by gongpengjun <frank.gongpengjun@gmail.com>
//

#import "GPJDataDrivenTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GPJGapData : GPJTableViewData
@property (nonatomic, assign) CGFloat height;
+ (instancetype)gapDataWithHeight:(CGFloat)height;
@end

@interface GPJGapCell : GPJTableViewCell

@end

NS_ASSUME_NONNULL_END
