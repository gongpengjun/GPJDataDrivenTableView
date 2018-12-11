# Basic Usage Example of GPJDataDrivenTableView

iOS Example App to demonstrate basic usage of GPJDataDrivenTableView.

## Screenshot

[![screenshot_basic_small](https://user-images.githubusercontent.com/278430/49798835-40d1d480-fd7e-11e8-8fe7-14592602353a.png)](https://user-images.githubusercontent.com/278430/49798837-416a6b00-fd7e-11e8-915c-b00abf7812b2.png)

## Code Example

```objectivec
#import <GPJDataDrivenTableView/UITableView+GPJDataDriven.h>

UITableView *dataDrivenTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
dataDrivenTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
$ cd GPJDataDrivenTableView/examples/BasicExample
$ pod install
$ open Example.xcworkspace
$ build and run (⌘R)
```
