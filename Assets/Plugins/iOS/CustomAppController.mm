// CustomAppController.mm

#import  "UnityAppController.h"
#import "WXApiManager.h"

@interface CustomAppController : UnityAppController
@end

IMPL_APP_CONTROLLER_SUBCLASS (CustomAppController)

@implementation CustomAppController

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
	[super application:application didFinishLaunchingWithOptions:launchOptions];
    	
    [WXApi registerApp:@"你的APPID" universalLink:@"你的UniversalLink"];
    	
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray<id<UIUserActivityRestoring>> * __nullable restorableObjects))restorationHandler
{
    return [WXApi handleOpenUniversalLink:userActivity delegate:[WXApiManager sharedManager]];
}

@end