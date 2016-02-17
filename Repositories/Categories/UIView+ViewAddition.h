//
//  UIView+ViewAddition.h
//  SmartHome-iphone
//
//  Created by Sanch0 on 8/14/13.
//  Copyright (c) 2013 DS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ViewAddition)


@property CGFloat top;
@property CGFloat bottom;
@property CGFloat left;
@property CGFloat right;

@property CGFloat centerX;
@property CGFloat centerY;

@property CGFloat height;
@property CGFloat width;

+ (instancetype)loadFromNib;

- (void)roundCorners:(UIRectCorner)corners radius:(CGFloat)radius;

- (void)makeBorder;

- (void)makeBorderWithCornerRadius;

- (void)roundTopCornersRadius:(CGFloat)radius;
- (void)roundBottomCornersRadius:(CGFloat)radius;

- (void)createAndLayoutSubviews;

- (void)showLoading:(BOOL)flag;

@end
