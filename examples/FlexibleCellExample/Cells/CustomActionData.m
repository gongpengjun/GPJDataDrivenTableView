//
//  CustomActionData.m
//  Example
//

#import "CustomActionData.h"
#import <Masonry/Masonry.h>

@implementation CustomActionData

- (CGFloat)cellHeight
{
    return 60.0f;
}

@end

@implementation CustomActionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubViews];
        [self configConstraints];
    }
    return self;
}

- (void)setupSubViews
{
    self.bgView = [[UIView alloc] init];
    self.bgView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.bgView];
    
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.leftButton.backgroundColor = [UIColor blueColor];
    [self.leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.leftButton];
    
    self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.rightButton.backgroundColor = [UIColor blueColor];
    [self.rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.rightButton];
}

- (void)configConstraints
{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(20);
        make.centerY.equalTo(self.bgView);
        make.height.equalTo(self.bgView).offset(-20);
        make.width.equalTo(self.bgView).dividedBy(3);
    }];
    
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(-20);
        make.centerY.equalTo(self.bgView);
        make.height.equalTo(self.bgView).offset(-20);
        make.width.equalTo(self.bgView).dividedBy(3);
    }];
}

- (void)configCell
{
    CustomActionData *customData = self.data;
    [self.leftButton setTitle:customData.leftButtonName forState:UIControlStateNormal];
    [self.rightButton setTitle:customData.rightButtonName forState:UIControlStateNormal];
}

- (void)leftButtonAction:(UIButton *)button
{
    CustomActionData *data = self.data;
    if (data.leftButtonAction) {
        data.leftButtonAction(data);
    }
}

- (void)rightButtonAction:(UIButton *)button
{
    CustomActionData *data = self.data;
    if (data.rightButtonAction) {
        data.rightButtonAction(data);
    }
}

@end
