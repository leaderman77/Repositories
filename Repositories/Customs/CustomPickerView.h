//
//  CustomPickerView.h
//  ATRIUM
//
//  Created by Admin on 11/4/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UIPickerView;
@protocol CustomPickerViewDelegate <NSObject>

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
- (void)pickerPopover:(UIPickerView *)pickerPopover didSelectedItem:(id)item atIndex:(NSInteger)index;
@end

@interface CustomPickerView : UIView<UIPickerViewDataSource, UIPickerViewDelegate> {
    
}
@property (nonatomic, assign, readonly) UIPickerView *picker;
@property (nonatomic, weak) id<CustomPickerViewDelegate>delegate;

- (void) addTargetForDoneButton: (id) target action: (SEL) action;
- (void) addTargetForCancelButton: (id) target action: (SEL) action;
@end
