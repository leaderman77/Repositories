//
//  RepositoriesTypeController.m
//  Repositories
//
//  Created by Admin on 2/15/16.
//  Copyright (c) 2016 microapps. All rights reserved.
//

#import "RepositoriesTypeController.h"
#import "RepositoriesViewController.h"

@interface RepositoriesTypeController ()<UITextFieldDelegate, UIActionSheetDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
@property (retain, nonatomic) UILabel *langLabel;
@property (strong, nonatomic) UITextField *langField;

@property (nonatomic, strong) UIPickerView *positionPicker;
@property (nonatomic, strong) NSArray *pickerData;

@property (strong, nonatomic) UIButton *showButton;
@end

@implementation RepositoriesTypeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = rgbColor(22, 168, 235);
    [self configureNavigationBar];
    [self populateControls];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.navigationBar.barTintColor = rgbColor(83, 140, 9);
}
- (void)configureNavigationBar {
    [super configureNavigationBar];
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 60)];
    self.topView.backgroundColor = rgbColor(132, 188, 56);
    
    UIButton *titleButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 23, self.topView.width - 20, 30)];
    titleButton.text = [TRANSLATE(@"Search Repositories") uppercaseString];
    titleButton.titleColor = rgbColor(255, 255, 255);
    titleButton.titleLabel.font = FONT_SANSUMI(16);
    [self.topView addSubview:titleButton];
    
    [self.view addSubview:self.topView];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)populateControls {
    CGFloat top = 0.17* self.view.height;
    CGFloat left = 10;
    CGFloat height = 40;
    CGFloat labelHeight = 35;
    CGFloat labelWidth = self.view.width - 50;
    
    self.langLabel = [[UILabel alloc]initWithFrame:CGRectMake(left + 15, top, labelWidth, 20)];
    self.langLabel.font = FONT_SANSUMI_BOLD(12);
    self.langLabel.textColor = rgbColor(37, 66, 97);
    self.langLabel.text = [TRANSLATE(@"Choose a programming language:") uppercaseString];
    //    self.loginTitleLabel.hidden = YES;
    self.langLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.langLabel];
    
    self.positionPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(22, 170, 275, 100)];
    self.positionPicker.backgroundColor = [UIColor whiteColor];
    self.positionPicker.delegate = self;
    self.positionPicker.dataSource = self;
    self.positionPicker.showsSelectionIndicator = YES;
    self.positionPicker.opaque = NO;
    
    //    [self addSubview:self.positionPicker];
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame: CGRectMake(0, 0, self.positionPicker.width, 40)];
    toolbar.barStyle = UIBarStyleBlackOpaque;
    toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style: UIBarButtonItemStyleBordered target: self action: @selector(pickerDoneButtonClicked:)];
    UIBarButtonItem* flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    //        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle: @"Cancel" style: UIBarButtonItemStyleBordered target: self action: @selector(cancelPressed)];
    toolbar.items = [NSArray arrayWithObjects:flexibleSpace, doneButton, nil];
    
    top += self.langLabel.height;
    self.langField = [[UITextField alloc] initWithFrame:CGRectMake(left + 10, top, labelWidth, height)];
    self.langField.delegate = self;
    //    self.loginTextField.borderStyle = UITextBorderStyleNone;
    self.langField.backgroundColor = rgbColor(255, 255, 255);
    self.langField.font = FONT_SANSUMI(15);
    self.langField.textColor = [UIColor blackColor];
    self.langField.placeholder = TRANSLATE(@"language");
    //    self.loginTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName : rgbColor(255, 255, 255)}];
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 20)];
    self.langField.leftView = paddingView;
    self.langField.leftViewMode = UITextFieldViewModeAlways;
    self.langField.layer.cornerRadius = 5.f;
    self.langField.layer.borderWidth = 1.f;
    self.langField.layer.borderColor = rgbColor(213, 213, 213).CGColor;
    self.langField.layer.masksToBounds = YES;
    UIImageView *rightDropDownView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dropdown.png"]];
    rightDropDownView.contentMode = UIViewContentModeCenter;
    rightDropDownView.width = 30;
    rightDropDownView.left = self.langField.width - rightDropDownView.width - 20;
    rightDropDownView.top = 0.5 * (self.langField.height - rightDropDownView.height);
    //        [textField addSubview:rightDropDownView];
    self.langField.rightView = rightDropDownView;//[[UIView alloc] initWithFrame:CGRectMake(0, 0, rightDropDownView.width + 10, 0)];
    self.langField.rightViewMode = UITextFieldViewModeAlways;
    self.langField.keyboardType = UIKeyboardTypeEmailAddress;
    self.langField.returnKeyType = UIReturnKeyNext;
    self.langField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.langField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.langField.inputView = self.positionPicker;
    self.langField.inputAccessoryView = toolbar;
    
    [self.view addSubview:self.langField];
    
    CGFloat buttonWidth = self.view.width - 160;
    CGFloat buttonHeight = self.view.height * 0.07;
    left = self.view.width/2 - buttonWidth/2;
    
    self.showButton = [[UIButton alloc] initWithFrame:CGRectMake(left, top + 100, buttonWidth, buttonHeight)];
    self.showButton.layer.cornerRadius = 5.f;
    self.showButton.backgroundColor = rgbColor(255, 255, 255);
    self.showButton.titleColor = rgbColor(37, 66, 97);
    self.showButton.titleLabel.font = FONT_SANSUMI_BOLD(12);
    self.showButton.title = [TRANSLATE(@"Show Repositories") uppercaseString];
    self.showButton.enabled = YES;
    [self.showButton addTarget:self action:@selector(showReprositoriesBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.showButton];
}
- (void)showReprositoriesBtnClicked:(id)sender {
    RepositoriesViewController *repositoriesViewController = [[RepositoriesViewController alloc]init];
    if ([self.langField.text isEqualToString:@"Swift"]) {
        repositoriesViewController.isSwift = YES;
    } else if ([self.langField.text isEqualToString:@"Objective-C"]) {
        repositoriesViewController.isSwift = NO;
    } else if ([self.langField.text isEqualToString:@""]) {
        ALERT(TRANSLATE(@"Please, choose a programming language"));
    }
    [self.navigationController pushViewController:repositoriesViewController animated:YES];
}
-(void)donePressed {
    //    picker.hidden = YES;
    NSLog(@"Done button tapped");
    [self.langField resignFirstResponder];
}
- (NSArray *)pickerData {
    
    if (!_pickerData) {
        _pickerData = @[@"Objective-C", @"Swift"];
    }
    return _pickerData;
}
- (void)pickerDoneButtonClicked:(id)sender {
    [self.langField resignFirstResponder];
}
#pragma mark - UIPickerView delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSInteger count =   0;
    switch (component) {
        case 0:
            count   = [self.pickerData count];
            break;
    }
    return count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title =   @"";
    switch (component) {
        case 0:
            title =  [self.pickerData objectAtIndex:row];
            break;
    }
    return title;
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.langField.text = self.pickerData[row];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
