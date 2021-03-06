//
//  CLBackspaceDetectingTextField.h
//  CLTokenInputView
//
//  Created by Rizwan Sattar on 2/24/14.
//  Copyright (c) 2014 Cluster Labs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLBackspaceDetectingTextField;
@protocol CLBackspaceDetectingTextFieldDelegate <UITextFieldDelegate>

- (void)textFieldDidDeleteBackwards:(UITextField *)textField;

@end

/**
 * CLBackspaceDetectingTextField is a very simple subclass
 * of UITextField that adds an extra delegate method to 
 * notify whenever the backspace key is pressed. Without
 * this delegate method, it is not possible to detect
 * if the backspace key is pressed while the textfield is 
 * empty.
 *
 * @since v1.0
 */
@interface CLBackspaceDetectingTextField : UITextField <UIKeyInput>

@property (weak, nonatomic) NSObject <CLBackspaceDetectingTextFieldDelegate> *delegate;

@end
// Copyright belongs to original author
// http://code4app.net (en) http://code4app.com (cn)
// From the most professional code share website: Code4App.net