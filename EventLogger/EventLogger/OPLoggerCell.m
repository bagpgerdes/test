//
//  OPLoggerCell.m
//  EventLogger
//
//  Created by Alexander Massolle on 18.02.13.
//  Copyright (c) 2013 Brockhaus AG. All rights reserved.
//

#import "OPLoggerCell.h"
#import "OPAppDelegate.h"
#import "OPDetailViewController.h"

@implementation OPLoggerCell

@synthesize logger, document;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)logEvent:(id)sender
{
    NSString *title = [NSString stringWithFormat:@"Log '%@'?", logger.name];
    
    NSString *message = [NSString stringWithFormat:@"Log an event for '%@' now?", logger.name];
    
    NSString *cancelButtonTitle = @"Cancel";
    NSString *otherButtonTitle = @"Log";
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitle, nil];
    
    [alertView show];
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex != alertView.cancelButtonIndex)
    {
        [self.document logNewEventInLogger:self.logger];
        OPAppDelegate *appDelegate = (OPAppDelegate *)[UIApplication sharedApplication].delegate;
        appDelegate.masterViewController.detailViewController.logger = self.logger;
    }
}

@end
