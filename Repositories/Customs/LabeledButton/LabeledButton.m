//
// Created by Sanch0 on 1/12/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "LabeledButton.h"


@interface LabeledButton ()

@property (nonatomic, strong) UIImageView *rightArrow;
@property (nonatomic, assign) BOOL isTitlePositionLeft;

@end

@implementation LabeledButton {

}

- (id)initWithTitle:(NSString *)title withFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        if (title) {
            self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 25)];
            self.titleLabel.attributedText = [NSAttributedString attributedStringWithTitle:title withTextColor:TEXT_GRAY_COLOR withFontSize:13.f];
            [self addSubview:self.titleLabel];
            self.titleLabel.userInteractionEnabled = NO;
        }

        self.btn = [[CustomBtn alloc] initWithFrame:CGRectMake(0, self.titleLabel.height, self.width, self.height - self.titleLabel.height)];
        self.btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        self.btn.layer.cornerRadius = 5.f;
        self.btn.layer.masksToBounds = YES;
        self.btn.layer.borderWidth = 1.f;
        self.btn.layer.borderColor = BORDER_GRAY_COLOR.CGColor;
        self.btn.titleLabel.textColor = PICKER_CHOOSE_ITEM_TEXT_COLOR;
        [self.btn setTitleColor:UIColorFromRGB(0xb9b8b8) forState:UIControlStateNormal];
        [self.btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [self.btn setTitleColor:UIColorFromRGB(0xb9b8b8) forState:UIControlStateHighlighted];

        [self addSubview:self.btn];
    }

    return self;
}

- (id)initWithTitle:(NSString *)title withFrame:(CGRect)frame withLeftPostionFieldWidth:(CGFloat)fieldWidth {
    self = [super initWithFrame:frame];
    if (self) {
        
        if (title) {
            
            self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, self.height)];
            self.titleLabel.attributedText = [NSAttributedString attributedStringWithTitle:title withTextColor:TEXT_GRAY_COLOR withFontSize:13.f];
            self.titleLabel.userInteractionEnabled = NO;
            if(fieldWidth <= 0) {
                self.titleLabel.width = [self.titleLabel.attributedText textWidth] + 30;
            } else {
                self.titleLabel.width = self.width - fieldWidth;
                self.titleLabel.numberOfLines = 2;
            }
            [self addSubview:self.titleLabel];
            self.titleLabel.userInteractionEnabled = NO;
        }
        self.btn = [[CustomBtn alloc] initWithFrame:CGRectMake(self.titleLabel.width, 0, self.width - self.titleLabel.width, self.height)];
        
        self.btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //        self.btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        self.btn.layer.cornerRadius = 5.f;
        self.btn.layer.masksToBounds = YES;
        self.btn.layer.borderWidth = 1.f;
        self.btn.layer.borderColor = BORDER_GRAY_COLOR.CGColor;
        self.btn.titleLabel.textColor = PICKER_CHOOSE_ITEM_TEXT_COLOR;
        [self.btn setTitleColor:UIColorFromRGB(0xb9b8b8) forState:UIControlStateNormal];
        [self.btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        //        [self.btn setTitleColor:UIColorFromRGB(0xb9b8b8) forState:UIControlStateHighlighted];
        
        [self addSubview:self.btn];
    }
    
    return self;

}

- (id)initWithTitle:(NSString *)title withFrame:(CGRect)frame withPosition:(BOOL)isLeft {
    self = [super initWithFrame:frame];
    if (self) {
        
        if (title) {
            if(isLeft) {
                self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, self.height)];
            } else {
                self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 25)];
            }
            self.titleLabel.attributedText = [NSAttributedString attributedStringWithTitle:title withTextColor:TEXT_GRAY_COLOR withFontSize:13.f];
            if(isLeft) {
                self.titleLabel.width = [self.titleLabel.attributedText textWidth] + 30;
            }
            [self addSubview:self.titleLabel];
            self.titleLabel.userInteractionEnabled = NO;
        }
        if(isLeft) {
            self.btn = [[CustomBtn alloc] initWithFrame:CGRectMake(self.titleLabel.width, 0, self.width - self.titleLabel.width, self.height)];
        } else {
            self.btn = [[CustomBtn alloc] initWithFrame:CGRectMake(0, self.titleLabel.height, self.width, self.height - self.titleLabel.height)];
        }
        
        self.btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        self.btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        self.btn.layer.cornerRadius = 5.f;
        self.btn.layer.masksToBounds = YES;
        self.btn.layer.borderWidth = 1.f;
        self.btn.layer.borderColor = BORDER_GRAY_COLOR.CGColor;
        self.btn.titleLabel.textColor = PICKER_CHOOSE_ITEM_TEXT_COLOR;
        [self.btn setTitleColor:UIColorFromRGB(0xb9b8b8) forState:UIControlStateNormal];
        [self.btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        //        [self.btn setTitleColor:UIColorFromRGB(0xb9b8b8) forState:UIControlStateHighlighted];
        
        [self addSubview:self.btn];
    }
    
    return self;
}

- (id)initCheckableWithTitle:(NSString *)title withFrame:(CGRect)frame withPosition:(BOOL)isLeft {
    return nil;
}


- (void)setWithRightArrow:(BOOL)withRightArrow {
    _withRightArrow = withRightArrow;
    if (!self.rightArrow) {
        self.rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"select_clinic_dropdown.png"]];
        self.rightArrow.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        self.rightArrow.top = 0.5 * (self.btn.height - self.rightArrow.height);
        self.rightArrow.left = self.btn.width - self.rightArrow.width - 10.f;
        [self.btn addSubview:self.rightArrow];
    }
    self.rightArrow.hidden = !_withRightArrow;
    self.btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, _withRightArrow ? 15 : 0);
}

- (void)btnClicked:(id)sender {
    if ([self.delegate respondsToSelector:@selector(labeledButtonDidBtnClicked:)]) {
        [self.delegate labeledButtonDidBtnClicked:self];
    }
}

- (void)setTagObject:(id)tagObject {
    _tagObject = tagObject;
    if (_tagObject) {
        self.btn.layer.borderWidth = 1.f;
        self.btn.layer.borderColor = BORDER_GRAY_COLOR.CGColor;
    }

}


- (void)setText:(id)text {
    self.btn.text = text;
}

- (id)text {
    return self.btn.text;
}

- (void)clear {
    self.tagObject = nil;
    self.btn.text = nil;
    self.selectedIndex = nil;

}


- (void)disable:(BOOL)disable {
    self.btn.enabled = !disable;
    self.btn.backgroundColor = disable ? rgbColor(242, 242, 242) : [UIColor whiteColor];
    self.btn.alpha = disable ? 0.5 : 1;

}

- (void)populateWithItem:(SelectItem *)item withSelectedIndex:(NSNumber *)selectedIndex {
    self.tagObject = item;
    self.btn.text = [NSAttributedString attributedStringWithTitle:item.name
                                                    withTextColor:UIColorFromRGB(0xb9b8b8)
                                                     withFontSize:15.f];
    self.selectedIndex = selectedIndex;
}


- (void)populateWithSelectItem:(SelectItem *)item {
    self.selectedIndex = [SelectItem indexOfSelectedItem:item withArray:self.pickerItems];
    if (self.selectedIndex) {
        SelectItem *selectedItem = self.pickerItems[self.selectedIndex.integerValue];
        self.tagObject = selectedItem;
        self.btn.text = [NSAttributedString attributedStringWithTitle:selectedItem.name
                                                        withTextColor:UIColorFromRGB(0xb9b8b8)
                                                         withFontSize:15.f];
    } else {
        self.tagObject = nil;
        self.btn.text = nil;
    }
}

- (BOOL)isEmptyItem {

    if ([self.btn.text length] == 0 || !self.tagObject || ([self.tagObject isKindOfClass:[SelectItem class]] && ![self.tagObject objectId])) {
        self.btn.layer.borderColor = [[UIColor redColor] CGColor];
        self.btn.layer.borderWidth = 3.f;
        return YES;
    }
    return NO;
}

- (BOOL)isEmpty {
    return self.isEmptyItem;
}


- (void)showRightLoader:(BOOL)show {
    self.rightArrow.hidden = show;
    if (show) {
        UIActivityIndicatorView *preloader = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        CGFloat height = self.height - 2 * 3;
        preloader.tag = PRELOADER_TAG;
        preloader.frame = CGRectMake(self.btn.width - height - 3, 0.5 * (self.height - height), height, height);
        [preloader startAnimating];
        self.btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, height + 3);
    } else {
        [[self.btn viewWithTag:PRELOADER_TAG] removeFromSuperview];
        self.btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    }
}
@end