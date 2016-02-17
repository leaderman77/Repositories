//
//  CustomTextField.m
//  Dental-iPad
//
//  Created by Sanch0 on 10/27/14.
//  Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import "CustomTextField.h"

#define PRELOADER_PADDING 3.f

@interface CustomTextField ()

@property (nonatomic, strong) UIImageView *rightArrow;
@end

@implementation CustomTextField

- (id)initWithFrame:(CGRect)frame withAppSettings:(BOOL)appSettings {
    self = [super initWithFrame:frame];
    if (self) {
        self.autocorrectionType = UITextAutocorrectionTypeNo;
        if (appSettings) {
            self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
            self.leftViewMode = UITextFieldViewModeAlways;
            self.borderStyle = UITextBorderStyleNone;
            self.layer.cornerRadius = 5.f;
            self.layer.masksToBounds = YES;
            self.layer.borderColor = BORDER_GRAY_COLOR.CGColor;
            self.layer.borderWidth = 1.f;
            self.backgroundColor = [UIColor whiteColor];
            self.textColor = UIColorFromRGB(0xb9b8b8);
            self.font = FONT_SANSUMI(15.f);
            self.autocorrectionType = UITextAutocorrectionTypeNo;
        }
    }

    return self;
}

- (void)setRightArrowVisible:(BOOL)rightArrowVisible {
    _rightArrowVisible = rightArrowVisible;
    if (!self.rightArrow) {
        self.rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dropdown.png"]];
        self.rightArrow.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        self.rightArrow.top = 0.5 * (self.height - self.rightArrow.height);
        self.rightArrow.left = self.width - self.rightArrow.width - 10.f;
        self.rightViewMode = UITextFieldViewModeAlways;
        [self addSubview:self.rightArrow];
    }

    self.rightArrow.hidden = !_rightArrowVisible;
    self.rightView = _rightArrowVisible ? [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.rightArrow.width + 10, 0)] : nil;
    self.rightViewMode = _rightArrowVisible ? UITextFieldViewModeAlways : UITextFieldViewModeNever;
}

- (void)setIsViewMode:(BOOL)isViewMode {
    _isViewMode = isViewMode;
    self.font = self.isViewMode ? FONT_SANSUMI_BOLD(15.f) : FONT_SANSUMI(15.f);
    self.textColor = self.isViewMode ? [UIColor whiteColor] : [UIColor blackColor];
    self.leftViewMode = self.isViewMode ? UITextFieldViewModeNever : UITextFieldViewModeAlways;
    self.backgroundColor = self.isViewMode ? [UIColor clearColor] : [UIColor whiteColor];
    if (self.isViewMode) {
        self.rightArrowVisible = NO;
    } else {
        self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    }
}


- (void)showRightLoader:(BOOL)show {
    if (show) {
        UIActivityIndicatorView *preloader = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        CGFloat height = self.height - 2 * PRELOADER_PADDING;
        preloader.frame = CGRectMake(0, 0.5 * (self.height - height), height, height);
        [preloader startAnimating];
        self.rightView = preloader;
        self.rightViewMode = UITextFieldViewModeAlways;
    } else {
        self.rightView = nil;
        self.rightViewMode = UITextFieldViewModeNever;
    }
}

- (void)disableAndClearWithDarkGreyColor:(BOOL)disable {
    self.backgroundColor = disable ? rgbColor(198, 198, 198) : [UIColor whiteColor];     //rgbColor(242, 242, 242)
    self.enabled = !disable;
    if (disable) {
        self.tagObject = nil;
        self.text = @"";
        self.selectedIndex = nil;
    }
}

- (void)disableAndClear:(BOOL)disable {
    self.backgroundColor = disable ? rgbColor(242, 242, 242) : [UIColor whiteColor];     //rgbColor(242, 242, 242)
    self.enabled = !disable;
    if (disable) {
        self.tagObject = nil;
        self.text = @"";
        self.selectedIndex = nil;
    }
}

- (void)disable:(BOOL)flag {
    self.backgroundColor = flag ? rgbColor(242, 242, 242) : [UIColor whiteColor];     //rgbColor(242, 242, 242)
    self.enabled = !flag;
}


- (void)populateWithSelectItem:(SelectItem *)item {
    self.tagObject = item;
    self.text = item.name;
    self.selectedIndex = [SelectItem indexOfSelectedItem:item withArray:self.pickerItems];
}

- (void)populateWithSelectItemIndex:(NSNumber *)index {
    SelectItem *selectItem = index && index.integerValue < self.pickerItems.count ? self.pickerItems[index.integerValue] : nil;
    self.tagObject = selectItem;
    self.text = selectItem.name;
}

- (void)populateWithPickerItems:(NSArray *)pickerItems withSelectItemIndex:(NSNumber *)index {
    self.pickerItems = pickerItems;
    [self populateWithSelectItemIndex:index];
}


- (void)populateWithSelectItem:(SelectItem *)item withViewMode:(BOOL)viewMode {
    self.tagObject = item;
    self.text = (viewMode && item.name.trim.length == 0) ? TRANSLATE(@"N/A") : item.name;
    self.selectedIndex = [SelectItem indexOfSelectedItem:item withArray:self.pickerItems];

}

- (void)clear {
    self.tagObject = nil;
    self.text = @"";
    self.selectedIndex = nil;
}

- (void)clearWithPlaceHolder:(NSString *)placeHolder {
    [self clear];
    self.placeholder = placeHolder;
}

- (BOOL)isEmpty {
    return [self isEmptyItem];
}


- (BOOL)isEmptyItem {
    if (self.text.trim.length == 0 || (self.tagObject && ([self.tagObject isKindOfClass:[SelectItem class]] && ![self.tagObject objectId]))) {
        self.layer.borderColor = [[UIColor redColor] CGColor];
        self.layer.borderWidth = 3.f;
        return YES;
    }
    return NO;
}

- (void)addGrayBorderColor {
    self.layer.borderColor = [BORDER_GRAY_COLOR CGColor];
    self.layer.borderWidth = 1.f;
}

- (void)addRedBorderColor {
    self.layer.borderColor = [[UIColor redColor] CGColor];
    self.layer.borderWidth = 3.f;
}

- (BOOL)isEmptyOrZeroValue {
    return self.text.trim.floatValue == 0;
}
@end
