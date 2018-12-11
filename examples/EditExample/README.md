# Edit Cell Example of GPJDataDrivenTableView

iOS Example App to demonstrate edit cell using GPJDataDrivenTableView.

## Screenshots

[![screenshot_edit_1_small](https://user-images.githubusercontent.com/278430/49798841-42030180-fd7e-11e8-9eb2-00edccf1a455.png)](https://user-images.githubusercontent.com/278430/49798843-429b9800-fd7e-11e8-840c-f19eb538261f.png)
[![screenshot_edit_2_small](https://user-images.githubusercontent.com/278430/49798844-429b9800-fd7e-11e8-906a-eec59758cd31.png)](https://user-images.githubusercontent.com/278430/49798845-43342e80-fd7e-11e8-9365-cc5d8dd47829.png)
[![screenshot_edit_3_small](https://user-images.githubusercontent.com/278430/49798848-43ccc500-fd7e-11e8-832b-bd17093dffb6.png)](https://user-images.githubusercontent.com/278430/49798849-43ccc500-fd7e-11e8-9f63-958e781977c5.png)
[![screenshot_edit_4_small](https://user-images.githubusercontent.com/278430/49798850-44655b80-fd7e-11e8-84c7-cb1e659692f5.png)](https://user-images.githubusercontent.com/278430/49798851-44655b80-fd7e-11e8-851a-9631a2928f1e.png)

## Code Example

```objectivec
#import <GPJDataDrivenTableView/GPJDataDrivenTableView.h>

GPJDataDrivenTableView *dataDrivenTableView = [[GPJDataDrivenTableView alloc] initWithFrame:self.view.bounds];
dataDrivenTableView.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
dataDrivenTableView.dataSource = self;
dataDrivenTableView.delegate = self;
[self.view addSubview:dataDrivenTableView];

NSMutableArray *dataArray = [NSMutableArray array];
for (UIColor *color in self.colorsArray)
{
	ColorData *data = [ColorData new];
	data.bgColor = color;
	data.didSelectAction = ^(id data) {
	    [weakSelf colorCellAction:data];
	};
	[dataArray addObject:data];
}
[dataDrivenTableView reloadDataArray:dataArray];
```

## Example Usage

```
$ git clone git@github.com:gongpengjun/GPJDataDrivenTableView.git
$ cd GPJDataDrivenTableView/examples/EditExample
$ pod install
$ open Example.xcworkspace
$ build and run (⌘R)
```
