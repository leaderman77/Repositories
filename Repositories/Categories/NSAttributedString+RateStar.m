//
//  NSAttributedString+RateStar.m
//  travede-iphone
//
//  Created by Mirzohidbek on 5/22/14.
//  Copyright (c) 2014 travede. All rights reserved.
//
#define DEFAULT_MAX_RATE_VALUE              5
#define krateStarFontWithSize(fontSize)     [UIFont fontWithName:@"RateStars" size:(fontSize)]
#define kRatedStarColor                     rgbColor(252, 168, 3)
#define kUnratedStarColor                   rgbColor(236, 236, 236)

#import "NSAttributedString+RateStar.h"

@implementation NSAttributedString (RateStar)

+ (NSAttributedString *)rateStringLeftToRight:(uint)rate withFontSize:(uint)fontSize
{
    if(rate > DEFAULT_MAX_RATE_VALUE) {
        rate = 0;
    }
    NSMutableAttributedString * rateAttrStr = [[NSMutableAttributedString alloc] initWithString:@""];
    NSRange ratedRange = NSMakeRange(0, rate);
    NSRange unratedRange = NSMakeRange(rate, DEFAULT_MAX_RATE_VALUE - rate);
    [rateAttrStr addAttribute:NSFontAttributeName value:krateStarFontWithSize(fontSize) range:NSMakeRange(0, DEFAULT_MAX_RATE_VALUE)];
    [rateAttrStr addAttribute:NSForegroundColorAttributeName value:kRatedStarColor range:ratedRange];
    [rateAttrStr addAttribute:NSForegroundColorAttributeName value:kUnratedStarColor range:unratedRange];
    return rateAttrStr;
}

+ (NSAttributedString *)rateStringRightToLeft:(uint)rate withFontSize:(uint)fontSize
{
    if(rate > DEFAULT_MAX_RATE_VALUE) {
        rate = 0;
    }
    NSMutableAttributedString * rateAttrStr = [[NSMutableAttributedString alloc] initWithString:@""];
    NSRange ratedRange = NSMakeRange(DEFAULT_MAX_RATE_VALUE - rate, rate);
    NSRange unratedRange = NSMakeRange(0, DEFAULT_MAX_RATE_VALUE - rate);
    [rateAttrStr addAttribute:NSFontAttributeName value:krateStarFontWithSize(fontSize) range:NSMakeRange(0, DEFAULT_MAX_RATE_VALUE)];
    [rateAttrStr addAttribute:NSForegroundColorAttributeName value:kRatedStarColor range:ratedRange];
    [rateAttrStr addAttribute:NSForegroundColorAttributeName value:kUnratedStarColor range:unratedRange];
    return rateAttrStr;
}

+ (NSAttributedString *)audioDescriptionWithRate:(int)rate withSize:(long long)fileSize withDuration:(int)duration
{
	NSMutableAttributedString *description = [[NSMutableAttributedString alloc] initWithString:(rate > 0) ? @"" : @"no rating"];
	if(rate > 0) {
		[description appendAttributedString:[NSAttributedString rateStringLeftToRight:rate withFontSize:14]];
	}
	NSString *infoStr = [NSString stringWithFormat:@" / %.2fMB / %d:%d", fileSize / (float)(1024 * 1024), duration / 60, duration  % 60];
	NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:infoStr];
	[description appendAttributedString:attrStr];
	return description;
}


@end
