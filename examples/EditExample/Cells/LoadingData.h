//
//  LoadingData.h
//  Example
//

#import <GPJDataDrivenTableView/GPJDataDrivenTableView.h>

@interface LoadingData : GPJTableViewData
@property (nonatomic, assign) CGFloat height;
+ (instancetype)loadingDataWithHeight:(CGFloat)height;
@end

@interface LoadingCell : GPJTableViewCell
@property (nonatomic, strong) UIActivityIndicatorView *loadingIndicatorView;
@end
