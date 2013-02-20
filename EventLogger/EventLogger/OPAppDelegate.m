//
//  OPAppDelegate.m
//  EventLogger
//
//  Created by Alexander Massolle on 04.02.13.
//  Copyright (c) 2013 Brockhaus AG. All rights reserved.
//

#import "OPAppDelegate.h"
#import "OPLoggersDocument.h"

@implementation OPAppDelegate

@synthesize masterViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
        UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
        splitViewController.delegate = (id)navigationController.topViewController;
        navigationController = [splitViewController.viewControllers objectAtIndex:0];
        self.masterViewController = (OPMasterViewController *) navigationController.topViewController;
    }
    else
    {
        UINavigationController* navigationController = (UINavigationController *)self.window.rootViewController;
        
        self.masterViewController = (OPMasterViewController *)navigationController.topViewController;
    }
    
  
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    if(paths.count > 0)
    {
        NSString *filePath =[paths objectAtIndex:0];
        filePath = [filePath stringByAppendingPathComponent:@"loggers.eventlogger"];
        
        NSURL *fileURL = [NSURL fileURLWithPath:filePath];
        
        OPLoggersDocument *document = [[OPLoggersDocument alloc] initWithFileURL: fileURL];
        [document openWithCompletionHandler:^(BOOL success) {
            if(success)
            {
                [self.masterViewController.tableView reloadData];
            }
            else
            {
                [document saveToURL:fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
                    [self.masterViewController.tableView reloadData];
                }];
            }
        }];
        self.masterViewController.document = document;

    }
    
    [self sharedLocationManager];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
@synthesize sharedLocationManager;

-(CLLocationManager *)sharedLocationManager
{
    if(!sharedLocationManager)
    {
        sharedLocationManager = [[CLLocationManager alloc] init];
        sharedLocationManager.delegate = self;
    }
    
    if([CLLocationManager locationServicesEnabled])
    {
        sharedLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        sharedLocationManager.distanceFilter = 50;
        [sharedLocationManager startUpdatingLocation];
    }
    return sharedLocationManager;
}


@end
