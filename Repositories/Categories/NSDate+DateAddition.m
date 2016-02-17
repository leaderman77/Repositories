//
// Created by Sanch0 on 10/22/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

//#import "CompanyShort.h"

@implementation NSDate (DateAddition)


+ (NSDate *)dateFromServerDateLong:(NSNumber *)serverDate {
    if (serverDate == nil || [serverDate isEqual:[NSNull null]]) {
        return nil;
    }

    return [[NSDate alloc] initWithTimeIntervalSince1970:[serverDate longLongValue] / 1000];
}

- (NSNumber *)longServerDate {
    return @(floor([self timeIntervalSince1970] * 1000));
}


+ (NSInteger)age:(NSDate *)birthDate {
    if (birthDate == nil) {
        return 0;
    }
    NSDate *today = [NSDate date];
    NSDateComponents *ageComponents = [[NSCalendar currentCalendar]
            components:NSYearCalendarUnit
              fromDate:birthDate
                toDate:today
               options:0];
    return ageComponents.year > 0 ? ageComponents.year : 0;
}

- (NSDate *)beginningOfDay {
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    NSString *timeZone = [[SettingsManager sharedManager] sessionData].company.timezone.code;
//    cal.timeZone = timeZone.length > 0 ? [NSTimeZone timeZoneWithAbbreviation:timeZone] : [NSTimeZone timeZoneWithName:@"GMT"];
    NSDateComponents *components = [cal components:(NSMonthCalendarUnit | NSDayCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:self];

    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];

    return [cal dateFromComponents:components];

}

- (NSDate *)endOfDay {
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    NSString *timeZone = [[SettingsManager sharedManager] sessionData].company.timezone.code;
//    cal.timeZone = timeZone.length > 0 ? [NSTimeZone timeZoneWithAbbreviation:timeZone] : [NSTimeZone timeZoneWithName:@"GMT"];

    NSDateComponents *components = [cal components:(NSMonthCalendarUnit | NSDayCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:self];

    [components setHour:23];
    [components setMinute:59];
    [components setSecond:59];

    return [cal dateFromComponents:components];

}

- (NSDate *)addMinutes:(NSInteger)minutes {

    return [self dateByAddingTimeInterval:minutes * 60];
}

- (NSDateComponents *)dateComponents {
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    NSString *timeZone = [[SettingsManager sharedManager] sessionData].company.timezone.code;
//    cal.timeZone = timeZone.length > 0 ? [NSTimeZone timeZoneWithAbbreviation:timeZone] : [NSTimeZone timeZoneWithName:@"GMT"];
    NSDateComponents *components = [cal components:(NSMonthCalendarUnit | NSDayCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:self];
    return components;
}


@end