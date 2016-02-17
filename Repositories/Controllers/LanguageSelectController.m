//
//  LanguageSelectController.m
//  Repositories
//
//  Created by Admin on 2/15/16.
//  Copyright (c) 2016 microapps. All rights reserved.
//

#import "LanguageSelectController.h"
#import "RepositoriesTypeController.h"

#define ENGLISH_LANGUAGE     @"en"
#define SPANISH_LANGUAGE     @"sp"

@interface LanguageSelectController ()
@property (retain, nonatomic) UILabel *languageSelectLabel;
@property (retain, nonatomic) UILabel *orLabel;

@property (nonatomic, strong) UIButton *englishLangButton;
@property (nonatomic, strong) UIButton *russianLangButton;
@end

@implementation LanguageSelectController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = rgbColor(22, 168, 235);
    [self configureControls];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)configureControls {
    //    [super configureControls];
    CGFloat left = 0.5 * (self.view.width - 300);
    CGFloat height = 0.5 * (self.view.height - 300);
    
    //create language select button
    self.languageSelectLabel = [[UILabel alloc]initWithFrame:CGRectMake(left + 20, height, 300, 20)];
    self.languageSelectLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.languageSelectLabel.font = FONT_SANSUMI(20);
    self.languageSelectLabel.textColor = rgbColor(255, 255, 255);
    self.languageSelectLabel.text = @"CHOOSE YOUR LANGUAGE";
    //    self.loginTitleLabel.hidden = YES;
    self.languageSelectLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.languageSelectLabel];
    
    //create english language select button
    self.englishLangButton = [[UIButton alloc] initWithFrame:CGRectMake(left + 20, height+ 80, 250, 60)];
    //    self.signInBtn.layer.borderWidth = 1.f;
    self.englishLangButton.layer.cornerRadius = 5.f;
    self.englishLangButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.englishLangButton.backgroundColor = [UIColor clearColor];
    self.englishLangButton.titleColor = [UIColor whiteColor];
    self.englishLangButton.titleLabel.font = FONT_SANSUMI_BOLD(28);
    self.englishLangButton.title = [TRANSLATE(@"English") uppercaseString];
    self.englishLangButton.enabled = YES;
    [self.englishLangButton addTarget:self action:@selector(englishLangButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.englishLangButton];
    
    //create or label
    self.orLabel = [[UILabel alloc]initWithFrame:CGRectMake(left + 130, height + 170, 250, 20)];
    self.orLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.orLabel.font = FONT_SANSUMI(20);
    self.orLabel.textColor = rgbColor(255, 255, 255);
    self.orLabel.text = [TRANSLATE(@"Or") uppercaseString];
    //    self.loginTitleLabel.hidden = YES;
    self.orLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.orLabel];
    
    //create russian language select button
    self.russianLangButton = [[UIButton alloc] initWithFrame:CGRectMake(left + 20, height + 210, 250, 60)];
    //    self.signInBtn.layer.borderWidth = 1.f;
    self.russianLangButton.layer.cornerRadius = 5.f;
    self.russianLangButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.russianLangButton.backgroundColor = [UIColor clearColor];
    self.russianLangButton.titleColor = [UIColor whiteColor];
    self.russianLangButton.titleLabel.font = FONT_SANSUMI_BOLD(28);
    self.russianLangButton.title = [TRANSLATE(@"Spanish") uppercaseString];
    self.russianLangButton.enabled = YES;
    [self.russianLangButton addTarget:self action:@selector(russainLangButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.russianLangButton];
}
- (void)englishLangButtonClicked:(id)sneder {
    RepositoriesTypeController *reposTypeController = [[RepositoriesTypeController alloc]init];
    [self.navigationController pushViewController:reposTypeController animated:YES];
    
    NSString *language = @"ENGLISH";
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:language forKey:SPANISH_LANGUAGE];
    [userDefaults synchronize];
    
    
}
- (void)russainLangButtonClicked:(id)sneder {
   
    RepositoriesTypeController *reposTypeController = [[RepositoriesTypeController alloc]init];
    [self.navigationController pushViewController:reposTypeController animated:YES];
    
    [[SettingsManager sharedManager]setCurrentLanguage:SPANISH_LANGUAGE];
    
    NSString *rusLanguage = @"SPANISH";
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:rusLanguage forKey:SPANISH_LANGUAGE];
    [userDefaults synchronize];
    
    
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
