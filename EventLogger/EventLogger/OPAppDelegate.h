//
//  OPAppDelegate.h
//  EventLogger
//
//  Created by Alexander Massolle on 04.02.13.
//  Copyright (c) 2013 Brockhaus AG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OPMasterViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface OPAppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) OPMasterViewController *masterViewController;

@property (strong, nonatomic) CLLocationManager *sharedLocationManager;

@end
