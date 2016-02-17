//
// Created by Sanch0 on 2/27/14.
// Copyright (c) 2014 DS. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@interface UIImage (UIImageAddition)

- (UIImage *)changeImageWithColor:(UIColor *)color;

//TintColor...
- (UIImage *)imageWithTint:(UIColor *)tintColor;
//scale and resize...
- (UIImage *)scaleToSize:(CGSize)size;

+ (UIImage *)imageFromR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b withAlpha:(CGFloat)alpha;
+ (UIImage *)imageFromColor:(UIColor*)color;

@end