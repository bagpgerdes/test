//
//  OPLogger.m
//  EventLogger
//
//  Created by Alexander Massolle on 04.02.13.
//  Copyright (c) 2013 Brockhaus AG. All rights reserved.
//

#import "OPLogger.h"

@implementation OPLogger

@synthesize name;
@synthesize eventDictionaries;

-(NSArray *)eventDictionaries
{
    if(!eventDictionaries)
    {
        eventDictionaries = [[NSMutableArray alloc] init];
    }
    return eventDictionaries;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.eventDictionaries forKey:@"eventDictionaries"];
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [self init])
    {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        eventDictionaries = [aDecoder decodeObjectForKey:@"eventDictionaries"];
    }
    return self;
}

-(void) addEventDictionary: (NSDictionary *) eventDictionary
{
    NSParameterAssert(eventDictionary != nil);
    
    [self willChangeValueForKey:@"eventDictionaries"];
    [((NSMutableArray *) self.eventDictionaries) addObject: eventDictionary];
    [self didChangeValueForKey:@"eventDictionaries"];
}

- (NSString *) description
{
    return [NSString stringWithFormat:@"%@ %@ with events: %@", [super description], self.name, self.eventDictionaries];
}


@end
