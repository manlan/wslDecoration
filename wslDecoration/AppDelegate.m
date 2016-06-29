//
//  AppDelegate.m
//  wslDecoration
//
//  Created by 易工 on 15/12/8.
//  Copyright © 2015年 WSL. All rights reserved.
//

#import "AppDelegate.h"
#import "wslNavigationController.h"
#import "MyTabBarController.h"
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "landViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
//    MyTabBarController * myTab = [[MyTabBarController alloc] init];
//    self.window.rootViewController = myTab;
    
    landViewController * landVC = [[landViewController alloc] init];
    wslNavigationController * landNa = [[wslNavigationController alloc] initWithRootViewController:landVC];
    self.window.rootViewController = landNa;
    
    [self.window makeKeyAndVisible];
    
    //设置友盟AppKey
    [UMSocialData setAppKey:@"507fcab25270157b37000010"];
    
    //设置分享到QQ/Qzone的应用Id，和分享url 链接
   [UMSocialQQHandler setQQWithAppId:@"1105015310" appKey:@"3amibiEbZdpJR2SN" url:@"http://www.yg-technology.com"];
    //设置支持没有客户端情况下使用SSO授权
    [UMSocialQQHandler setSupportWebView:YES];
    
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:@"wxcbeaebfd08a63b4f" appSecret:@"4f50be76dce1cb893a4951b694312c19" url:@"http://www.yg-technology.com"];
    
    return YES;
}

#pragma mark - 第三方登录回调方法

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
