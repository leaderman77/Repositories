//
//  UIButton+Additions.m
//  Dental-iPad
//
//  Created by Sanch0 on 9/30/14.
//  Copyright (c) 2014 Finnet Limited. All rights reserved.
//

@implementation UIButton (Additions)

- (void)setImage:(UIImage *)image {
    [self setImage:image forState:UIControlStateNormal];
    [self setImage:image forState:UIControlStateHighlighted];
}

- (UIImage *)image {
    return [self imageForState:UIControlStateNormal];
}

- (void)setBackgroundImage:(UIImage *)image {
    [self setBackgroundImage:image forState:UIControlStateNormal];
//    [self setBackgroundImage:image forState:UIControlStateHighlighted];
}

- (UIImage *)backgroundImage {
    return [self backgroundImageForState:UIControlStateNormal];
}


- (NSString *)title {
    return [self titleForState:UIControlStateNormal];
}

- (void)setTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setText:(id)text {
    if (text == nil) {
        [self setTitle:text forState:UIControlStateNormal];
        [self setAttributedTitle:text forState:UIControlStateNormal];
    } else if ([text isKindOfClass:[NSString class]]) {
        [self setTitle:text forState:UIControlStateNormal];
    } else if ([text isKindOfClass:[NSAttributedString class]]) {
        [self setAttributedTitle:text forState:UIControlStateNormal];
    }
}

- (id)text {
    if ([self titleForState:UIControlStateNormal].length > 0) {
        return [self titleForState:UIControlStateNormal];
    }
    return [self attributedTitleForState:UIControlStateNormal];
}

- (UIColor *)titleColor {
    return [self titleColorForState:UIControlStateNormal];
}

- (void)setTitleColor:(UIColor *)color {
    [self setTitleColor:color forState:UIControlStateNormal];
}
-(void)addBottomBorderWithHeight: (CGFloat)height andColor:(UIColor*)color {
    [self addOneSidedBorderWithFrame:CGRectMake(0, self.frame.size.height-height - 8, self.frame.size.width, height) andColor:color];
}

-(void)addOneSidedBorderWithFrame:(CGRect)frame andColor:(UIColor*)color
{
    CALayer *border = [CALayer layer];
    border.frame = frame;
    [border setBackgroundColor:color.CGColor];
    [self.layer addSublayer:border];
}
@end
