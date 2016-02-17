//
//  tabbarView.h
//  tabbarTest
//
//  Created by Kevin Lee on 13-5-6.
//  Copyright (c) 2013年 Kevin. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "CustomTabBarController.h"

@class NewTypeController;
@class ChatsBottomViewController;
@class SearchAnnouncementsController;
@class ChatsController;

@protocol tabBarSearchDelegate <NSObject>

-(void)openNewsTypeController:(NewTypeController*)newsTypeController;
-(void)openNextController:(ChatsBottomViewController*)chatsViewController;
-(void)openSearchAnnounceController:(SearchAnnouncementsController*)searchAnnounceController;
- (void)userFullName:(NSString *)fullName withUserPosition:(NSString *)position withUserPhoto:(NSURL *)photoURL;
@end

@interface tabbarView : UIView

@property(nonatomic,strong) UIImageView *tabbarView;
@property(nonatomic,strong) UIImageView *tabbarViewCenter;

@property(nonatomic,strong) UIButton *button_1;
@property(nonatomic,strong) UIButton *button_2;
@property(nonatomic,strong) UIButton *button_3;
@property(nonatomic,strong) UIButton *button_4;
@property(nonatomic,strong) UIButton *button_center;

//@property(nonatomic,weak) id<tabbarDelegate> delegate;
@property (nonatomic, weak) id <tabBarSearchDelegate> tabBarSearchDelegate;

@end
