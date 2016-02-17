//
//  CustomTextField.h
//  Dental-iPad
//
//  Created by Sanch0 on 10/27/14.
//  Copyright (c) 2014 Finnet Limited. All rights reserved.
//



@interface CustomTextField : UITextField

@property (nonatomic, strong) id tagObject;
@property (nonatomic, strong) NSString *pickerTitle;
@property (nonatomic, strong) NSArray *pickerItems;
@property (nonatomic, strong) NSNumber *selectedIndex;
@property (nonatomic, assign) BOOL rightArrowVisible;
@property (nonatomic, assign) BOOL isViewMode;


- (id)initWithFrame:(CGRect)frame withAppSettings:(BOOL)appSettings;

- (void)showRightLoader:(BOOL)show;

- (void)disableAndClear:(BOOL)disable;

- (void)disableAndClearWithDarkGreyColor:(BOOL)disable;

- (void)disable:(BOOL)flag;

- (void)clear;

- (void)clearWithPlaceHolder:(NSString *)placeHolder;

- (void)populateWithSelectItem:(SelectItem *)item;

- (void)populateWithSelectItemIndex:(NSNumber *)index;

- (void)populateWithPickerItems:(NSArray *)pickerItems withSelectItemIndex:(NSNumber *)index;

- (void)populateWithSelectItem:(SelectItem *)item withViewMode:(BOOL)viewMode;

- (BOOL)isEmptyItem;

- (void)addRedBorderColor;

- (void)addGrayBorderColor;

- (BOOL)isEmptyOrZeroValue;
@end
