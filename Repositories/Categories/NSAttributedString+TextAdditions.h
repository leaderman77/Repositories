//
// Created by Sanch0 on 10/23/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (TextAdditions)

+ (NSAttributedString *)attributedStringWithTitle:(NSString *)title withFontSize:(CGFloat)fontSize;
+ (NSAttributedString *)attributedStringWithTitle:(NSString *)title withBoldFontSize:(CGFloat)fontSize;

+ (NSAttributedString *)attributedStringWithTitle:(NSString *)title withTextAlign:(NSTextAlignment)textAlignment withFontSize:(CGFloat)fontSize;

+ (NSAttributedString *)attributedStringWithTitle:(NSString *)title withTextAlign:(NSTextAlignment)textAlignment withBoldFontSize:(CGFloat)fontSize;

+ (NSAttributedString *)attributedStringForButtonWithTitle:(NSString *)title withFontSize:(CGFloat)fontSize;
+ (NSAttributedString *)attributedStringForButtonWithTitle:(NSString *)title withBoldFontSize:(CGFloat)fontSize;

+ (NSAttributedString *)attributedStringWithTitle:(NSString *)title withTextColor:(UIColor *)color withFontSize:(CGFloat)fontSize;
+ (NSAttributedString *)attributedStringWithTitle:(NSString *)title withTextColor:(UIColor *)color withBoldFontSize:(CGFloat)fontSize;

+ (NSAttributedString *)attributedStringWithTitle:(NSString *)title withTextColor:(UIColor *)color withFontSize:(CGFloat)fontSize withLineSpacing:(CGFloat)lineSpacing;
+ (NSAttributedString *)attributedStringWithTitle:(NSString *)title withTextColor:(UIColor *)color withBoldFontSize:(CGFloat)fontSize withLineSpacing:(CGFloat)lineSpacing;

+ (NSAttributedString *)attributedStringWithTitle:(NSString *)title withTextColor:(UIColor *)color;

- (CGFloat)heightWithWidth:(CGFloat)width;

- (CGFloat)textWidth;

@end