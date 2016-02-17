//
//  BaseController.h
//  Chayxana
//
//  Created by Admin on 9/22/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomNavigationController.h"
#import "BaseRightSearchView.h"
#import "PickerPopover.h"
#import "BaseCell.h"

@class PickerPopover;

@class BaseController;

@protocol BaseControllerDelegate <BaseProtocol>

@optional
- (void)baseController:(BaseController *)baseController withAction:(NSInteger)action withValue:(id)value;
@end

@interface BaseController : UIViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, PickerPopoverDelegate, BaseCellDelegate>

@property (nonatomic, strong) UIButton *leftNavBarBtn;
@property (nonatomic, strong) UIButton *rightNavBarBtn;
@property (nonatomic, assign) BOOL isKeyboardWasShown;
@property (nonatomic, strong) UIButton *titleView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIButton *windowView;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) PickerPopover *pickerPopover;
@property (nonatomic, strong) NSMutableArray *items;

- (void)configureNavigationBar;
- (void)configureNavigationBar2;
- (void)configureControls;

- (void)registerForKeyboardNotifications;
- (void)keyboardDidShow:(id)sender;
- (void)keyboardDidHide:(id)sender;

- (void)callApiMethods;
- (void)windowViewTapped:(id)sender;
- (CGRect)rightSearchViewFrame;
@end
