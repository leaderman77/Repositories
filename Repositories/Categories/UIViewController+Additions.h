//
//  UIViewController+Additions.h
//  CASAcontrol
//
//  Created by Sanch0 on 3/27/14.
//  Copyright (c) 2014 DS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Additions)

+ (id)controllerWithIdentifier:(NSString *)identifier;
+ (id)controllerWithClass:(Class)class;
+ (id)controllerFromStoryBoard;
@end
