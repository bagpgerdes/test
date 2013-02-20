//
//  OPLoggersDocument.h
//  EventLogger
//
//  Created by Alexander Massolle on 04.02.13.
//  Copyright (c) 2013 Brockhaus AG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OPLogger.h"

@interface OPLoggersDocument : UIDocument

@property (strong, nonatomic, readonly) NSArray *loggers;

-(void) addNewLoggerWithName: (NSString *) name;
- (NSMutableDictionary *)logNewEventInLogger: (OPLogger *) logger;

@end
