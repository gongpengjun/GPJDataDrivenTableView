//
//  GPJGapData.m
//
//  Created by gongpengjun <frank.gongpengjun@gmail.com>
//

#import "GPJGapData.h"

@implementation GPJGapData

- (CGFloat)cellHeight
{
    return self.height;
}

+ (instancetype)gapDataWithHeight:(CGFloat)height
{
    GPJGapData *data = [[self alloc] init];
    data.height = height;
    return data;
}

@end

@implementation GPJGapCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end
