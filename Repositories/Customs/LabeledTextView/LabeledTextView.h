//
// Created by Sanch0 on 3/10/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LabeledTextView : UIView

@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong, readonly) UITextView *textView;

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title;

@end