//
// Created by Sanch0 on 10/24/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import "BaseInfoView.h"
#import "CustomTextField.h"
#import "MLPAutoCompleteTextField.h"
//#import "PatientPersonalDetails.h"
//#import "PatientSignatureFormForShow.h"

@interface BaseInfoView () <MLPAutoCompleteTextFieldDataSource, MLPAutoCompleteTextFieldDelegate>

@end

@implementation BaseInfoView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }

    return self;

}




- (CustomTextField *)textFieldWithFrame:(CGRect)frame withArrow:(BOOL)flag {
    CustomTextField *textField = [[CustomTextField alloc] initWithFrame:frame];
    textField.backgroundColor = self.isViewMode ? [UIColor clearColor] : [UIColor whiteColor];
    textField.enabled = !self.isViewMode;
    textField.delegate = self;
//    textField.borderStyle = UITextBorderStyleNone;
    textField.layer.cornerRadius = 5.f;
    textField.layer.masksToBounds = YES;
//    textField.layer.borderColor = BORDER_GRAY_COLOR.CGColor;
//    textField.layer.borderWidth = self.isViewMode ? 0.f : 1.f;
    textField.font = FONT_SANSUMI(16.f);
    textField.textColor = self.isViewMode ? [UIColor whiteColor] : [UIColor blackColor];
    textField.autocorrectionType = UITextAutocorrectionTypeNo;

    textField.placeholder = @"";
    textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    textField.leftViewMode = self.isViewMode ? UITextFieldViewModeNever : UITextFieldViewModeAlways;

    if (flag) {
        UIImageView *rightDropDownView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dropdown.png"]];
        rightDropDownView.contentMode = UIViewContentModeCenter;
        rightDropDownView.width = 30;
        rightDropDownView.left = textField.width - rightDropDownView.width - 20;
        rightDropDownView.top = 0.5 * (textField.height - rightDropDownView.height);
//        [textField addSubview:rightDropDownView];
        textField.rightView = rightDropDownView;//[[UIView alloc] initWithFrame:CGRectMake(0, 0, rightDropDownView.width + 10, 0)];
        textField.rightViewMode = UITextFieldViewModeAlways;
    }
    [self addSubview:textField];
    return textField;
}

- (MLPAutoCompleteTextField *)autoCompleteTextFieldWithFrame:(CGRect)frame withArrow:(BOOL)flag {
    MLPAutoCompleteTextField *textField = [[MLPAutoCompleteTextField alloc] initWithFrame:frame];
    textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 0)];
    textField.backgroundColor = self.isViewMode ? [UIColor clearColor] : [UIColor whiteColor];
    textField.enabled = !self.isViewMode;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.delegate = self;
    textField.borderStyle = UITextBorderStyleNone;
    textField.layer.cornerRadius = 5.f;
    textField.layer.masksToBounds = YES;
    textField.layer.borderColor = BORDER_GRAY_COLOR.CGColor;
    textField.layer.borderWidth = self.isViewMode ? 0.f : 1.f;;
    textField.font = FONT_SANSUMI(15.f);
    textField.textColor = self.isViewMode ? [UIColor whiteColor] : [UIColor blackColor];
    textField.autocorrectionType = UITextAutocorrectionTypeNo;

    textField.autoCompleteDataSource = self;
    textField.autoCompleteDelegate = self;

    textField.placeholder = @"";
    textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    textField.leftViewMode = UITextFieldViewModeAlways;
    if (flag) {
//        UIImageView *rightDropDownView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"select_clinic_dropdown.png"]];
//        rightDropDownView.left = textField.width - rightDropDownView.width - 10;
//        rightDropDownView.top = 0.5 * (textField.height - rightDropDownView.height);
//        [textField addSubview:rightDropDownView];
//        textField.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rightDropDownView.width + 10, 0)];
//        textField.rightViewMode = UITextFieldViewModeAlways;
        UIImageView *rightDropDownView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"select_clinic_dropdown.png"]];
        rightDropDownView.contentMode = UIViewContentModeCenter;
        rightDropDownView.width = 30;
        rightDropDownView.left = textField.width - rightDropDownView.width - 20;
        rightDropDownView.top = 0.5 * (textField.height - rightDropDownView.height);
        //        [textField addSubview:rightDropDownView];
        textField.rightView = rightDropDownView;//[[UIView alloc] initWithFrame:CGRectMake(0, 0, rightDropDownView.width + 10, 0)];
        textField.rightViewMode = UITextFieldViewModeAlways;
    }

    [self addSubview:textField];
    return textField;
}

- (void)changeTextFieldEditMode:(UITextField *)textField {
    textField.backgroundColor = self.isViewMode ? [UIColor clearColor] : [UIColor whiteColor];
    textField.enabled = !self.isViewMode;
    textField.borderStyle = UITextBorderStyleNone;
//    textField.layer.borderWidth = self.isViewMode ? 0.f : 1.f;
    textField.textColor = self.isViewMode ? [UIColor whiteColor] : [UIColor blackColor];
    textField.leftViewMode = self.isViewMode ? UITextFieldViewModeNever : UITextFieldViewModeAlways;
    textField.rightViewMode = self.isViewMode ? UITextFieldViewModeNever : UITextFieldViewModeAlways;
    textField.font = !self.isViewMode ? FONT_SANSUMI_BOLD(15.f) : FONT_SANSUMI(18.f);
}



- (UILabel *)labelWithFrame:(CGRect)frame withTitle:(NSString *)title {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
//    label.layer.borderWidth = 1.f;
    label.textColor = rgbColor(0, 164, 234);  //[UIColor whiteColor];
    label.font = FONT_SANSUMI_BOLD(10.f);
    label.textAlignment = NSTextAlignmentLeft;
    label.text = title;
    
    [self addSubview:label];
    return label;
}

- (void)createAndLayoutSubviews {
//    self.backgroundColor = UIColorFromRGBWithAlpha(0x19A7DC, 0.9);

    self.textFieldsDic = [NSMutableDictionary new];

//    top = 0.f;
//    labelWidth = 380.f;
//    labelHeight = 30.f;
//    textFieldHeight = 50.f;
//    left = 0.5 * (self.width - labelWidth);
//
//    self.titleInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, top, self.width, 20)];
//    self.titleInfoLabel.textAlignment = NSTextAlignmentCenter;
//    self.titleInfoLabel.textColor = [UIColor whiteColor];
//    self.titleInfoLabel.font = FONT_SANSUMI_BOLD(20.f);
//    self.titleInfoLabel.text = [self.titleStr uppercaseString];
//    self.titleInfoLabel.attributedText = [NSAttributedString attributedStringForButtonWithTitle:[self.titleStr uppercaseString] withBoldFontSize:20.f];
////    self.titleInfoLabel.layer.borderWidth = 1.f;
//    [self.titleInfoLabel sizeToFit];
//    self.titleInfoLabel.left = 0.5 * (self.width - self.titleInfoLabel.width);
//    UIView *leftLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0.5 * (self.titleInfoLabel.height - 1), self.titleInfoLabel.left - 5, 1)];
//    leftLine.backgroundColor = [UIColor whiteColor];
//    self.leftTitleLine = leftLine;
//    [self addSubview:leftLine];
//
//    CGFloat leftPos = self.titleInfoLabel.width + self.titleInfoLabel.left + 5;
//    UIView *rightLine = [[UIView alloc] initWithFrame:CGRectMake(leftPos, 0.5 * (self.titleInfoLabel.height - 1),
//            self.width - leftPos, 1)];
//    rightLine.backgroundColor = [UIColor whiteColor];
//    self.rightTitleLine = rightLine;
//    [self addSubview:rightLine];
//
////    [self.titleInfoLabel addTopBorderWithHeight:1 color:[UIColor whiteColor] leftOffset:0 rightOffset:0 andTopOffset:10];
//
//    [self addSubview:self.titleInfoLabel];
//
//    top += self.titleInfoLabel.height + 10.f;

}

- (void)populatePatientDetails {
    DLog(@"Populat Patient details (%@)", self);
}

- (BOOL)validateAndPopulatePatientDetails {
    DLog(@"Populat Patient details (%@)", self);
    __block BOOL result = NO;
    NSMutableSet *mandatoryTextFieldCodes = [NSMutableSet setWithArray:[self.textFieldsDic allKeys]];
    [mandatoryTextFieldCodes intersectSet:self.mandatoryFields];
    [mandatoryTextFieldCodes enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        if ([self.textFieldsDic[obj] isEmpty]) {
            result = YES;
//            *stop = YES;
        }
    }];

    if (result) {
        ALERT(TRANSLATE(@"Please, fill the empty fields."))
        [self.scrollView setContentOffset:CGPointMake(0, self.top) animated:YES];
        return result;
    }

    return NO;
}

- (BOOL)isEmptyTextField:(UITextField *)textField {
    if (textField.text.length == 0) {
        textField.layer.borderWidth = 2;
        textField.layer.borderColor = [[UIColor redColor] CGColor];
        return YES;
    }
    return NO;
}

//- (PatientPersonalDetails *)patientDetails {
//    return self.patientSignatureFormForShow.patient;
//}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (!self.isViewMode) {
        textField.layer.borderColor = BORDER_GRAY_COLOR.CGColor;
        textField.layer.borderWidth = 1.f;
    }
    return YES;
}

- (void)changeToOrientation:(UIInterfaceOrientation)orientation {
    DLog(@"Base info view change orientaion : %@", self);
    self.width = self.superview.width - 2 * self.left;
    self.titleInfoLabel.left = 0.5 * (self.width - self.titleInfoLabel.width);
    self.leftTitleLine.width = self.titleInfoLabel.left - 5;
    CGFloat leftPos = self.titleInfoLabel.width + self.titleInfoLabel.left + 5;
    self.rightTitleLine.left = leftPos;
    self.rightTitleLine.width = self.width - leftPos;
}

- (void)populateWithUserDetails {
    DLog(@"Populat User details (%@)", self);
}

#pragma mark - PickerPopover

- (void)pickerPopover:(PickerPopover *)pickerPopover didSelectedItem:(id)item atIndex:(NSInteger)index {

}

- (void)populateWithPatientSignature:(PatientSignatureFormForShow *)patientSignatureFormForShow {
    DLog(@"Populate with Patient Signature = %@", self);
    self.patientSignatureFormForShow = patientSignatureFormForShow;
}


- (void)populateWithPatientDetails:(PatientSignatureFormForShow *)patient {
    DLog(@"Populate with Patient details = %@", self);
}


@end