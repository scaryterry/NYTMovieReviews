//
//  AppDelegate.m
//  Movie Reviews
//
//  Created by Christos C on 07/08/2015.
//  Copyright (c) 2015 testCompany Development. All rights reserved.
//

#import "AppDelegate.h"
#import <AFNetworking.h>
#import <MagicalRecord/MagicalRecord.h>

@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"Model"];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [self setupGlobalUIPreferences];
    return YES;
}

/**
 *  Uses UIAppearance methods to customize elements throughout the app
 */
-(void)setupGlobalUIPreferences
{
    //set title colour for all navigation contollers
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], NSForegroundColorAttributeName,nil]];

    //set button colour for all navigation contollers
    [[UINavigationBar appearance] setTintColor: [UIColor whiteColor] ];
    
     //set the colour for all navigation bars
    [[UINavigationBar appearance ] setBarTintColor:[UIColor orangeColor] ];
    // set seperator insets for all tableviews
    [[UITableView appearance] setSeparatorInset:UIEdgeInsetsZero];
    [[UITableViewCell appearance] setSeparatorInset:UIEdgeInsetsZero];
    // iOS 8:
    if ([UITableView instancesRespondToSelector:@selector(setLayoutMargins:)])
    {
        [[UINavigationBar appearance] setTranslucent:false];
        [[UITabBar appearance] setTranslucent:false];
        
        [[UITableView appearance] setLayoutMargins:UIEdgeInsetsZero];
        [[UITableViewCell appearance] setLayoutMargins:UIEdgeInsetsZero];
        [[UITableViewCell appearance] setPreservesSuperviewLayoutMargins:NO];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [MagicalRecord cleanUp];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
//    [MagicalRecord cleanUp];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//    [MagicalRecord cleanUp];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
//    [MagicalRecord setupAutoMigratingCoreDataStack];

//    [MagicalRecord cleanUp];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//    [MagicalRecord setupCoreDataStackWithStoreNamed:@"Model"];

}


@end
