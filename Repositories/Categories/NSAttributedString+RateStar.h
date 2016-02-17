//
//  NSAttributedString+RateStar.h
//  travede-iphone
//
//  Created by Mirzohidbek on 5/22/14.
//  Copyright (c) 2014 travede. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (RateStar)

+ (NSAttributedString *)rateStringLeftToRight:(uint)rate withFontSize:(uint)fontSize;
+ (NSAttributedString *)rateStringRightToLeft:(uint)rate withFontSize:(uint)fontSize;
+ (NSAttributedString *)audioDescriptionWithRate:(int)rate withSize:(long long)fileSize withDuration:(int)duration;

@end
