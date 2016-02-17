//
// Created by Sanch0 on 12/1/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CustomTextField;


@interface LabeledPhoneTextField : UIView<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) CustomTextField *countryCodeTextField;
@property (nonatomic, strong) CustomTextField *cityCodeTextField;
@property (nonatomic, strong) CustomTextField *phoneNumberTextField;
@property (nonatomic, strong) id selectedCountry;
@property (nonatomic, assign) BOOL isViewMode;

@property (nonatomic, strong) NSString *phoneNumber;

//- (void)setTextFieldsDelegate:(id<UITextFieldDelegate>)delegate;
@property (nonatomic, weak) id<UITextFieldDelegate>textFieldsDelegate;

- (id)initWithFrame:(CGRect)frame withPhoneNumber:(NSString *)phoneNumber;
- (id)initWithFrame:(CGRect)frame withCountryCode:(NSString *)countyCode;

- (void)setTextColor:(UIColor *)color;

- (void)setViewWidth:(CGFloat)width;

- (NSString *)phoneNumberForSearch;

- (void)clear;
- (BOOL)validate;
- (BOOL)isEmpty;

- (BOOL)isEmptyCityCodeAndPhone;


@end