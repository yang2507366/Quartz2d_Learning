//
//  TimeTracker.m
//  GoogleMapLocation
//
//  Created by gewara on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TimeTracker.h"

@interface TimeTracker ()

@property(nonatomic, retain)NSMutableDictionary *timeDictionary;

@end

@implementation TimeTracker

@synthesize timeDictionary = _timeDictionary;

+ (TimeTracker *)defaultTracker
{
    static TimeTracker *instance = nil;
    @synchronized(instance){
        if(instance == nil){
            instance = [[TimeTracker alloc] init];
        }
    }
    return instance;
}

- (void)dealloc
{
    [_timeDictionary release];
    [super dealloc];
}

- (id)init
{
    self = [super init];
    
    self.timeDictionary = [NSMutableDictionary dictionary];
    
    return self;
}

- (NSString *)stringForIdentifier:(id)identifier
{
    return [NSString stringWithFormat:@"%@", identifier];
}

- (void)markStartWithIdentifier:(id)identifier
{
    [self.timeDictionary setObject:[NSNumber numberWithDouble:[NSDate timeIntervalSinceReferenceDate]] 
                            forKey:[self stringForIdentifier:identifier]];
}

- (NSTimeInterval)timeIntervalForIdentifier:(id)identifier
{
    NSString *key = [self stringForIdentifier:identifier];
    NSNumber *time = [self.timeDictionary objectForKey:key];
    double timeInterval = 0.0f;
    if(time){
        timeInterval = [NSDate timeIntervalSinceReferenceDate] - time.doubleValue;
    }
    [self.timeDictionary removeObjectForKey:key];
    
    return timeInterval;
}

@end
