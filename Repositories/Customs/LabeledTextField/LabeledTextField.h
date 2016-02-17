//
// Created by Sanch0 on 11/27/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CustomTextField.h"

@interface LabeledTextField : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) CustomTextField *textField;
@property (nonatomic, assign) BOOL withRightArrow;

- (id)initWithTitle:(NSString *)title withFrame:(CGRect)frame;
- (id)initWithTitle:(NSString *)title withFrame:(CGRect)frame withLeftPostionFieldWidth:(CGFloat)fieldWidth;

- (void)disableAndClear:(BOOL)disable;

- (void)disable:(BOOL)disable;

- (void)clear;

- (void)populateWithSelectItem:(SelectItem *)item;

- (BOOL)isEmpty;

- (BOOL)isEmptyOrZeroValue;


@end