//
// Created by Sanch0 on 11/27/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import "LabeledTextField.h"

@interface LabeledTextField()

@property (nonatomic, strong) UIImageView *rightArrow;

@end

@implementation LabeledTextField

- (id)initWithTitle:(NSString *)title withFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        self.layer.borderWidth = 1.f;

        if (title) {
            self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 25)];
            self.titleLabel.attributedText = [NSAttributedString attributedStringWithTitle:title withTextColor:TEXT_GRAY_COLOR withFontSize:13.f];   //       UIColorFromRGB(0xB2B2B2)
            [self addSubview:self.titleLabel];
        }

        self.textField = [[CustomTextField alloc] initWithFrame:CGRectMake(0, self.titleLabel.height, self.width, 50)];
        self.textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
        self.textField.leftViewMode = UITextFieldViewModeAlways;
        self.textField.borderStyle = UITextBorderStyleNone;
        self.textField.layer.cornerRadius = 5.f;
        self.textField.layer.masksToBounds = YES;
        self.textField.layer.borderColor = BORDER_GRAY_COLOR.CGColor;
        self.textField.layer.borderWidth = 1.f;
        self.textField.backgroundColor = [UIColor whiteColor];
        self.textField.textColor = UIColorFromRGB(0xb9b8b8);
        self.textField.font = FONT_SANSUMI(15.f);
        self.textField.autocorrectionType = UITextAutocorrectionTypeNo;

        [self addSubview:self.textField];
    }

    return self;
}

- (id)initWithTitle:(NSString *)title withFrame:(CGRect)frame withLeftPostionFieldWidth:(CGFloat)fieldWidth {
    self = [super initWithFrame:frame];
    if (self) {
        //        self.layer.borderWidth = 1.f;
        
        if (title) {
            self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, self.height)];
            self.titleLabel.attributedText = [NSAttributedString attributedStringWithTitle:title withTextColor:TEXT_GRAY_COLOR withFontSize:13.f];   //       UIColorFromRGB(0xB2B2B2)
            [self addSubview:self.titleLabel];
            if(fieldWidth <= 0) {
                self.titleLabel.width = [self.titleLabel.attributedText textWidth] + 30;
            } else {
                self.titleLabel.width = self.width - fieldWidth;
            }
        }
        
        self.textField = [[CustomTextField alloc] initWithFrame:CGRectMake(self.titleLabel.width, 0, self.width - self.titleLabel.width, self.height)];
        self.textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
        self.textField.leftViewMode = UITextFieldViewModeAlways;
        self.textField.borderStyle = UITextBorderStyleNone;
        self.textField.layer.cornerRadius = 5.f;
        self.textField.layer.masksToBounds = YES;
        self.textField.layer.borderColor = BORDER_GRAY_COLOR.CGColor;
        self.textField.layer.borderWidth = 1.f;
        self.textField.backgroundColor = [UIColor whiteColor];
        self.textField.textColor = UIColorFromRGB(0xb9b8b8);
        self.textField.font = FONT_SANSUMI(15.f);
        self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
        
        [self addSubview:self.textField];
    }
    
    return self;
}

- (void)setWithRightArrow:(BOOL)withRightArrow {
    _withRightArrow = withRightArrow;
    if (!self.rightArrow) {
        self.rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"select_clinic_dropdown.png"]];
        self.rightArrow.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        self.rightArrow.top = 0.5 * (self.textField.height - self.rightArrow.height);
        self.rightArrow.left = self.textField.width - self.rightArrow.width - 10.f;
        [self.textField addSubview:self.rightArrow];
    }

    if (_withRightArrow) {
        self.textField.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.rightArrow.width + 10, 0)];
        self.textField.rightViewMode = UITextFieldViewModeAlways;
    } else {
        self.textField.rightView = nil;
        self.textField.rightViewMode = UITextFieldViewModeNever;
    }
}

- (void)clear {
    [self.textField clear];
}

- (BOOL)isEmpty {
    return self.textField.isEmpty;
}

- (BOOL)isEmptyOrZeroValue {
    return self.textField.isEmptyOrZeroValue;
}


- (void)disable:(BOOL)disable {
    [self.textField disable:disable];
}


- (void)disableAndClear:(BOOL)disable {
    [self.textField disableAndClear:disable];
}

- (void)populateWithSelectItem:(SelectItem *)item {
    [self.textField populateWithSelectItem:item];
}


@end