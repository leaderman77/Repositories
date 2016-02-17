//
//  CusomtPickerPopover.h
//  ATRIUM
//
//  Created by Admin on 10/21/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CusomtPickerPopover;

@protocol CustomPickerPopover <NSObject>

@optional
- (void)pickerPopover:(CusomtPickerPopover *)pickerPopover didSelectedItem:(id)item atIndex:(NSInteger)index;
- (void)pickerPopover:(CusomtPickerPopover *)pickerPopover didChoosedDate:(NSDate *)date;
- (NSString *)stringItem:(CusomtPickerPopover *)pickerPopover forItemAtIndex:(NSInteger)index;
- (NSAttributedString *)attributedStringItem:(CusomtPickerPopover *)pickerPopover forItemAtIndex:(NSInteger)index;
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
@end

@interface CusomtPickerPopover : UIPopoverPresentationController
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) id selectedItem;
@property (nonatomic, assign) NSNumber *selectedIndex;
@property (nonatomic,   weak) id<CustomPickerPopover> customPickerDelegate;

@property (nonatomic, copy) NSString *rightBtnTitle;
@property (nonatomic, copy) NSString *pickerTitle;
@property (nonatomic, copy) NSString *leftBtnTitle;
@property (nonatomic, strong) UIBarButtonItem *leftBarBtn;
@property (nonatomic, strong) UIBarButtonItem *rightBarBtn;

@property (nonatomic, strong) NSDate *datePickerDate;
@property (nonatomic, assign) UIDatePickerMode datePickerMode;
@property (nonatomic, assign) NSInteger minuteInterval;

@property (nonatomic, assign) BOOL isDatePickerType;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) id tagObject;

- (id)initWithItems:(NSArray *)items withSelectedIndex:(NSNumber *)selectedIndex;
- (instancetype)initWithItems:(NSArray *)items witTitle:(NSString *)title withSelectedIndex:(NSNumber *)selectedIndex;
- (id)initWithDate:(NSDate *)date;


- (void)selectRow:(NSInteger)row;
- (void)setTitle:(NSString *)title withItems:(NSArray *)items;
@end
