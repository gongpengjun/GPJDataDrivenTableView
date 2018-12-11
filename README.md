# GPJDataDrivenTableView

## Description

__GPJDataDrivenTableView__ is a data-driven way to use UITableView. It is easy to use. It is friendly to evolve with change of requirements.

## Installation

### CocoaPods

```ruby
pod 'GPJDataDrivenTableView'
```

### Manual

1. download the GPJDataDrivenTableView repository
2. copy the GPJDataDrivenTableView sub-folder into your Xcode project

## Usage

```objectivec
#import <GPJDataDrivenTableView/GPJDataDrivenTableView.h>

GPJDataDrivenTableView *dataDrivenTableView = [[GPJDataDrivenTableView alloc] initWithFrame:self.view.bounds];
dataDrivenTableView.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

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

## Example

- [Basic Usage Example](examples/BasicExample)

[![screenshot_basic_small](https://user-images.githubusercontent.com/278430/49798835-40d1d480-fd7e-11e8-8fe7-14592602353a.png)](https://user-images.githubusercontent.com/278430/49798837-416a6b00-fd7e-11e8-915c-b00abf7812b2.png)

- [Flexible Cells Example](examples/FlexibleCellExample)

[![screenshot_flex_1_small](https://user-images.githubusercontent.com/278430/49798852-44fdf200-fd7e-11e8-89be-ea105deb2f71.png)](https://user-images.githubusercontent.com/278430/49798853-44fdf200-fd7e-11e8-86c3-dca79e8ebc47.png)
[![screenshot_flex_2_small](https://user-images.githubusercontent.com/278430/49798854-45968880-fd7e-11e8-9f0c-3fe058ef2eca.png)](https://user-images.githubusercontent.com/278430/49798858-462f1f00-fd7e-11e8-8664-526c6653e0db.png)
[![screenshot_flex_3_small](https://user-images.githubusercontent.com/278430/49798859-462f1f00-fd7e-11e8-9d04-b3b0cfa2723e.png)](https://user-images.githubusercontent.com/278430/49798861-46c7b580-fd7e-11e8-8b68-c09a9de9f114.png)
[![screenshot_flex_4_small](https://user-images.githubusercontent.com/278430/49798862-46c7b580-fd7e-11e8-85d7-1c4eafab5984.png)](https://user-images.githubusercontent.com/278430/49798863-47604c00-fd7e-11e8-9247-fffe568c87c2.png)

- [Edit Cell Example](examples/EditExample)

[![screenshot_edit_1_small](https://user-images.githubusercontent.com/278430/49798841-42030180-fd7e-11e8-9eb2-00edccf1a455.png)](https://user-images.githubusercontent.com/278430/49798843-429b9800-fd7e-11e8-840c-f19eb538261f.png)
[![screenshot_edit_2_small](https://user-images.githubusercontent.com/278430/49798844-429b9800-fd7e-11e8-906a-eec59758cd31.png)](https://user-images.githubusercontent.com/278430/49798845-43342e80-fd7e-11e8-9365-cc5d8dd47829.png)
[![screenshot_edit_3_small](https://user-images.githubusercontent.com/278430/49798848-43ccc500-fd7e-11e8-832b-bd17093dffb6.png)](https://user-images.githubusercontent.com/278430/49798849-43ccc500-fd7e-11e8-9f63-958e781977c5.png)
[![screenshot_edit_4_small](https://user-images.githubusercontent.com/278430/49798850-44655b80-fd7e-11e8-84c7-cb1e659692f5.png)](https://user-images.githubusercontent.com/278430/49798851-44655b80-fd7e-11e8-851a-9631a2928f1e.png)

## Origin

The traditional way is index-driven, we implement the UITableViewDataSource's or UITableViewDelegate's methods base on __indexPath__:

- `-tableView:cellForRowAtIndexPath:`
- `-tableView:heightForRowAtIndexPath:`
- `-tableView:didSelectRowAtIndexPath:`

This index-driven way based on __indexPath__ results a lot of `if-else` code segments, Various cells' code mix together. it is error-prone, hard to evolve with change of requirements.

[![uitableview_indexdriven](https://user-images.githubusercontent.com/278430/49796885-dc604680-fd78-11e8-9e4f-90fbf842c680.png)](docs/UITableView_IndexDriven.png)

The core role of data-driven way to use UITableView is GPJDataDrivenTableView class. GPJDataDrivenTableView contains UITableView instance and a dataArray, GPJDataDrivenTableView set itself as UITableView's dataSource and delegate, implement the protocol methods, and covert ___indexPath___ to ___data___ in dataArray. Finally we can render cell ui and respond to row selection based on ___data___. 

[![uitableview_datadriven](https://user-images.githubusercontent.com/278430/49796884-dbc7b000-fd78-11e8-80da-604e2796673f.png)](docs/UITableView_DataDriven.png)


This data-driven way is simple, easy to implement each kind of data, cell, and select action separately.
