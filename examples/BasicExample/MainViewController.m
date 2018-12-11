#import "MainViewController.h"
#import <Masonry/Masonry.h>
#import <randomColor/UIColor+randomColor.h>
#import <GPJDataDrivenTableView/UITableView+GPJDataDriven.h>
#import "ColorData.h"

@interface MainViewController ()
@property (nonatomic, strong) UIBarButtonItem         *refreshButtonItem;
@property (nonatomic, strong) UIActivityIndicatorView *loadingIndicatorView;
@property (nonatomic, strong) UITableView             *dataDrivenTableView;
@property (nonatomic, strong) NSArray                 *colorsArray;
@end

@implementation MainViewController

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Basic Example";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupSubViews];
    [self loadModel];
}

- (void)setupSubViews
{
    // setup refresh button
    self.refreshButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshButtonItemAction:)];
    self.navigationItem.rightBarButtonItems = @[self.refreshButtonItem];

    // setup loadingIndicatorView
    self.loadingIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.loadingIndicatorView.color = [UIColor colorWithRed:139/255.0f green:139/255.0f blue:139/255.0f alpha:1.0f];
    [self.view addSubview:self.loadingIndicatorView];
    
    [self.loadingIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-50);
    }];

    // setup dataDrivenTableView
    self.dataDrivenTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.dataDrivenTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.dataDrivenTableView];
    
    [self.dataDrivenTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

#pragma mark - Model

- (void)loadModel
{
    // Show loading indicator view
    self.loadingIndicatorView.hidden = NO;
    [self.loadingIndicatorView startAnimating];
    // Hide table view
    self.dataDrivenTableView.hidden = YES;
    // Disable `refresh` button
    self.refreshButtonItem.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // Hide loading indicator view
        [self.loadingIndicatorView stopAnimating];
        self.loadingIndicatorView.hidden = YES;
        // Show table view
        self.dataDrivenTableView.hidden = NO;
        // Enable `refresh` button
        self.refreshButtonItem.enabled = YES;
        // Set model
        self.colorsArray = [UIColor randomColorsWithLuminosity:YGColorLuminosityBright count:15];
        // Show model cells
        [self modelDidLoad];
    });
}

- (void)modelDidLoad
{
    NSMutableArray *dataArray = [NSMutableArray array];
    
    __weak typeof(self) weakSelf = self;

    for (UIColor *color in self.colorsArray)
    { // Other Cells, show real model info: various color
        ColorData *data = [ColorData new];
        data.bgColor = color;
        data.didSelectAction = ^(id data) {
            [weakSelf colorCellAction:data];
        };
        [dataArray addObject:data];
    }

    [self.dataDrivenTableView reloadDataArray:dataArray];
}

#pragma mark - Actions

- (void)refreshButtonItemAction:(id)sender
{
    [self loadModel];
}

- (void)actionCellReloadAction:(id)data
{
    [self loadModel];
}

- (void)colorCellAction:(id)data
{
    ColorData *colorData = data;
    
    NSUInteger index = [self.colorsArray indexOfObject:colorData.bgColor];
    if (index == NSNotFound) {
        return;
    }

    NSMutableArray *tempArray = [self.colorsArray mutableCopy];
    tempArray[index] = [UIColor randomColorWithLuminosity:YGColorLuminosityBright];
    self.colorsArray = tempArray;
    
    [self modelDidLoad];
}

@end

