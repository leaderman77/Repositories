//
// Created by Sanch0 on 12/1/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import "LabeledPhoneTextField.h"
#import "CustomTextField.h"
#import "PickerPopover.h"
//#import "Country.h"
//#import "NSString+ObjectiveSugar.h"

#define COUNTRY_TEXT_FIELD_WIDTH 90.f
#define CITY_TEXT_FIELD_WIDTH 75.f
#define PADDING 10.f
#define TEXT_FIELD_HEIGHT 50.f

@interface LabeledPhoneTextField()<PickerPopoverDelegate>

@property (nonatomic, strong) PickerPopover *pickerPopover;
@end

@implementation LabeledPhoneTextField

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createAndLayoutSubviews];
    }

    return self;
}


- (id)initWithFrame:(CGRect)frame withPhoneNumber:(NSString *)phoneNumber {
    self = [super initWithFrame:frame];
    if (self) {
        [self createAndLayoutSubviews];
        if (phoneNumber.length > 0) {
            self.phoneNumber = phoneNumber;
        }

    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withCountryCode:(NSString *)countyCode {
    self = [super initWithFrame:frame];
    if (self) {
        [self createAndLayoutSubviews];
//        if (countyCode.length > 0) {
//            NSString *countryName = [[SettingsManager sharedManager] sessionData].clinic.address.country.name;
//            [self.pickerPopover.items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//                if (countryName.length > 0) {
//                    if ([obj[@"name"] containsString:countryName]) {
//                        self.countryCodeTextField.text = countyCode;
//                        self.countryCodeTextField.selectedIndex = @(idx);
//                        *stop = YES;
//                    }
//                } else if ([obj[@"phoneCode"] isEqualToString:countyCode]) {
//                    self.countryCodeTextField.text = countyCode;
//                    self.countryCodeTextField.selectedIndex = @(idx);
//                    *stop = YES;
//                }
//            }];
//        }
    }
    return self;

}

- (void)setIsViewMode:(BOOL)isViewMode {
    _isViewMode = isViewMode;

}


- (void)createAndLayoutSubviews {

//    self.layer.borderWidth = 1.f;

    self.pickerPopover = [[PickerPopover alloc] initWithItems:[[SettingsManager sharedManager] sortedCountries] witTitle:TRANSLATE(@"Choose country:") withSelectedIndex:nil];
    self.pickerPopover.pickerDelegate = self;

    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 25)];
    self.titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.titleLabel.attributedText = [NSAttributedString attributedStringWithTitle:TRANSLATE(@"Phone number:") withTextColor:UIColorFromRGB(0xB2B2B2) withFontSize:13.f];
    [self addSubview:self.titleLabel];

    CGFloat top = self.titleLabel.height;
    CGFloat left = 0;
    self.countryCodeTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(left, top, COUNTRY_TEXT_FIELD_WIDTH, TEXT_FIELD_HEIGHT) withAppSettings:YES];
    self.countryCodeTextField.delegate = self;
    self.countryCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:self.countryCodeTextField];

    left += self.countryCodeTextField.width + PADDING;
    self.cityCodeTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(left, top, CITY_TEXT_FIELD_WIDTH, TEXT_FIELD_HEIGHT) withAppSettings:YES];
    self.cityCodeTextField.delegate = self;
    self.cityCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:self.cityCodeTextField];

    left += self.cityCodeTextField.width + PADDING;
    self.phoneNumberTextField = [[CustomTextField alloc] initWithFrame:CGRectMake(left, top, self.width - left, TEXT_FIELD_HEIGHT) withAppSettings:YES];
    self.phoneNumberTextField.delegate = self;
    self.phoneNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    [self addSubview:self.phoneNumberTextField];
}

- (void)setViewWidth:(CGFloat)width {
    self.width = width;
//    CGFloat top = self.titleLabel.height;
//    CGFloat left = 0;
    self.phoneNumberTextField.width = self.width - self.phoneNumberTextField.left;
}


- (void)setPhoneNumber:(NSString *)phoneNumber {
    phoneNumber = [phoneNumber trim];
    if (phoneNumber.length == 0) {
        return;
    };

    if ([phoneNumber hasPrefix:@"+"]) {
        phoneNumber = [phoneNumber substringFromIndex:1];
    }
    NSArray *phoneNumbers = [[phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""] componentsSeparatedByCharactersInSet:[NSCharacterSet
            characterSetWithCharactersInString:@"()"]];
    self.phoneNumberTextField.text = phoneNumber;
    if (phoneNumbers.count < 3) {
        DLog(@"INVALID PHONE NUMBER");
        return;
    }

    @try {
        self.countryCodeTextField.text = phoneNumbers[0];
        self.cityCodeTextField.text = phoneNumbers[1];
        self.phoneNumberTextField.text = phoneNumbers[2];
    } @catch(NSException *exception) {
        DLog(@"phone number exception : %@", exception);
    }

}

- (void)clear {
    [self.cityCodeTextField clear];
    [self.phoneNumberTextField clear];
}


- (BOOL)validate {
    return [self.countryCodeTextField.text trim].length > 0 && [self.cityCodeTextField.text trim].length > 0 && [self.phoneNumberTextField.text trim].length > 0;
}

- (BOOL)isEmpty {
    BOOL result = [self.countryCodeTextField isEmpty];
    result = [self.cityCodeTextField isEmpty] || result;
    result = [self.phoneNumberTextField isEmpty] || result;
    return result;
}

- (BOOL)isEmptyCityCodeAndPhone {
    return self.cityCodeTextField.text.trim.length == 0 || self.phoneNumberTextField.text.trim.length == 0;
}


- (NSString *)phoneNumber {
    return [NSString stringWithFormat:@"+%@(%@)%@", [self.countryCodeTextField.text trim], [self.cityCodeTextField.text trim], [self.phoneNumberTextField.text trim]];
}

- (NSString *)phoneNumberForSearch {
    if (self.isEmptyCityCodeAndPhone) {
        return @"";
    }
    if ([self.cityCodeTextField.text trim].length > 0 || [self.phoneNumberTextField.text trim].length > 0) {
        return self.phoneNumber;
    }
    return [NSString stringWithFormat:@"%@%@%@", [self.countryCodeTextField.text trim], [self.cityCodeTextField.text trim], [self.phoneNumberTextField.text trim]];
}


//- (void)setTextFieldsDelegate:(id <UITextFieldDelegate>)delegate {
//    self.countryCodeTextField.delegate = delegate;
//    self.cityCodeTextField.delegate = delegate;
//    self.phoneNumberTextField.delegate = delegate;
//}


- (void)setTextColor:(UIColor *)color {

     self.countryCodeTextField.textColor = color;
     self.cityCodeTextField.textColor = color;
     self.phoneNumberTextField.textColor = color;
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    textField.layer.borderWidth = 1.f;
    textField.layer.borderColor = BORDER_GRAY_COLOR.CGColor;

    if (textField == self.countryCodeTextField) {
        [self.cityCodeTextField resignFirstResponder];
        [self.phoneNumberTextField resignFirstResponder];
        [self.pickerPopover selectRow:[self.countryCodeTextField.selectedIndex integerValue]];
//        [self.pickerPopover presentPopoverFromRect:self.countryCodeTextField.frame inView:self permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        return NO;
    }

    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSCharacterSet *decimalDigits = [NSCharacterSet decimalDigitCharacterSet];
    return string.length == 0 || [string rangeOfCharacterFromSet:decimalDigits].location != NSNotFound;
}

- (BOOL)textFieldShouldReturn:(CustomTextField *)textField {
    if([self.textFieldsDelegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [self.textFieldsDelegate textFieldShouldReturn:textField];
    }
    return YES;
}

#pragma mark - PickerPopoverDelegate

- (void)pickerPopover:(PickerPopover *)pickerPopover didSelectedItem:(id)item atIndex:(NSInteger)index {
    self.selectedCountry = item;
    self.countryCodeTextField.text = item[@"phoneCode"];
    self.countryCodeTextField.tagObject = item;
    self.countryCodeTextField.selectedIndex = @(index);
}

- (NSString *)stringItem:(PickerPopover *)pickerPopover forItemAtIndex:(NSInteger)index {
    NSDictionary *item = pickerPopover.items[index];
    NSString *countryWithCodeStr = [NSString stringWithFormat:@"%@ (%@)", item[@"name"], item[@"phoneCode"]];

    return countryWithCodeStr;
}

@end