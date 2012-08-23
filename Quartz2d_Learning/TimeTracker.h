//
//  TimeTracker.h
//  GoogleMapLocation
//
//  Created by gewara on 12-7-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeTracker : NSObject {
    NSMutableDictionary *_timeDictionary;
}

+ (TimeTracker *)defaultTracker;

- (void)markStartWithIdentifier:(id)identifier;
- (NSTimeInterval)timeIntervalForIdentifier:(id)identifier;

@end
