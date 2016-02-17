//
// Created by Sanch0 on 1/15/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseProtocol.h"

@class BaseRightSearchView;
@class BaseController;
@class ToothDetailsType;

@protocol BaseRightSearchViewDelegate <BaseProtocol>

@optional
- (void)baseRightSearchViewDidBackClicked:(BaseRightSearchView *)rightSearchView;

- (void)baseRightSearchViewDidTopRightBtnClicked:(BaseRightSearchView *)rightSearchView;

- (void)baseRightSearchView:(BaseRightSearchView *)rightSearchView didAction:(NSInteger)action withValue:(id)value;

- (void)showRightSearchView:(BaseRightSearchView *)rightSearchView;

- (void)showRightSearchView:(BaseRightSearchView *)rightSearchView withCallback:(void (^)(BaseRightSearchView *rightSearchView))callback;

- (NSNumber *)relatedAppointmentId;
- (SelectItem *)relatedAppointmentDentist;

- (NSString *)patientKey;

- (SelectItem *)toothPosition;

- (NSArray *)toothItems;

- (ToothDetailsType *)toothDetailsType;

- (NSNumber *)companyPatientId;

- (BOOL)isEditMode;

- (BOOL)canEditDeleteTransaction;

- (UIButton *)windowView;

- (NSString *)positionCode;
@end

@interface BaseRightSearchView : UIControl {
@protected
    CGFloat top, left, padding, height, width;
}

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIView *topNavigationView;
@property (nonatomic, weak) id <BaseRightSearchViewDelegate> baseDelegate;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) id tagObject;

@property (nonatomic, strong) UIButton *leftTopBtn;
@property (nonatomic, strong) UIButton *rightTopBtn;

- (instancetype)initWithFrame:(CGRect)frame;


- (UIButton *)addBtnWithFrame:(CGRect)frame withTitle:(NSString *)title;

- (void)createAndLayoutTopNavigationView;

- (void)backClicked:(id)sender;

- (void)rightBtnClicked:(id)sender;

- (void)showLoading:(BOOL)isShow;

- (void)clearData;

- (void)reloadData;

- (void)showLoadingProgress:(BOOL)isShow;

- (void)bottomAddBtnClicked:(UIButton *)sender;

@end