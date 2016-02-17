//
//  CustomNavigationController.h
//  Chayxana
//
//  Created by Admin on 9/21/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomNavigationController;

@protocol CustomNavigationControllerDelegate <NSObject>

//- (void)customNavigationController:(CustomNavigationController *)navController didBottomBtnSelected:(BottomButton *)btn;
@optional
- (void)leftNavigationBtnClicked:(id)sender;
- (void)rightNavigationBtnClicked:(id)sender;

@end

@interface CustomNavigationController : UINavigationController<UINavigationControllerDelegate>
@property (nonatomic, strong) NSNumber *selectedBottomBtnIndex;
@property (nonatomic, weak) id<CustomNavigationControllerDelegate> navigationDelegate;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) NSString *navigationTitle;
@property (nonatomic, strong) UIButton *titleView;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;

- (void)backClicked:(id)sender;
@end
