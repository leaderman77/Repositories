//
// Created by Sanch0 on 11/14/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIView (UIView_Snapshots)

// Take image snapshots of the current state of a view.

// Use the background color of the superview if you have rounded corners
// If background color is nil the background will be treated as transparent
- (UIImage*) imageOfViewUsingBackgroundColor:(UIColor*)backgroundColorOrNil;

// Will save to the documents directory as XXXX.png
- (void) saveImageOfViewToPNGNamed:(NSString*)fileNameMinusExtension usingBackgroundColor:(UIColor*)backgroundColorOrNil;


@end