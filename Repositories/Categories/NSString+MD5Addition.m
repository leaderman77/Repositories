//
//  NSString+MD5Addition.m
//  UIDeviceAddition
//
//  Created by Georg Kitz on 20.08.11.
//  Copyright 2011 Aurora Apps. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MD5Addition)

- (NSString *)MD5 {

    if (self == nil || [self length] == 0) {
        return nil;
    }

    const char *value = [self UTF8String];

    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG) strlen(value), outputBuffer);

    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++) {
        [outputString appendFormat:@"%02x", outputBuffer[count]];
    }

    return outputString;
}

- (NSString *)cachedFileNameForKey:(NSString *)key {
    const char *str = [key UTF8String];
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG) strlen(str), r);
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                                                    r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    return filename;
}

- (NSString *)reverseString {
    NSMutableString *reversedStr;
    NSUInteger len = [self length];

    // auto released string
    reversedStr = [NSMutableString stringWithCapacity:len];

    // quick-and-dirty implementation
    while (len > 0)
        [reversedStr appendString:[NSString stringWithFormat:@"%C", [self characterAtIndex:--len]]];

    return reversedStr;
}


- (BOOL)isEmailValid {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];

    return [emailTest evaluateWithObject:self];
}

- (BOOL)isLinkValid {

    NSString *urlRegEx = @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];

    return [urlTest evaluateWithObject:self];
}

- (BOOL)isPhoneValid {
    NSString *regExStr = @"\\+*\\-*(\\([0-9]+\\))*\\-*\\.* *.*([0-9]*\\-*)*[0-9]+";
    NSPredicate *testPredicate = [NSPredicate predicateWithFormat:regExStr];

    return [testPredicate evaluateWithObject:self];
}

- (BOOL)isPhoneNumberValid {
    return YES;
}

- (BOOL)isEqualIgnoreCase:(NSString *)other {
    return other && ![other isEqual:[NSNull null]] && [self.lowercaseString isEqualToString:other.lowercaseString];
}

- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


- (NSDictionary *)JSONValue {

    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        return nil;
    }
    return dict;
}

+ (NSString *)nowTimeAsString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
    return [formatter stringFromDate:[NSDate date]];
}

- (NSURL *)toURL {
    return [NSURL URLWithString:[self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}

- (NSString *)deleteUnnessaryWhiteSpaces {
    NSString *cleaned = [self stringByReplacingOccurrencesOfString:@"\\s+"
                                                        withString:@" "
                                                           options:NSRegularExpressionSearch
                                                             range:NSMakeRange(0, self.length)];
    return cleaned;
}


//- (NSString *)toNotEmptyStringValue {
////    NSString *newsstr;
////    if (self.length > 0) {
////        newsstr = self;
////    } else {
////        newsstr = TRANSLATE(@"N/A");
////    }
////    return newsstr;
//   return (self.length > 0) ? self : TRANSLATE(@"N/A");
//}
//
//+ (NSString *)toNotEmptyStringValue:(NSString *)string {
////    if (string.length > 0) {
////        return string;
////    }
////    return TRANSLATE(@"N/A");
//    return (string.length > 0) ? string : TRANSLATE(@"N/A");
//}

//+ (NSString *)dateToString:(NSNumber *)dateLong {
//    NSDate *date = [NSDate dateFromServerDateLong:dateLong];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    formatter.dateFormat = SHORT_DATE_FORMAT;
//    return [formatter stringFromDate:date];
//}

+ (NSString *)timeSecondsToString:(NSUInteger)seconds {
    return [NSString stringWithFormat:@"%0.2ld:%0.2ld", (long) (seconds / 60), (long) seconds % 60];
}

- (NSString *)getCleanedPhoneNumber {
    NSString *phoneNumber = [self trim];
    if (phoneNumber.length == 0) {
        return nil;
    };
////    if ([phoneNumber hasPrefix:@"+"]) {
////        phoneNumber = [phoneNumber substringFromIndex:1];
////    }
//     phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
//     phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
//     phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
//     phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    return phoneNumber;
//    NSArray *phoneNumbers = [ componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"()"]];
//    if (phoneNumbers.count < 3) {
//        return nil;
//    }
//    self.countryCodeTextField.text = phoneNumbers[0];
//    self.cityCodeTextField.text = phoneNumbers[1];
//    self.phoneNumberTextField.text = phoneNumbers[2];
}



//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Warc-retain-cycles"
//- (CGSize)sizeWithFont:(UIFont *)font {
//    if(SYSTEM_VERSION > 7) {
//        
//    }
//    return [self sizeWithFont:font];
//}
//
//- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size {
//    if(SYSTEM_VERSION > 7) {
//        
//    }
//    return [self sizeWithFont:font constrainedToSize:size];
//}
//
//- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode {
//    if(SYSTEM_VERSION > 7) {
//        
//    }
//    return [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
//}
//
//- (CGSize)sizeWithFont:(UIFont *)font minFontSize:(CGFloat)minFontSize actualFontSize:(CGFloat *)actualFontSize forWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode {
//    if(SYSTEM_VERSION > 7) {
//        
//    }
//    return [self sizeWithFont:font minFontSize:minFontSize actualFontSize:actualFontSize forWidth:width lineBreakMode:lineBreakMode];
//}
//#pragma clang diagnostic pop


@end






