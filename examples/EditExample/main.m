#import <UIKit/UIKit.h>
#import "MainViewController.h"

int main(int argc, char *argv[])
{
    @autoreleasepool
    {
        int retVal = UIApplicationMain(argc, argv, nil, @"AppDelegate");
        return retVal;
    }
}

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic, strong) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    {
        MainViewController *mainViewController = [[MainViewController alloc] initWithNibName:nil bundle:nil];
        mainViewController.edgesForExtendedLayout = UIRectEdgeNone;
        
        self.navigationController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
        self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
        self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    }
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end

