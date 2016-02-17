//
// Created by Sanch0 on 10/22/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSDate;
@class NSNumber;
@class NSDateComponents;

@interface NSDate (DateAddition)

+ (NSDate *)dateFromServerDateLong:(NSNumber *)serverDate;
- (NSNumber *)longServerDate;

+ (NSInteger)age:(NSDate *)birthDate;

- (NSDate *)beginningOfDay;
- (NSDate *)endOfDay;

- (NSDate *)addMinutes:(NSInteger)minutes;

- (NSDateComponents *)dateComponents;


@end