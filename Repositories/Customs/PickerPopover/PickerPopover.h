//
//  PickerPopover.h
//  Dental-iPad
//
//  Created by Sanch0 on 10/3/14.
//  Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PickerPopover;
@protocol PickerPopoverDelegate <NSObject>

@optional
- (void)pickerPopover:(PickerPopover *)pickerPopover didSelectedItem:(id)item atIndex:(NSInteger)index;
- (void)pickerPopover:(PickerPopover *)pickerPopover didChoosedDate:(NSDate *)date;
- (NSString *)stringItem:(PickerPopover *)pickerPopover forItemAtIndex:(NSInteger)index;
- (NSAttributedString *)attributedStringItem:(PickerPopover *)pickerPopover forItemAtIndex:(NSInteger)index;
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
@end


@interface PickerPopover : UIPopoverController

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) id selectedItem;
@property (nonatomic, assign) NSNumber *selectedIndex;
@property (nonatomic,   weak) id<PickerPopoverDelegate> pickerDelegate;

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
