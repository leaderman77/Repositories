//
// Created by Sanch0 on 11/14/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import "UIView+UIView_Snapshots.h"


@implementation UIView (UIView_Snapshots)

- (UIImage*) imageOfViewUsingBackgroundColor:(UIColor*)backgroundColorOrNil
{
    // Opaque is faster
    BOOL opaqueCanvas = (backgroundColorOrNil) || (self.opaque && self.layer.cornerRadius == 0);

    // Creeate a canvas
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, opaqueCanvas, 0.0);

    // If we have a background collor begin by fillling the canvas
    if (backgroundColorOrNil)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, backgroundColorOrNil.CGColor);
        CGContextFillRect(context, self.bounds);
    }

    // Render the view on the canvas
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];

    // Return the image repsrenstation of the canvas
    UIImage* img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (void) saveImageOfViewToPNGNamed:(NSString*)fileNameMinusExtension usingBackgroundColor:(UIColor*)backgroundColorOrNil
{
    // Create the path
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    NSString* destPath = [documentsDirectory stringByAppendingPathComponent:fileNameMinusExtension];
    destPath = [destPath stringByAppendingFormat:@".png"];

    // Create the image
    UIImage* image = [self imageOfViewUsingBackgroundColor:backgroundColorOrNil];

    // Save as a PNG
    [UIImagePNGRepresentation(image) writeToFile:destPath atomically:YES];

    // Write out the contents of home directory to console
    NSError *error;
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSLog(@"Documents directory: %@", [fileMgr contentsOfDirectoryAtPath:documentsDirectory error:&error]);
}

@end
