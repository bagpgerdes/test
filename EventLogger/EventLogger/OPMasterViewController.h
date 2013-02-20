//
//  OPMasterViewController.h
//  EventLogger
//
//  Created by Alexander Massolle on 04.02.13.
//  Copyright (c) 2013 Brockhaus AG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OPLoggersDocument.h"

@class OPDetailViewController;

@interface OPMasterViewController : UITableViewController <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) OPDetailViewController *detailViewController;
@property (strong, nonatomic) OPLoggersDocument *document;

@end
