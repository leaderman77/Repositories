//
// Created by Sanch0 on 1/29/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CustomSearchBar : UISearchBar

@property (nonatomic, strong) UIFont *textFieldFont;

- (void)showRightLoader:(BOOL)flag;

@end