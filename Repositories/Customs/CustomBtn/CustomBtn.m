//
//  CustomBtn.m
//  Dental-iPad
//
//  Created by Sanch0 on 10/8/14.
//  Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import "CustomBtn.h"

@implementation CustomBtn

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.height += 10;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
