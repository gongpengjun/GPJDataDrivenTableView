#import "MainViewController.h"
#import <Masonry/Masonry.h>
#import <randomColor/UIColor+randomColor.h>
#import <GPJDataDrivenTableView/GPJDataDrivenTableView.h>
#import <GPJDataDrivenTableView/GPJGapData.h>
#import "ColorData.h"
#import "LoadingData.h"
#import "ActionData.h"
#import "CustomActionData.h"

@interface MainViewController ()
@property (nonatomic, strong) UIBarButtonItem         *refreshButtonItem;
@property (nonatomic, strong) GPJDataDrivenTableView  *dataDrivenTableView;
@property (nonatomic, strong) NSArray                 *colorsArray;
@end

@implementation MainViewController

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Flexible Cell Example";
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

    // setup dataDrivenTableView
    self.dataDrivenTableView = [[GPJDataDrivenTableView alloc] initWithFrame:self.view.bounds];
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
    // Show Loading Cell
    LoadingData *loadingData = [LoadingData loadingDataWithHeight:self.dataDrivenTableView.bounds.size.height];
    [self.dataDrivenTableView reloadDataArray:@[loadingData]];
    // Disable `refresh` button
    self.refreshButtonItem.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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

    [dataArray addObject:[GPJGapData gapDataWithHeight:15.0f]];

    { // Top Cell, Show "Reload"
        ActionData *actionData = [ActionData new];
        actionData.actionName = @"Reload";
        actionData.didSelectAction = ^(id data) {
            [weakSelf actionCellReloadAction:data];
        };
        [dataArray addObject:actionData];
    }

    [dataArray addObject:[GPJGapData gapDataWithHeight:15.0f]];
    
    { // Custom Action Cell, Show "Hello" and "World"
        CustomActionData *customActionData = [CustomActionData new];
        customActionData.leftButtonName = @"Hello";
        customActionData.leftButtonAction = ^(CustomActionData *data) {
            [[[UIAlertView alloc] initWithTitle:data.leftButtonName message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        };
        customActionData.rightButtonName = @"World";
        customActionData.rightButtonAction = ^(CustomActionData *data) {
            [[[UIAlertView alloc] initWithTitle:data.rightButtonName message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        };
        [dataArray addObject:customActionData];
    }
    
    [dataArray addObject:[GPJGapData gapDataWithHeight:15.0f]];

    for (NSUInteger i = 0; i < self.colorsArray.count; i++)
    { // Other Cells, show real model info: various color
        UIColor *color = self.colorsArray[i];
        ColorData *data = [ColorData new];
        data.bgColor = color;
        data.didSelectAction = ^(id data) {
            [weakSelf colorCellAction:data];
        };
        data.backgroundViewInset = UIEdgeInsetsMake(0, 10, 0, 10);
        data.separatorPosition = GPJCellSeparatorPositionBottom;
        data.separatorInset = UIEdgeInsetsMake(0, 10.0, 0, 10.0);
        data.separatorColor = [UIColor colorWithRed:0xF0/255.0f green:0xF0/255.0f blue:0xF0/255.0f alpha:1.0];
        if (i == 0) {
            data.backgroundViewCornerRadius = 10.0f;
            data.backgroundViewCorners = UIRectCornerTopLeft|UIRectCornerTopRight;
        } else if ( i == self.colorsArray.count - 1) {
            data.backgroundViewCornerRadius = 10.0f;
            data.backgroundViewCorners = UIRectCornerBottomLeft|UIRectCornerBottomRight;
            data.separatorPosition = GPJCellSeparatorPositionNone;
        } else {
            data.backgroundViewCorners = 0;
        }
        [dataArray addObject:data];

        //[dataArray addObject:[GPJGapData gapDataWithHeight:10.0f]];
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

