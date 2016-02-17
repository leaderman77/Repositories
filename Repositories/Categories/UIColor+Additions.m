//
//  UIColor+Additions.m
//  Dental-iPad
//
//  Created by Mirzohidbek on 3/11/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "UIColor+Additions.h"

@implementation UIColor (Additions)

- (int)getHexCode {
    const CGFloat* components = CGColorGetComponents(self.CGColor);
    float r, g, b;
    
    if(CGColorGetNumberOfComponents(self.CGColor) == 2){
        r = components[0];
        g = components[0];
        b = components[0];
    }else{
        r = components[0];
        g = components[1];
        b = components[2];
    }
    return (int)(r * 255.0f) << 16 | (int)(g * 255.0f) << 8 | (int)(b * 255.0f) << 0;
}

@end
