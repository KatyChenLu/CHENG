//
//  AppDelegate.m
//  CiShanZhong
//
//  Created by KatyChn on 15/12/25.
//  Copyright © 2015年 陈璐. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarViewController.h"
#import "SettingLeftViewController.h"
#import "SearchViewController.h"
#import "ListViewController.h"
#import <UMengSocial/UMSocial.h>
#import <WXApi.h>
#import <UMSocialSinaSSOHandler.h>
#import <UMSocialWechatHandler.h>
#import "LaunchViewController.h"
@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate{
    UINavigationController *_navigationController;
    
}
- (void)setupRootViewController:(UIViewController *)viewController {
    self.window.rootViewController = viewController;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
     [UMSocialData setAppKey:@"56976f2467e58ecf2b001d97"];

    [UMSocialWechatHandler setWXAppId:@"wx1ceafe09854d76b3" appSecret:@"b5d09a1c248df3b76395a81b59b4347b" url:nil];

    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"2194776238" RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
 
    SettingLeftViewController *settingViewController = [[SettingLeftViewController alloc] init];
    SearchViewController *seaarchViewController = [[SearchViewController alloc] init];
    
     _tabbarController = [[TabBarViewController alloc] init];
    
    _sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:_tabbarController leftMenuViewController:settingViewController rightMenuViewController:seaarchViewController];
    _sideMenuViewController.backgroundImage = [UIImage imageNamed:@"01"];
    _sideMenuViewController.menuPreferredStatusBarStyle = 1; // UIStatusBarStyleLightContent
    _sideMenuViewController.delegate = self;
    _sideMenuViewController.contentViewShadowColor = [UIColor blackColor];
    _sideMenuViewController.contentViewShadowOffset = CGSizeMake(0, 0);
    _sideMenuViewController.contentViewShadowOpacity = 0.6;
    _sideMenuViewController.contentViewShadowRadius = 12;
    _sideMenuViewController.contentViewShadowEnabled = YES;
    _sideMenuViewController.bgName = @"01";
    [self setupRootViewController:[[LaunchViewController alloc] initWithCoder:nil]];

    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
    }
    else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    }
    
       [self.window makeKeyAndVisible];

    return YES;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [WXApi handleOpenURL:url delegate:self];
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
//    return  [WXApi handleOpenURL:url delegate:self];
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
    
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
