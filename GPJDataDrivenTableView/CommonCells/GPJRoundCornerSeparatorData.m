//
//  GPJRoundCornerSeparatorData.m
//
//  Created by gongpengjun <frank.gongpengjun@gmail.com>
//

#import "GPJRoundCornerSeparatorData.h"

@implementation GPJRoundCornerSeparatorData

@end

@implementation GPJRoundCornerSeparatorCell

@synthesize backgroundView = _backgroundView;
@synthesize separatorLineView = _separatorLineView;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        self.backgroundView = [[UIView alloc] initWithFrame:self.contentView.bounds];
        self.backgroundView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.backgroundView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    GPJRoundCornerSeparatorData *data = self.data;
    
    // layout background view
    self.backgroundView.frame = UIEdgeInsetsInsetRect(self.contentView.bounds, data.backgroundViewInset);
    UIRectCorner corners = data.backgroundViewCorners;
    if (corners > 0) {
        CGFloat radius = data.backgroundViewCornerRadius;
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.backgroundView.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.frame = self.bounds;
        maskLayer.path = maskPath.CGPath;
        self.backgroundView.layer.mask = maskLayer;
    } else {
        self.backgroundView.layer.mask = nil;
    }

    // layout separator line view
    CGFloat cellWidth = CGRectGetWidth(self.contentView.bounds);
    CGFloat cellHeight = CGRectGetHeight(self.contentView.bounds);
    
    CGFloat separatorH = 1.0/self.separatorLineView.contentScaleFactor;
    CGFloat separatorW = cellWidth - data.separatorInset.left - data.separatorInset.right;
    CGFloat separatorY = 0.0;
    
    UIColor *separatorLineColor = data.separatorColor ?:[UIColor colorWithRed:0xF0/255.0f green:0xF0/255.0f blue:0xF0/255.0f alpha:1.0];
    
    GPJCellSeparatorPosition separatorPosition = data.separatorPosition;
    switch (separatorPosition) {
        case GPJCellSeparatorPositionTop:
            self.separatorLineView.hidden = NO;
            separatorY = data.separatorInset.top;
            self.separatorLineView.frame = CGRectMake(data.separatorInset.left, separatorY, separatorW, separatorH);
            self.separatorLineView.backgroundColor = separatorLineColor;
            break;
        case GPJCellSeparatorPositionBottom:
            self.separatorLineView.hidden = NO;
            separatorY = cellHeight - separatorH + data.separatorInset.bottom;
            self.separatorLineView.frame = CGRectMake(data.separatorInset.left, separatorY, separatorW, separatorH);
            self.separatorLineView.backgroundColor = separatorLineColor;
            break;
        case GPJCellSeparatorPositionNone:
        default:
            _separatorLineView.hidden = YES;
            break;
    }
}

- (UIView *)separatorLineView
{
    if (!_separatorLineView) {
        _separatorLineView = [[UIView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_separatorLineView];
    }
    return _separatorLineView;
}

@end
