//
//  CustomTextView.h
//  Dental-iPad
//
//  Created by Mirzohidbek on 3/24/15.
//  Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTextView : UITextView

@property (nonatomic, strong) id tagObject;
@property (nonatomic, strong) NSString *pickerTitle;
@property (nonatomic, strong) NSArray *pickerItems;
@property (nonatomic, strong) NSNumber *selectedIndex;
@property (nonatomic, assign) BOOL isViewMode;

@end
