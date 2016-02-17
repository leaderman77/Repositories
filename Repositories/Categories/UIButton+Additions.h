//
//  UIButton+Additions.h
//  Dental-iPad
//
//  Created by Sanch0 on 9/30/14.
//  Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UIImage;

@interface UIButton (Additions)


- (void)setImage:(UIImage *)image;

- (UIImage *)image;

- (void)setBackgroundImage:(UIImage *)image;

- (UIImage *)backgroundImage;


- (void)setTitle:(NSString *)title;

- (NSString *)title;

- (void)setText:(id)text;

- (id)text;


- (UIColor *)titleColor;

- (void)setTitleColor:(UIColor *)color;

-(void)addBottomBorderWithHeight: (CGFloat)height andColor:(UIColor*)color;
@end
