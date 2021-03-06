//
//  AppDelegate.m
//  V2Client
//
//  Created by summer on 2019/1/22.
//  Copyright © 2019年 sandrew. All rights reserved.
//

#import "AppDelegate.h"
#import "TopicViewController.h"
#import "MMDrawerController.h"
#import "LeftMenuController.h"
#import "V2exUser.h"
#import "V2exControllerHolder.h"
#import "HBDNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    TopicViewController *mainController = [[TopicViewController alloc] init];
    mainController.title = @"V2EX";
    //self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:mainController];
    
    /*********************************************************************/
    //UINavigationController *mainContainer = [[UINavigationController alloc] initWithRootViewController:mainController];
    HBDNavigationController *mainContainer = [[HBDNavigationController alloc] initWithRootViewController:mainController];
    LeftMenuController *leftDrawer = [[LeftMenuController alloc] init];
    //leftDrawer.view = [[LeftMenuView alloc] init];
    UIViewController * rightDrawer = [[UIViewController alloc] init];
    rightDrawer.view.backgroundColor = [UIColor greenColor];
    
    MMDrawerController *drawerController = [[MMDrawerController alloc]
                                             initWithCenterViewController:mainContainer
                                             leftDrawerViewController:leftDrawer
                                             rightDrawerViewController:rightDrawer];
    drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModePanningCenterView;
    drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    drawerController.maximumLeftDrawerWidth = 180;
    self.window.rootViewController = drawerController;
    [V2exControllerHolder shareInstance].centerViewController = mainContainer;
    [V2exControllerHolder shareInstance].drawerController = drawerController;
    /*********************************************************************/

    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
