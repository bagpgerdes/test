//
//  OPLoggersDocument.m
//  EventLogger
// djsbfdsjv dibfd
//  Created by Alexander Massolle on 04.02.13.
//  Copyright (c) 2013 Brockhaus AG. All rights reserved.
//

#import "OPLoggersDocument.h"
#import "OPLogger.h"
#import <CoreLocation/CoreLocation.h>
#import "OPAppDelegate.h"

@implementation OPLoggersDocument

@synthesize loggers;

-(NSArray *) loggers
{
    if (!loggers)
    {
        loggers = [[NSMutableArray alloc] init];
    }
    return loggers;
}


-(void) addNewLoggerWithName: (NSString *) name
{
    OPLogger *newLogger = [[OPLogger alloc] init];
    newLogger.name = name;
    
    [(NSMutableArray *) self.loggers addObject: newLogger];
}

-(id) contentsForType:(NSString *)typeName error:(NSError *__autoreleasing *)outError
{
    return[NSKeyedArchiver archivedDataWithRootObject:self.loggers];
}

- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError *__autoreleasing *)outError
{
    NSParameterAssert([contents isKindOfClass: [NSData class]]);
    loggers = [NSKeyedUnarchiver unarchiveObjectWithData:contents];
    return YES;
}

- (NSMutableDictionary *)logNewEventInLogger: (OPLogger *) logger
{
    NSMutableDictionary *eventDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:logger.name,@"name",[NSDate date],@"time", nil, nil];
    
    if([CLLocationManager locationServicesEnabled])
    {
        CLLocationManager *locationManager = ((OPAppDelegate *)[UIApplication sharedApplication].delegate).sharedLocationManager;
        
        CLLocationCoordinate2D coordinate = locationManager.location.coordinate;
        [eventDictionary setObject:[NSNumber numberWithDouble:coordinate.latitude] forKey:@"latitude"];
        [eventDictionary setObject:[NSNumber numberWithDouble:coordinate.longitude] forKey:@"longitude"];
        
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder reverseGeocodeLocation:locationManager.location completionHandler:^(NSArray *placemarks, NSError * error)
        {
            if(placemarks.count > 0)
            {
                CLPlacemark *placemark = [placemarks objectAtIndex:0];
                NSString *placeName = placemark.name;
                if(placeName.length)
                {
                    [logger willChangeValueForKey:@"eventDictionaries"];
                    [eventDictionary setObject:placeName forKey:@"locationName"];
                    [logger didChangeValueForKey:@"eventDictionaries"];
                }
                [self updateChangeCount:UIDocumentChangeDone];
            }
        }];
    }
    
    [logger addEventDictionary:eventDictionary];
    [self updateChangeCount:UIDocumentChangeDone];
    
    return eventDictionary;
}

@end
