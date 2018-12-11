//
//  LoadingData.h
//  Example
//

#import <GPJDataDrivenTableView/GPJDataDrivenTableView.h>

@interface LoadingData : GPJBaseData
@property (nonatomic, assign) CGFloat height;
+ (instancetype)loadingDataWithHeight:(CGFloat)height;
@end

@interface LoadingCell : GPJBaseCell
@property (nonatomic, strong) UIActivityIndicatorView *loadingIndicatorView;
@end