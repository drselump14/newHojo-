//
//  AppDelegate.m
//  hojo!
//
//  Created by slamet kristanto on 1/12/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import "AppDelegate.h"
#import "Player.h"
#import "DiaryViewController.h"

@implementation AppDelegate{
    NSMutableArray *players;
}

@synthesize window = _window;
@synthesize workData;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    workData=[[NSString alloc]initWithString:@"種まき"];
    players =[NSMutableArray arrayWithCapacity:20];
    Player *player =[[Player alloc] init];
    player.workName=@"種まき";
    player.crop=@"キャベツ";
    player.hojo=@"圃場A";
    player.startTime=@"08:30";
    player.finishTime=@"09:30";
    [players addObject:player];
    player=[[Player alloc] init];
    player.workName=@"収穫";
    player.crop=@"タマネギ";
    player.hojo=@"圃場B";
    player.startTime=@"09:30";
    player.finishTime=@"10:30";
    [players addObject:player];
    player=[[Player alloc] init];
    player.workName=@"水やり";
    player.crop=@"レタス";
    player.hojo=@"圃場A";
    player.startTime=@"10:30";
    player.finishTime=@"11:30";
    [players addObject:player];
    UITabBarController *tabBarController = 
    (UITabBarController *)self.window.rootViewController;
	UINavigationController *navigationController = 
    [[tabBarController viewControllers] objectAtIndex:0];
	DiaryViewController *playersViewController = 
    [[navigationController viewControllers] objectAtIndex:0];
	playersViewController.players = players;
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
