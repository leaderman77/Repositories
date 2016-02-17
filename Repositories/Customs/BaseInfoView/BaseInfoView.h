//
// Created by Sanch0 on 10/24/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PickerPopover.h"

@class PickerPopover;
@class CustomTextField;
@class MLPAutoCompleteTextField;
@class BaseInfoView;
@class PatientPersonalDetails;
@class PatientSignatureFormForShow;
@class CompanyPatientInsurance;

#define LABEL_FRAME                              CGRectMake(left, top, labelWidth, labelHeight)
#define LABEL_FRAME_WITH_LEFT(left)              CGRectMake(left, top, labelWidth, labelHeight)
#define TEXTFIELD_FRAME                          CGRectMake(left, top, labelWidth, textFieldHeight)
#define TEXTFIELD_FRAME_WITH_LEFT(left)          CGRectMake(left, top, labelWidth, textFieldHeight)

#define FIRST_NAME @"FIRST_NAME"
#define LAST_NAME @"LAST_NAME"
#define MIDDLE_NAME @"MIDDLE_NAME"
#define FULL_NAME @"FULL_NAME"
#define POSITION @"POSITION"
#define DATE_OF_BIRTH @"DATE_OF_BIRTH"
#define EMAIL @"EMAIL"
#define PHONE_NUMBER @"PHONE_NUMBER"
#define PHOTO @"PHOTO"
#define PASSWORD @"PASSWORD"
#define CONFIRM_PASSWORD @"CONFIRM_PASSWORD"


@protocol BaseInfoViewDelegate<NSObject>
- (void)baseInfoView:(BaseInfoView *)infoView withActionType:(NSInteger)actionType withValue:(id)value;
@end

@interface BaseInfoView : UIView<UITextFieldDelegate, PickerPopoverDelegate> {
@protected
    CGFloat top;
    CGFloat labelWidth;
    CGFloat labelHeight;
    CGFloat textFieldHeight;
    CGFloat left;
}

@property (nonatomic, weak) id<BaseInfoViewDelegate>baseDelegate;

@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, strong) UILabel *titleInfoLabel;
@property (nonatomic, strong) UIView *leftTitleLine;
@property (nonatomic, strong) UIView *rightTitleLine;

@property (nonatomic, strong) PickerPopover *pickerPopover;

@property (nonatomic, strong) id patientDic;
@property (nonatomic, assign) BOOL isViewMode;

@property (nonatomic,   weak) UIScrollView *scrollView;
@property (nonatomic, strong) PatientSignatureFormForShow *patientSignatureFormForShow;
@property (nonatomic, readonly) PatientPersonalDetails *patientDetails;

@property (nonatomic, strong) NSMutableDictionary *textFieldsDic;
@property (nonatomic, strong) NSMutableSet *mandatoryFields;

- (void)changeTextFieldEditMode:(UITextField *)textField;
/*

CGFloat top = 0.f;
CGFloat labelWidth = 380.f;
CGFloat labelHeight = 30.f;
CGFloat textFieldHeight = 50.f;
CGFloat left = 0.5 * (self.width - labelWidth);

*/


- (void)createAndLayoutSubviews;
- (UILabel *)labelWithFrame:(CGRect)frame withTitle:(NSString *)title;
- (CustomTextField *)textFieldWithFrame:(CGRect)frame withArrow:(BOOL)flag;
- (MLPAutoCompleteTextField *)autoCompleteTextFieldWithFrame:(CGRect)frame withArrow:(BOOL)flag;

- (void)populateWithUserDetails;

- (void)populatePatientDetails;
- (BOOL)isEmptyTextField:(UITextField *)textField;
- (BOOL)validateAndPopulatePatientDetails;

- (void)populateWithPatientSignature:(PatientSignatureFormForShow *)patientSignatureFormForShow;
- (void)populateWithPatientDetails:(PatientPersonalDetails *)patientDetails;
- (void)changeToOrientation:(UIInterfaceOrientation )orientation;

@end