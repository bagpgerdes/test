//
//  OPDetailViewController.m
//  EventLogger
//
//  Created by Alexander Massolle on 04.02.13.
//  Copyright (c) 2013 Brockhaus AG. All rights reserved.
//

#import "OPDetailViewController.h"

@interface OPDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation OPDetailViewController

@synthesize logger, tableView;
@synthesize masterPopoverController = _masterPopoverController;

#pragma mark - Managing the logger

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(context == @"LOGGERCHANGED")
    {
        [self configureView];
    }
}

- (void)setLogger:(OPLogger *)aLogger
{
    if (logger != aLogger) {
        
        [logger removeObserver:self forKeyPath:@"eventDictionaries"];
        logger = aLogger;
        
        [logger addObserver:self forKeyPath:@"eventDictionaries" options:0 context:@"LOGGERCHANGED"];
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.logger) {
        self.title = self.logger.name;
        [tableView reloadData];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.logger = nil;
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

- (BOOL)splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation
{
    return NO;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.logger.eventDictionaries.count;
}

-(UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *result = [aTableView dequeueReusableCellWithIdentifier:@"EventDetailCell"];
    
    NSDictionary *eventDictionary = [self.logger.eventDictionaries objectAtIndex:indexPath.row];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterShortStyle;
    NSDate *eventDate = [eventDictionary objectForKey:@"time"];
    
    result.textLabel.text = [formatter stringFromDate:eventDate];
    
    result.detailTextLabel.text = [eventDictionary objectForKey:@"locationName"];
    
    return result;
}

@end
