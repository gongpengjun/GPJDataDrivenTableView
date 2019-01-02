//
//  GPJRoundCornerSeparatorData.h
//
//  Created by gongpengjun <frank.gongpengjun@gmail.com>
//

#import "GPJDataDrivenTableView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, GPJCellSeparatorPosition) {
    GPJCellSeparatorPositionNone   = 0,
    GPJCellSeparatorPositionTop    = 1 << 0,
    GPJCellSeparatorPositionBottom = 1 << 1
};

@interface GPJRoundCornerSeparatorData : GPJTableViewData
// background view config
@property (nonatomic, assign) UIEdgeInsets             backgroundViewInset;
@property (nonatomic, assign) UIRectCorner             backgroundViewCorners;
@property (nonatomic, assign) CGFloat                  backgroundViewCornerRadius;
// separator line view config
@property (nonatomic, assign) GPJCellSeparatorPosition separatorPosition; // interpreted as an offset from the edges of the cell's contentView.
@property (nonatomic, assign) UIEdgeInsets             separatorInset;
@property (nonatomic, strong) UIColor                 *separatorColor;
@end

@interface GPJRoundCornerSeparatorCell : GPJTableViewCell
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *separatorLineView;
@end

NS_ASSUME_NONNULL_END
