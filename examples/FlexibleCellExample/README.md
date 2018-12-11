# Flexible Cells Example of GPJDataDrivenTableView

iOS Example App to demonstrate flexible various cells using GPJDataDrivenTableView.

## Screenshots

[![screenshot_flex_1_small](https://user-images.githubusercontent.com/278430/49798852-44fdf200-fd7e-11e8-89be-ea105deb2f71.png)](https://user-images.githubusercontent.com/278430/49798853-44fdf200-fd7e-11e8-86c3-dca79e8ebc47.png)
[![screenshot_flex_2_small](https://user-images.githubusercontent.com/278430/49798854-45968880-fd7e-11e8-9f0c-3fe058ef2eca.png)](https://user-images.githubusercontent.com/278430/49798858-462f1f00-fd7e-11e8-8664-526c6653e0db.png)
[![screenshot_flex_3_small](https://user-images.githubusercontent.com/278430/49798859-462f1f00-fd7e-11e8-9d04-b3b0cfa2723e.png)](https://user-images.githubusercontent.com/278430/49798861-46c7b580-fd7e-11e8-8b68-c09a9de9f114.png)
[![screenshot_flex_4_small](https://user-images.githubusercontent.com/278430/49798862-46c7b580-fd7e-11e8-85d7-1c4eafab5984.png)](https://user-images.githubusercontent.com/278430/49798863-47604c00-fd7e-11e8-9247-fffe568c87c2.png)

## Code Example

```objectivec
#import <GPJDataDrivenTableView/UITableView+GPJDataDriven.h>

UITableView *dataDrivenTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
dataDrivenTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

NSMutableArray *dataArray = [NSMutableArray array];
{
	ActionData *actionData = [ActionData new];
	actionData.didSelectAction = ^(id data) {
	    [weakSelf actionCellReloadAction:data];
	};
	[dataArray addObject:actionData];
}
{
	ColorData *data = [ColorData new];
	data.didSelectAction = ^(id data) {
	    [weakSelf colorCellAction:data];
	};
	[dataArray addObject:data];
}
[dataDrivenTableView reloadDataArray:dataArray];
```

## Example Usage

```
$ git clone git@github.com:gongpengjun/GPJDataDrivenTableViewExample.git
$ cd GPJDataDrivenTableView/examples/FlexibleCellExample
$ pod install
$ open Example.xcworkspace
$ build and run (⌘R)
```
