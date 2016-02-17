//
// Created by Sanch0 on 1/12/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LabeledButton;

@protocol LabeledButtonDelegate <NSObject>

- (void)labeledButtonDidBtnClicked:(LabeledButton *)labeledButton;
@end


@interface LabeledButton : UIControl

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) CustomBtn *btn;
@property (nonatomic, assign) BOOL withRightArrow;
@property (nonatomic, strong) id text;
@property (nonatomic, strong) id tagObject;

@property (nonatomic, weak) id <LabeledButtonDelegate> delegate;

@property (nonatomic, strong) NSString *pickerTitle;
@property (nonatomic, strong) NSArray *pickerItems;
@property (nonatomic, strong) NSNumber *selectedIndex;


- (id)initWithTitle:(NSString *)title withFrame:(CGRect)frame;

- (id)initWithTitle:(NSString *)title withFrame:(CGRect)frame withLeftPostionFieldWidth:(CGFloat)fieldWidth;
- (id)initWithTitle:(NSString *)title withFrame:(CGRect)frame withPosition:(BOOL)isLeft;

- (void)disable:(BOOL)disable;

- (void)clear;

- (BOOL)isEmptyItem;

- (BOOL)isEmpty;

- (void)populateWithSelectItem:(SelectItem *)item;

- (void)populateWithItem:(id)item withSelectedIndex:(NSNumber *)selectedIndex;

- (void)showRightLoader:(BOOL)show;

@end