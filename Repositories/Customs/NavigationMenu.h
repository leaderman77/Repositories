//
//  NavigationMenu.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 12/17/14.
//  Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NavigationMenu;

@protocol NavigationMenuDelegate <NSObject>

- (void)menuItemTapped:(MenuBarButtonType)type;
- (NSArray *)navigationMenu:(NavigationMenu *)navigationMenu withMenuType:(MenuBarType)menuType;

@end




@interface NavigationMenu : UIView
{
//    BOOL isShowing;
}
@property (nonatomic, weak) id <NavigationMenuDelegate> delegate;
@property (nonatomic, strong) UIToolbar *topNavigationMenu;
@property (nonatomic, strong) UIToolbar *bottomNavigationMenu;
@property (nonatomic, retain) UIButton *bottomMenuIcon;
- (UIBarButtonItem *)barButtonItem:(NSString *)title withImageName:(NSString *)imageName withTag:(MenuBarButtonType)btnType;
- (UIBarButtonItem *)flexibleItem;
- (UIBarButtonItem *)fixedItemwithWidth:(CGFloat)width ;
- (id)initWithTopMenuType:(MenuBarType)topMenuBarType andWithBottom:(MenuBarType)bottomMenuBarType;
- (void)setHiddenMenu:(BOOL)hidden;


- (void)changeToOrientation:(UIInterfaceOrientation )orientation;
- (void)setHiddenBottomMenu:(BOOL)hidden;
- (void)setHiddenTopMenu:(BOOL)hidden;
@end
