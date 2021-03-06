//
//  AppDelegate.h
//  Repositories
//
//  Created by Admin on 2/15/16.
//  Copyright (c) 2016 microapps. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomNavigationController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CustomNavigationController *navigationController;
@property (weak, nonatomic) id<BaseProtocol> loaderView;

@end

