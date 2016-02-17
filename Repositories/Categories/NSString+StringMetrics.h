//
// Created by Sanch0 on 11/13/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (StringMetrics)

- (CGFloat)heightWithWidth:(CGFloat)width withFontSize:(CGFloat)fontSize;
- (CGFloat)heightWithWidth:(CGFloat)width withFontBoldSize:(CGFloat)fontSize;
@end