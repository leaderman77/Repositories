//
// Created by Sanch0 on 1/15/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseRightSearchView.h"
#import "AppDelegate.h"


@interface BaseRightSearchView ()


@end

@implementation BaseRightSearchView {

}

- (void)dealloc {
    [self showLoading:NO];
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }

    return self;
}

- (UIButton *)addBtnWithFrame:(CGRect)frame withTitle:(NSString *)title {
    UIButton *addBtn = [[UIButton alloc] initWithFrame:frame];
    addBtn.layer.cornerRadius = 5.f;
    addBtn.layer.masksToBounds = YES;
    addBtn.backgroundImage = [UIImage imageFromColor:LIME_BUTTON_BG_COLOR];
    addBtn.text = [NSAttributedString attributedStringForButtonWithTitle:title withBoldFontSize:20.f];
    [addBtn addTarget:self action:@selector(bottomAddBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    return addBtn;
}


- (void)createAndLayoutTopNavigationView {
    padding = 10.f;
    top = 20.f;
    height = kPortraitNavbarHeight;
    //TOP NAVIGATION VIEW
    self.topNavigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, kPortraitNavbarHeight + top)];
    self.topNavigationView.backgroundColor = NAVIGATION_BAR_BTN_TEXT_COLOR;
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(padding, top, 80, height)];
    backBtn.tag = 1;
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    backBtn.titleLabel.font = FONT_SANSUMI_BOLD(15.f);
    backBtn.title = [TRANSLATE(@"Back") uppercaseString];
    backBtn.image = [UIImage imageNamed:@"back_white.png"];
    [backBtn addTarget:self action:@selector(backClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.topNavigationView addSubview:backBtn];
    self.leftTopBtn = backBtn;

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, top, 235, height)];
    titleLabel.tag = 2;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = FONT_SANSUMI(18);
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = [TRANSLATE(self.title) uppercaseString];
    titleLabel.left = 0.5 * (self.topNavigationView.width - titleLabel.width);
    [self.topNavigationView addSubview:titleLabel];

    UIButton *searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, top, 80, height)];
    searchBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    searchBtn.tag = 3;
//    searchBtn.contentEdgeInsets = UIEdgeInsetsMake(20, 0, 0, 0);
//    searchBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    searchBtn.left = self.topNavigationView.width - searchBtn.width - padding;
    [searchBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    searchBtn.layer.borderWidth = 1.f;
    searchBtn.titleLabel.font = FONT_SANSUMI_BOLD(15.f);
    searchBtn.title = [TRANSLATE(@"Search") uppercaseString];
    [self.topNavigationView addSubview:searchBtn];
    self.rightTopBtn = searchBtn;

    top += titleLabel.height;
    [self addSubview:self.topNavigationView];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [(UILabel *) [self.topNavigationView viewWithTag:2] setText:title];
}


- (void)createAndLayoutSubviews {
    [super createAndLayoutSubviews];
    
    self.backgroundColor = [UIColor whiteColor];
}

- (void)selfTapped {
    [self endEditing:YES];
}

- (void)clearData {
    [MBProgressHUD hideAllHUDsForView:self animated:YES];
}


- (void)backClicked:(id)sender {
    if ([self.baseDelegate respondsToSelector:@selector(baseRightSearchViewDidBackClicked:)]) {
        [self.baseDelegate baseRightSearchViewDidBackClicked:self];
    }
}

- (void)rightBtnClicked:(id)sender {
    if ([self.baseDelegate respondsToSelector:@selector(baseRightSearchViewDidTopRightBtnClicked:)]) {
        [self.baseDelegate baseRightSearchViewDidBackClicked:self];
    }
}

- (void)showLoadingProgress:(BOOL)isShow {
    if (isShow) {
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
        hud.removeFromSuperViewOnHide = YES;
        hud.labelText = TRANSLATE(@"Loading...");
        [hud show:YES];
        [self addSubview:hud];
    } else {
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
    }
}

- (void)reloadData {
    DLog(@"%@ is reloading..", self);
}

- (void)showLoading:(BOOL)isShow {
    if (isShow) {
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        appDelegate.loaderView = self;

        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
        hud.removeFromSuperViewOnHide = YES;
        hud.labelText = TRANSLATE(@"Loading...");
        [hud show:YES];
        [self addSubview:hud];
    } else {
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
    }
}

- (void)bottomAddBtnClicked:(UIButton *)sender {

}


@end