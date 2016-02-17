//
//  UIView+ViewAddition.m
//  SmartHome-iphone
//
//  Created by Sanch0 on 8/14/13.
//  Copyright (c) 2013 DS. All rights reserved.
//

@implementation UIView (ViewAddition)

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)top {
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.top + self.height;
}

- (void)setBottom:(CGFloat)bottom {
    self.top = bottom - self.height;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left {
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)right {
    return self.left + self.width;
}

- (void)setRight:(CGFloat)right {
    self.left = right - self.width;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.centerY);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.centerX, centerY);
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

+ (instancetype)loadFromNib {
    NSString *className = NSStringFromClass(self);
    return [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] firstObject];
}

- (void)makeBorder {
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1.f;
    self.layer.borderColor = BORDER_GRAY_COLOR.CGColor;
}

- (void)makeBorderWithCornerRadius {
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1.f;
    self.layer.borderColor = BORDER_GRAY_COLOR.CGColor;
    self.layer.cornerRadius = 5.f;
}


- (void)roundCorners:(UIRectCorner)corners radius:(CGFloat)radius {
    CGRect bounds = self.bounds;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(radius, radius)];

    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = bounds;
    maskLayer.path = maskPath.CGPath;

    self.layer.mask = maskLayer;

    CAShapeLayer *frameLayer = [CAShapeLayer layer];
    frameLayer.frame = bounds;
    frameLayer.path = maskPath.CGPath;
    frameLayer.strokeColor = [UIColor redColor].CGColor;
    frameLayer.fillColor = nil;

    [self.layer addSublayer:frameLayer];
}

- (void)roundTopCornersRadius:(CGFloat)radius {
    [self roundCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) radius:radius];
}

- (void)roundBottomCornersRadius:(CGFloat)radius {
    [self roundCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight) radius:radius];
}

- (void)createAndLayoutSubviews {

}

- (void)showLoading:(BOOL)flag {
    DLog(@"HUD is %@", flag ? @"SHOWING" : @"HIDING");
    if (flag) {
        [MBProgressHUD showHUDAddedTo:self animated:YES];
    } else {
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
    }
}


@end
