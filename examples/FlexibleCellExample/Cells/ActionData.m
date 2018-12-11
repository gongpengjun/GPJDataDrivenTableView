//
//  ActionData.m
//  Example
//

#import "ActionData.h"
#import <Masonry/Masonry.h>

@implementation ActionData

- (CGFloat)cellHeight
{
    return 60.0f;
}

@end

@implementation ActionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:bgView];
        
        self.actionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.actionLabel.font = [UIFont boldSystemFontOfSize:20];
        [self.contentView addSubview:self.actionLabel];
        
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
        [self.actionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)configCell
{
    ActionData *actionData = self.data;
    self.actionLabel.text = actionData.actionName;
}

@end
