//
// Created by Sanch0 on 11/7/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//


@implementation UITextField (Validate)

- (BOOL)isEmpty {
    if (self.text.trim.length == 0) {
        self.layer.borderColor = [[UIColor redColor] CGColor];
        self.layer.borderWidth = 3.f;
        return YES;
    }
    return NO;
}

@end