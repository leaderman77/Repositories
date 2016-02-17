//
//  NSString+MD5Addition.h
//  UIDeviceAddition
//
//  Created by Georg Kitz on 20.08.11.
//  Copyright 2011 Aurora Apps. All rights reserved.
//

@class NSString;

@interface NSString (MD5Addition)

- (NSString *)MD5;
- (BOOL)isEmailValid;
- (BOOL)isLinkValid;
- (BOOL)isPhoneValid;
- (BOOL)isPhoneNumberValid;

- (BOOL)isEqualIgnoreCase:(NSString *)string;

- (NSString *)deleteUnnessaryWhiteSpaces;

- (NSString *)trim;
- (NSDictionary *) JSONValue;
+ (NSString *)nowTimeAsString;
- (NSString *)cachedFileNameForKey:(NSString *)key ;
- (NSURL *)toURL;
- (NSString *)toNotEmptyStringValue;
+ (NSString *)toNotEmptyStringValue:(NSString *)string;
+ (NSString *)dateToString:(NSNumber *)date;
+ (NSString *)timeSecondsToString:(NSUInteger)seconds;
- (NSString *)getCleanedPhoneNumber;

@end
