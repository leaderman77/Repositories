//
// Created by Sanch0 on 3/10/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "LabeledTextView.h"


@implementation LabeledTextView {

}

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title {
    self = [super initWithFrame:frame];
    if (self) {
        if (title) {
            _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 25)];
            _titleLabel.attributedText = [NSAttributedString attributedStringWithTitle:title withTextColor:TEXT_GRAY_COLOR withFontSize:13.f];
            [self addSubview:_titleLabel];
        }


        _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, _titleLabel.height, self.width, self.height - _titleLabel.height)];
        _textView.layer.cornerRadius = 5.f;
        _textView.layer.borderWidth = 1.f;
        _textView.layer.borderColor = BORDER_GRAY_COLOR.CGColor;
        _textView.layer.masksToBounds = YES;
        _textView.font = FONT_SANSUMI(16);
        _textView.textColor = PICKER_CHOOSE_ITEM_TEXT_COLOR;
        _textView.autocorrectionType = UITextAutocorrectionTypeNo;
        [self addSubview:_textView];

    }
    return self;
}

@end