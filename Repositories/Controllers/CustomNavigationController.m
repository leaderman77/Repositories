//
//  CustomNavigationController.m
//  Chayxana
//
//  Created by Admin on 9/21/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

#import "CustomNavigationController.h"
//#import "Globals.h"
#import "BaseController.h"

@interface CustomNavigationController ()

@property (nonatomic, strong) UIView *alphaView;
@property (nonatomic, strong) UILabel *navigationTitleLabel;

@end

@implementation CustomNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.titleView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, self.navigationBar.height)];
    //    self.titleView.layer.borderWidth = 1.f;
    self.titleView.contentMode = UIViewContentModeScaleAspectFit;
    self.titleView.titleLabel.font = FONT_SANSUMI_BOLD(18);
    self.titleView.titleColor = rgbColor(125, 125, 125);
    self.navigationItem.titleView = self.titleView;
    
    
    // Do any additional setup after loading the view.
    [self configureSearchBar];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    DLog(@"Custom navigation controller");
    //    [self.view addSubview:self.bottomView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Class methods Impl

- (void)configureSearchBar {
    //    self.searchBar = [[UISearchBar alloc] init];
    //    self.searchBar.backgroundColor = SEARCH_BAR_COLOR;
    //    self.navigationItem.titleView = self.searchBar;
    //    self.searchBar.center = self.navigationBar.center;
    //    self.searchBar.width = 300;
    //    [self.navigationBar addSubview:self.searchBar];
}

- (void)backClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)leftClicked:(id)sender {
    if ([self.navigationDelegate respondsToSelector:@selector(leftNavigationBtnClicked:)]) {
        [self.navigationDelegate leftNavigationBtnClicked:sender];
    } else {
        [self popViewControllerAnimated:YES];
    }
}

- (void)rightClicked:(id)sender {
    if ([self.navigationDelegate respondsToSelector:@selector(rightNavigationBtnClicked:)]) {
        [self.navigationDelegate rightNavigationBtnClicked:sender];
    }
}

- (void)removeController:(UIViewController *)controller {
    if (self.viewControllers.count > 1) {
        NSMutableArray *viewControllers = [[NSMutableArray alloc] initWithArray:self.viewControllers];
        [viewControllers removeObject:controller];
        self.viewControllers = viewControllers;
    }
}


- (NSString *)navigationTitle {
    return self.navigationTitleLabel.text;
}

- (void)setNavigationTitle:(NSString *)navigationTitle {
    self.navigationTitleLabel.text = navigationTitle;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.alphaView.hidden = NO;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.alphaView.hidden = YES;
}

- (void)initializeWithController:(UIViewController *)controller {
    self.viewControllers = @[controller];
}
- (BaseController *)topBaseController {
    return (BaseController *) self.topViewController;
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
