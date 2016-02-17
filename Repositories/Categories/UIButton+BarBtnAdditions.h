//
// Created by Sanch0 on 10/20/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class UIButton;
@class UIViewController;

@interface UIButton (BarBtnAdditions)
+ (UIButton *)leftBtnWithImageName:(NSString *)imageName withController:(UIViewController *)controller withSelector:(SEL)aSelector;
+ (UIButton *)rightBtnWithImageName:(NSString *)imageName withController:(UIViewController *)controller withSelector:(SEL)aSelector;

//+ (UIButton *)leftBtnWithTitle:(NSString *)title withImageName:(NSString *)imageName withController:
//        (UIViewController *)controller withSelector:(SEL)aSelector;
//
//+ (UIButton *)rightBtnWithTitle:(NSString *)title withImageName:(NSString *)imageName withController:
//        (UIViewController *)controller withSelector:(SEL)aSelector;

+ (UIButton *)backBtnWithController:(UIViewController * )controller withSelector:(SEL)aSelector;

+ (UIButton *)doneBtnWithController:(UIViewController * )controller withSelector:(SEL)aSelector;

@end