//
//  OPLogger.h
//  EventLogger
//
//  Created by Alexander Massolle on 04.02.13.
//  Copyright (c) 2013 Brockhaus AG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OPLogger : NSObject <NSCoding>
@property (copy, nonatomic) NSString *name;

@property (strong, nonatomic, readonly) NSArray *eventDictionaries;

-(void) addEventDictionary: (NSDictionary *) eventDictionary;

@end
