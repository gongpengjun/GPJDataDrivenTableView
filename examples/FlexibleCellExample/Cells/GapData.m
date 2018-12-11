//
//  PaddingData.m
//  Example
//

#import "GapData.h"

@implementation GapData

- (CGFloat)cellHeight
{
    return self.height;
}

+ (instancetype)gapDataWithHeight:(CGFloat)height
{
    GapData *data = [[self alloc] init];
    data.height = height;
    return data;
}

@end

@implementation GapCell

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
