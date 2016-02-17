//
// Created by Sanch0 on 1/29/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "CustomSearchBar.h"

#define INDICATOR_HEIGHT_WIDTH 15.f

@interface CustomSearchBar ()

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@end

@implementation CustomSearchBar {

}


- (void)showRightLoader:(BOOL)flag {
    if (flag) {
        if (!self.indicatorView) {
            self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            self.indicatorView.frame = CGRectMake(self.width - INDICATOR_HEIGHT_WIDTH - 15, 0.5 * (self.height - INDICATOR_HEIGHT_WIDTH), INDICATOR_HEIGHT_WIDTH, INDICATOR_HEIGHT_WIDTH);
            [self addSubview:self.indicatorView];
        }
        [self.indicatorView startAnimating];
    } else {
        [self.indicatorView stopAnimating];
    }

    [self showClearButton:!flag fromView:self];
}

- (void)showClearButton:(BOOL)flag fromView:(UIView *)view {
    if (!view) {
        return;
    }

    for (UIView *subview in view.subviews) {
        [self showClearButton:flag fromView:subview];
    }

    if ([view conformsToProtocol:@protocol(UITextInputTraits)]) {
        UITextField *textView = (UITextField *) view;
        if ([textView respondsToSelector:@selector(setClearButtonMode:)]) {
            [textView setClearButtonMode:flag ? UITextFieldViewModeAlways : UITextFieldViewModeNever];
        }
    }
}

@end