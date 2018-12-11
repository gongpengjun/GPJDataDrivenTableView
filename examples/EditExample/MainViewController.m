#import "MainViewController.h"
#import <Masonry/Masonry.h>
#import <randomColor/UIColor+randomColor.h>
#import <GPJDataDrivenTableView/GPJDataDrivenTableView.h>
#import "LoadingData.h"
#import "ColorData.h"

@interface MainViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UIBarButtonItem *addBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *editBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *doneBarButtonItem;
@property (nonatomic, strong) GPJDataDrivenTableView *dataDrivenTableView;
@property (nonatomic, strong) NSArray *colorsArray;
@end

@implementation MainViewController

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Edit Example";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupSubViews];
    [self loadModel];
}

- (void)setupSubViews
{
    self.addBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonItemAction:)];
    self.navigationItem.leftBarButtonItems = @[self.addBarButtonItem];
    
    self.doneBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonItemAction:)];
    self.editBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButtonItemAction:)];
    self.navigationItem.rightBarButtonItems = @[self.editBarButtonItem];

    self.dataDrivenTableView = [[GPJDataDrivenTableView alloc] initWithFrame:self.view.bounds];
    self.dataDrivenTableView.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.dataDrivenTableView.dataSource = self;
    self.dataDrivenTableView.delegate = self;
    [self.view addSubview:self.dataDrivenTableView];
    
    [self.dataDrivenTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

#pragma mark - Model

- (void)loadModel
{
    // Show Loading Cell Only
    LoadingData *loadingData = [LoadingData loadingDataWithHeight:self.dataDrivenTableView.bounds.size.height];
    [self.dataDrivenTableView reloadDataArray:@[loadingData]];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.colorsArray = [UIColor randomColorsWithLuminosity:YGColorLuminosityBright count:5];
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

- (void)addButtonItemAction:(id)sender
{
    NSMutableArray *tempColorArray = [self.colorsArray mutableCopy];
    UIColor *newColor = [UIColor randomColorWithLuminosity:YGColorLuminosityBright];
    [tempColorArray addObject:newColor];
    self.colorsArray = tempColorArray;
    [self modelDidLoad];
}

- (void)editButtonItemAction:(id)sender
{
    self.dataDrivenTableView.tableView.editing = YES;
    self.navigationItem.rightBarButtonItems = @[self.doneBarButtonItem];
}

- (void)doneButtonItemAction:(id)sender
{
    self.dataDrivenTableView.tableView.editing = NO;
    self.navigationItem.rightBarButtonItems = @[self.editBarButtonItem];
}

- (void)actionCellReloadAction:(id)data
{
    [self loadModel];
}

- (void)actionCellResizeAction:(id)data
{
    if (self.dataDrivenTableView.frame.size.height > self.view.bounds.size.height / 2) {
        [self.dataDrivenTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(-self.view.bounds.size.height/2);
        }];
    } else {
        [self.dataDrivenTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.view);
            make.bottom.equalTo(self.view);
        }];
    }
    [self.dataDrivenTableView layoutIfNeeded];
    [self.dataDrivenTableView reloadData];

    NSInteger index = [self.dataDrivenTableView.dataArray indexOfObject:data];
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.dataDrivenTableView.tableView scrollToRowAtIndexPath:lastIndexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
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

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataDrivenTableView tableView:tableView numberOfRowsInSection:section];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return [self.dataDrivenTableView tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    id data = [self.dataDrivenTableView dataForIndexPath:indexPath];
    if ([data isKindOfClass:[ColorData class]]) {
        return YES;
    }
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    id data = [self.dataDrivenTableView dataForIndexPath:indexPath];
    if ([data isKindOfClass:[ColorData class]]) {
        return YES;
    }
    return NO;
}

// After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change
// Not called for edit actions using UITableViewRowAction - the action's handler will be invoked instead
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *commitEditing = @"";
    switch (editingStyle) {
        case UITableViewCellEditingStyleDelete:
            commitEditing = @"UITableViewCellEditingStyleDelete";
            break;
        case UITableViewCellEditingStyleInsert:
            commitEditing = @"UITableViewCellEditingStyleInsert";
            break;
        default:
        case UITableViewCellEditingStyleNone:
            commitEditing = @"UITableViewCellEditingStyleNone";
            break;
    }
    NSLog(@"%s,%d row:%@ %@", __FUNCTION__, __LINE__, @(indexPath.row), commitEditing);
    
    if (UITableViewCellEditingStyleDelete == editingStyle)
    {
        id data = [self.dataDrivenTableView.dataArray objectAtIndex:indexPath.row];
        if ([data isKindOfClass:[ColorData class]]) {
            ColorData *colorData = data;
            NSUInteger index = [self.colorsArray indexOfObject:colorData.bgColor];
            if (index != NSNotFound) {
                NSMutableArray *tempColorArray = [self.colorsArray mutableCopy];
                [tempColorArray removeObjectAtIndex:index];
                self.colorsArray = tempColorArray;
            }
            [self modelDidLoad];
        }
    }
        
    if (UITableViewCellEditingStyleInsert == editingStyle)
    {
        id data = [self.dataDrivenTableView.dataArray objectAtIndex:indexPath.row];
        if ([data isKindOfClass:[ColorData class]]) {
            ColorData *colorData = data;
            NSUInteger index = [self.colorsArray indexOfObject:colorData.bgColor];
            if (index != NSNotFound) {
                NSMutableArray *tempColorArray = [self.colorsArray mutableCopy];
                UIColor *newColor = [UIColor randomColorWithLuminosity:YGColorLuminosityBright];
                [tempColorArray insertObject:newColor atIndex:index];
                self.colorsArray = tempColorArray;
                [self modelDidLoad];
            }
        }
    }
}

// Data manipulation - reorder / moving support
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSLog(@"%s,%d sourceIndexPath:%@ destinationIndexPath:%@", __FUNCTION__, __LINE__, @(sourceIndexPath.row), @(destinationIndexPath.row));
    if (sourceIndexPath.row == destinationIndexPath.row) {
        return;
    }
    
    id srcData = [self.dataDrivenTableView dataForIndexPath:sourceIndexPath];
    if (![srcData isKindOfClass:[ColorData class]]) {
        return;
    }
    
    ColorData *srcColorData = srcData;
    NSUInteger srcColorIndex = [self.colorsArray indexOfObject:srcColorData.bgColor];
    if (srcColorIndex == NSNotFound) {
        return;
    }

    NSMutableArray *tempColorArray = [self.colorsArray mutableCopy];
    [tempColorArray removeObjectAtIndex:srcColorIndex];
    id dstData = [self.dataDrivenTableView dataForIndexPath:destinationIndexPath];
    if ([dstData isKindOfClass:[ColorData class]]) {
        ColorData *dstColorData = dstData;
        NSUInteger dstColorIndex = [self.colorsArray indexOfObject:dstColorData.bgColor];
        if (dstColorIndex != NSNotFound) {
            [tempColorArray insertObject:srcColorData.bgColor atIndex:dstColorIndex];
        } else {
            [tempColorArray addObject:srcColorData.bgColor];
        }
    } else {
        [tempColorArray addObject:srcColorData.bgColor];
    }
    self.colorsArray = tempColorArray;
    [self modelDidLoad];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.navigationItem.rightBarButtonItems = @[self.doneBarButtonItem];
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(nullable NSIndexPath *)indexPath
{
    self.navigationItem.rightBarButtonItems = @[self.editBarButtonItem];
}

@end

