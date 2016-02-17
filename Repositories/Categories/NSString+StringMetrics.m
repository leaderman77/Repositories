//
// Created by Sanch0 on 11/13/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import "NSString+StringMetrics.h"


@implementation NSString (StringMetrics)

- (CGFloat)heightWithWidth:(CGFloat)width withFontSize:(CGFloat)fontSize {
    CGRect rect = [[NSAttributedString attributedStringForButtonWithTitle:self withFontSize:fontSize] boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin
                                                                                                                   context:nil];
    return rect.size.height;
}

- (CGFloat)heightWithWidth:(CGFloat)width withFontBoldSize:(CGFloat)fontSize {
    CGRect rect = [[NSAttributedString attributedStringForButtonWithTitle:self withBoldFontSize:fontSize] boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin
                                                                                                                       context:nil];
    return rect.size.height;
}

@end