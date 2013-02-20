//
//  OPLoggerCell.h
//  EventLogger
//
//  Created by Alexander Massolle on 18.02.13.
//  Copyright (c) 2013 Brockhaus AG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OPLogger.h"
#import "OPLoggersDocument.h"

@interface OPLoggerCell : UITableViewCell <UIAlertViewDelegate>

@property (strong, nonatomic)OPLogger *logger;
@property (strong, nonatomic) OPLoggersDocument *document;

- (IBAction)logEvent:(id)sender;

@end
