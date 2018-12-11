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
            make.left.equalTo(self.contentView).offset(20);
            make.right.equalTo(self.contentView).offset(-20);
            make.top.equalTo(self.contentView).offset(5);
            make.bottom.equalTo(self.contentView).offset(-5);
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
