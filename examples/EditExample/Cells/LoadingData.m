//
//  LoadingData.m
//  Example
//

#import "LoadingData.h"
#import <Masonry/Masonry.h>

@implementation LoadingData

- (CGFloat)cellHeight
{
    return self.height;
}

+ (instancetype)loadingDataWithHeight:(CGFloat)height
{
    LoadingData *data = [[self alloc] init];
    data.height = height;
    return data;
}

@end

@implementation LoadingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.loadingIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.loadingIndicatorView.color = [UIColor colorWithRed:139/255.0f green:139/255.0f blue:139/255.0f alpha:1.0f];
        [self.contentView addSubview:self.loadingIndicatorView];
        
        [self.loadingIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.centerY.equalTo(self.contentView).offset(-50);
        }];
    }
    return self;
}

- (void)configCell
{
    [self.loadingIndicatorView startAnimating];
}

@end
