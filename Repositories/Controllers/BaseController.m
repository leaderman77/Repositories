//
//  BaseController.m
//  Chayxana
//
//  Created by Admin on 9/22/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

#import "BaseController.h"

@interface BaseController ()
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) NSMutableArray *rightSearchViews;
@end

@implementation BaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)populateControls {
    DLog(@"Populating Controls");
}

#pragma mark - Class methods Implementation

- (NSMutableArray *)items {
    if (!_items) {
        _items = [NSMutableArray new];
    }
    return _items;
}

- (void)showLoading:(BOOL)isShow {
    if (isShow) {
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
        hud.removeFromSuperViewOnHide = YES;
        hud.labelText = TRANSLATE(@"Loading...");
        [hud show:YES];
        [self.view addSubview:hud];
    } else {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }
}

/*- (UIButton *)navBarTitleView {
 //    self.navController.titleView.contentMode = UIViewContentModeScaleAspectFit;
 if ()
 return self.navController.titleView;
 }*/

- (UIButton *)titleView {
    if (!_titleView) {
        _titleView = [[UIButton alloc] initWithFrame:CGRectMake(100, 30, 200, self.navigationController.navigationBar.height)];
        _titleView.contentMode = UIViewContentModeScaleAspectFit;
//        _titleView.layer.borderWidth = 2;
        _titleView.titleLabel.font = FONT_SANSUMI_BOLD(15);
//        _titleView.titleColor = rgbColor(255, 255, 255);
    }
    return _titleView;
}
- (void)configureNavigationBar {
    //    self.navBarTitleView.title = nil;
    //    self.navBarTitleView.image = nil;
    
//    self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 30, 50, 50)];
////    self.backButton.layer.borderWidth = 2;
//    self.backButton.backgroundColor = [UIColor clearColor];
//    self.backButton.titleColor = [UIColor grayColor];
//    self.backButton.titleLabel.font = FONT_SANSUMI(12);
//    self.backButton.title = @"BACK";
//    self.backButton.enabled = YES;
//    [self.backButton addTarget:self action:@selector(backClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.backButton];
    
//    [self.view addSubview:self.titleView];
    
    self.navigationController.navigationBar.barTintColor = rgbColor(22, 168, 235);
    self.navigationItem.titleView = self.titleView;
//
    self.leftNavBarBtn = [UIButton backBtnWithController:self withSelector:@selector(cancelClicked:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftNavBarBtn];
    
}
- (void)configureNavigationBar2 {
//    self.navigationController.navigationBar.barTintColor = rgbColor(22, 168, 235);
//    self.navigationItem.titleView = self.titleView;
//    //
//    self.leftNavBarBtn = [UIButton backBtnWithController:self withSelector:@selector(backClicked:)];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftNavBarBtn];

    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 74)];
    [self.topView addSubview:self.titleView];
    self.leftNavBarBtn = [UIButton backBtnWithController:self withSelector:@selector(backClicked:)];
    self.rightNavBarBtn = [UIButton doneBtnWithController:self withSelector:@selector(backClicked:)];
    [self.topView addSubview:self.leftNavBarBtn];
    [self.topView addSubview:self.rightNavBarBtn];
    [self.view addSubview:self.topView];
}
- (void)configureControls {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.topItem.title = @"";
    self.navigationItem.titleView = self.titleView;
    
    
    
    //    [self.bottomNavigationView addTopBorderWithHeight:2.f andColor:rgbColor(192, 195, 202)];
    //    if (SYSTEM_VERSION < 7.f) {
    //        self.searchBar.tintColor = rgbColor(248, 248, 248);
    //    } else {
    //        self.searchBar.barTintColor = rgbColor(248, 248, 248);
    //    }
    //    //    self.searchBar.hidden = YES;
    
}
- (void)cancelClicked:(id)sender {
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)backClicked:(id)sender {
        [self.navigationController popViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)keyboardDidShow:(id)sender {
    self.isKeyboardWasShown = YES;
}

- (void)keyboardDidHide:(id)sender {
    
}

- (void)callApiMethods {
    DLog(@"Call api methods");
}
//- (CGFloat)width {
//    return kiPadLandscapeWidth;
//}
//
//- (CGFloat)height {
//    return kiPadLandscapeHeight;
//}

- (UIWindow *)window {
    return [[[UIApplication sharedApplication] windows] lastObject];
}

- (UIView *)alertWindow {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (!window) {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    UIView *view = [[window subviews] objectAtIndex:0];
    return view;
}

- (void)windowViewTapped:(id)sender {
    DLog(@"window View tapped");
    [UIView animateWithDuration:0.3 animations:^{
        self.windowView.alpha = 0;
    }                completion:^(BOOL finished) {
        [self.windowView removeFromSuperview];
        self.windowView = nil;
    }];
}

- (UIButton *)windowView {
    if (_windowView == nil || !_windowView.superview) {
        [_windowView removeFromSuperview];
        _windowView = nil;
        
        _windowView = [[UIButton alloc] initWithFrame:self.alertWindow.bounds];
        _windowView.tag = WINDOW_VIEW_TAG;
        [_windowView addTarget:self action:@selector(windowViewTapped:) forControlEvents:UIControlEventTouchUpInside];
        _windowView.alpha = 0;
        [self.alertWindow addSubview:_windowView];
        /*UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
         action:@selector
         (windowViewTapped:)];
         tapGestureRecognizer.numberOfTapsRequired = 2;
         [_windowView addGestureRecognizer:tapGestureRecognizer];*/
        _windowView.backgroundColor = [UIColor clearColor];  //[UIColor colorWithWhite:0 alpha:0.5];
    }
    return _windowView;
}
#pragma mark - BaseRightSearchViewDelegate

- (NSMutableArray *)rightSearchViews {
    if (_rightSearchViews == nil) {
        _rightSearchViews = [NSMutableArray new];
    }
    return _rightSearchViews;
}

//- (CGRect)rightSearchViewFrame {
//    return CGRectMake(self.width, 0, RIGHT_SEARCH_VIEW_WIDTH, self.height);
//}
//
//- (void)showRightSearchView:(BaseRightSearchView *)rightSearchView {
//    rightSearchView.left = self.width;
//    [self.windowView addSubview:rightSearchView];
//    [rightSearchView reloadData];
//    //    self.windowView.alpha = self.windowView.alpha == 0 ? 1.f : 1;
//    [UIView animateWithDuration:0.3 animations:^{
//        self.windowView.alpha = 1.f;
//        rightSearchView.left = self.width - rightSearchView.width;
//    }                completion:^(BOOL finished) {
//        [self.rightSearchViews addObject:rightSearchView];
//        
//    }];
//}

#pragma mark - UITableView Delegate & Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *BaseCellIdentifier = @"BaseCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BaseCellIdentifier];
    return cell;
}
#pragma mark - PickerPopover

- (void)pickerPopover:(PickerPopover *)pickerPopover didSelectedItem:(id)item atIndex:(NSInteger)index {
    
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
