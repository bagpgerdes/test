//
//  OPDetailViewController.h
//  EventLogger
//
//  Created by Alexander Massolle on 04.02.13.
//  Copyright (c) 2013 Brockhaus AG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OPLogger.h"

@interface OPDetailViewController : UIViewController <UISplitViewControllerDelegate, UITableViewDataSource>

@property (strong, nonatomic) OPLogger *logger;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
