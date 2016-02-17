//
// Created by Sanch0 on 11/21/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (TextAdditions)

- (void)setLineSpacing:(CGFloat)lineSpacing;

- (void)setLineSpacing:(CGFloat)lineSpacing withTextAlignment:(NSTextAlignment)textAlignment;

- (void)setLineSpacing:(CGFloat)lineSpacing withRange:(NSRange)range;
@end