//
//  CusomtPickerPopover.m
//  ATRIUM
//
//  Created by Admin on 10/21/15.
//  Copyright (c) 2015 Global Solution. All rights reserved.
//

#import "CusomtPickerPopover.h"
@interface CusomtPickerPopover () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIViewController *pickerViewController;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, assign) NSInteger selectedRow;

@end
@implementation CusomtPickerPopover
- (instancetype)initWithItems:(NSArray *)items witTitle:(NSString *)title withSelectedIndex:(NSNumber *)selectedIndex {
    
    UIViewController *viewController = [[UIViewController alloc] init];
    UINavigationController *contentController = [[UINavigationController alloc] initWithRootViewController:viewController];
    self = [super initWithPresentedViewController:viewController presentingViewController:contentController];
    if (self) {
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:TRANSLATE(@"Cancel") style:UIBarButtonItemStyleBordered target:self action:@selector(cancelClicked:)];
        viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:TRANSLATE(@"Save") style:UIBarButtonItemStyleBordered target:self action:@selector(saveClicked:)];
        viewController.title = title;
        self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, SYSTEM_VERSION >= 8.0 ? 44 : 0, 320, 216)];
        //        self.pickerView.layer.borderWidth = 1.f;
        self.pickerView.height = 216;
        self.pickerView.showsSelectionIndicator = YES;
        self.pickerView.delegate = self;
        [viewController.view addSubview:self.pickerView];
        //        viewController.view = self.pickerView;
        
        //        contentController.view.layer.borderWidth = 2.f;
        //        contentController.view.layer.borderColor = [UIColor redColor].CGColor;
        //        contentController.contentSizeForViewInPopover = CGSizeMake(320, 216);
        //        contentController.preferredContentSize = CGSizeMake(320, 216);
        self.pickerViewController = viewController;
        self.items = items;
        self.selectedIndex = selectedIndex;
        
        if (selectedIndex) {
            [self.pickerView selectRow:[self.selectedIndex integerValue] inComponent:0 animated:NO];
        }
        
//        self.popoverContentSize = CGSizeMake(320, SYSTEM_VERSION >= 8.0 ? 220 : 260);
//        self.contentViewController.preferredContentSize = self.popoverContentSize;
        //        if (SYSTEM_VERSION >= 8.0) {
        //        self.contentViewController.preferredContentSize = self.popoverContentSize;
        //        }
        
        //        else {
        //            self.contentViewController.contentSizeForViewInPopover = self.popoverContentSize;
        //        }
    }
    return self;
}
#pragma mark - Class methods Implementation

- (UIBarButtonItem *)rightBarBtn {
    return self.pickerViewController.navigationItem.rightBarButtonItem;
}

- (void)setRightBarBtn:(UIBarButtonItem *)rightBarBtn {
    self.pickerViewController.navigationItem.rightBarButtonItem = rightBarBtn;
}

- (UIBarButtonItem *)leftBarBtn {
    return self.pickerViewController.navigationItem.leftBarButtonItem;
}

- (void)setLeftBarBtn:(UIBarButtonItem *)leftBarBtn {
    self.pickerViewController.navigationItem.leftBarButtonItem = leftBarBtn;
}


- (void)setDatePickerMode:(UIDatePickerMode)datePickerMode {
    self.datePicker.datePickerMode = datePickerMode;
}

- (UIDatePickerMode)datePickerMode {
    return self.datePicker.datePickerMode;
}

- (void)setMinuteInterval:(NSInteger)minuteInterval {
    _minuteInterval = minuteInterval;
    self.datePicker.minuteInterval = minuteInterval;
}


- (void)setDatePickerDate:(NSDate *)date {
    self.datePicker.date = date ? date : [NSDate date];
}

- (NSDate *)datePickerDate {
    return self.datePicker.date;
}

- (void)setTitle:(NSString *)title withItems:(NSArray *)items {
    self.pickerTitle = title;
    self.items = items;
    [self.pickerView reloadAllComponents];
    
}

- (void)setPickerTitle:(NSString *)pickerTitle {
    _pickerTitle = [pickerTitle copy];
//    [(UINavigationController *) self.contentViewController topViewController].title = _pickerTitle;
}

- (void)selectRow:(NSInteger)row {
    self.selectedRow = row;
    [self.pickerView selectRow:row inComponent:0 animated:NO];
}

- (void)cancelClicked:(id)sender {
    DLog(@"Cancel clicked");
    [self dismissalTransitionDidEnd:YES];
}

- (void)saveClicked:(id)sender {
    DLog(@"save clicked");
    if (self.isDatePickerType) {
        if ([self.customPickerDelegate respondsToSelector:@selector(pickerPopover:didChoosedDate:)]) {
            [self.customPickerDelegate pickerPopover:self didChoosedDate:self.datePicker.date];
        }
    } else {
        if ([self.customPickerDelegate respondsToSelector:@selector(pickerPopover:didSelectedItem:atIndex:)]) {
            [self.customPickerDelegate pickerPopover:self didSelectedItem:(self.items.count) ? self.items[self.selectedRow] : nil atIndex:self.selectedRow];
        }
    }
    
    [self dismissalTransitionDidEnd:YES];
}

#pragma mark - UIPicker Delegate & DataSource

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    DLog(@"selected item at index = %ld", (long) row);
    self.selectedRow = row;
    //    if ([self.pickerDelegate respondsToSelector:@selector(pickerPopover:didSelectedItem:atIndex:)]) {
    ////        [self.pickerDelegate pickerPopover:self didSelectedItem:self.items[row] atIndex:row];
    //    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if ([self.customPickerDelegate respondsToSelector:@selector(pickerView:numberOfRowsInComponent:)]) {
        return [self.customPickerDelegate pickerView:pickerView numberOfRowsInComponent:component];
    }
    
    return self.items.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}


- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if ([self.customPickerDelegate respondsToSelector:@selector(attributedStringItem:forItemAtIndex:)]) {
        return [self.customPickerDelegate attributedStringItem:self forItemAtIndex:row];
    }
    
    NSString *itemString = nil;
    if ([self.customPickerDelegate respondsToSelector:@selector(stringItem:forItemAtIndex:)]) {
        itemString = [self.customPickerDelegate stringItem:self forItemAtIndex:row];
    } else {
        id item = self.items[row];
        if ([item respondsToSelector:@selector(name)]) {
            itemString = [item name];
        } else {
            itemString = item;
        }
        
    }
    NSAttributedString *titleStr = [[NSAttributedString alloc] initWithString:itemString attributes:@{NSForegroundColorAttributeName : TEXT_GRAY_COLOR, NSFontAttributeName : FONT_SANSUMI(16.f)}];
    
    return titleStr;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    NSString *itemString = nil;
    if ([self.customPickerDelegate respondsToSelector:@selector(stringItem:forItemAtIndex:)]) {
        itemString = [self.customPickerDelegate stringItem:self forItemAtIndex:row];
    } else {
        id item = self.items[row];
        if ([item respondsToSelector:@selector(name)]) {
            itemString = [item name];
        } else {
            itemString = item;
        }
    }
    
    if (view == nil) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = TEXT_GRAY_COLOR;
        label.font = FONT_SANSUMI(16.f);
        view = label;
    }
    
    [(UILabel *) view setText:itemString];
    //    ((UILabel *)view).attributedText = [[NSAttributedString alloc] initWithString:itemString attributes:@{NSForegroundColorAttributeName : TEXT_GRAY_COLOR, NSFontAttributeName : FONT_SANSUMI(16.f)}];
    
    return view;
    
}

@end
