//
//  UIFont+customFont.m
//  SmartHome-iphone
//
//  Created by Jurayev on 8/16/13.
//  Copyright (c) 2013 DS. All rights reserved.
//

#import "UIFont+customFont.h"

#define fontName @"HelveticaNeue-Bold"

@implementation UIFont (customFont)

+(UIFont *)customFontSize:(float)size {
    return [UIFont fontWithName:fontName size:size];
}

@end
