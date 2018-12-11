//
//  ColorData.m
//  Example
//

#import "ColorData.h"
#import <Masonry/Masonry.h>

@implementation ColorData

- (CGFloat)cellHeight
{
    return 60.0f;
}

@end

@implementation ColorCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.colorView = [[UIView alloc] init];
        [self.contentView addSubview:self.colorView];
        
        [self.colorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)configCell
{
    ColorData *data = self.data;
    self.colorView.backgroundColor = data.bgColor;
}

@end
