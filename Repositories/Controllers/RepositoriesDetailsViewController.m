//
//  RepositoriesDetailsViewController.m
//  Repositories
//
//  Created by Admin on 2/16/16.
//  Copyright (c) 2016 microapps. All rights reserved.
//

#import "RepositoriesDetailsViewController.h"
#import "RepositoriesDetailsCell.h"
#import "RepositoriesContributorCell.h"

@interface RepositoriesDetailsViewController ()<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;

@property (retain, nonatomic) UILabel *name;
@property (retain, nonatomic) UITextField *reposName;

@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic, strong) UITableView *contributorsTableView;

@property (retain, nonatomic) UILabel *repoDescription;
@property (retain, nonatomic) UITextView *reposDescription;

@property (retain, nonatomic) UILabel *issues;
@property (retain, nonatomic) UILabel *repoIssues;

@property (retain, nonatomic) UILabel *contributors;
@property (retain, nonatomic) UILabel *repoContributors;

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, strong) NSMutableArray *issuesList;
@property (nonatomic, strong) NSMutableArray *contributorsName;

@property (nonatomic, strong) NSMutableArray *issuesCreatedAt;
@property (nonatomic, strong) NSMutableArray *contributions;
@end

@implementation RepositoriesDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = rgbColor(22, 168, 235);
    self.items = [[NSMutableArray alloc]init];
    self.contributorsName = [[NSMutableArray alloc]init];
    self.issuesList = [[NSMutableArray alloc]init];
    self.issuesCreatedAt = [[NSMutableArray alloc]init];
    self.contributions = [[NSMutableArray alloc]init];
    [self configureNavigationBar];
//    [self populateControls];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getIssues];
    
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.navigationBar.barTintColor = rgbColor(83, 140, 9);
}
-(void)getIssues {
    [self.view showLoading:YES];
    
    [[RestClient sharedClient] callMethodByPath:self.issuesString withHTTPMethodType:HTTP_GET withParameters:nil
                                       callback:^(NSDictionary *responseDic, NSError *error) {
                                           [self.view showLoading:NO];
                                           self.issuesList = [responseDic valueForKey:@"title"];
                                           self.issuesCreatedAt = [responseDic valueForKey:@"created_at"];
                                           [self getContributors];
                                       }];
}
-(void)getContributors {
    [self.view showLoading:YES];
    
    [[RestClient sharedClient] callMethodByPath:self.watchersString withHTTPMethodType:HTTP_GET withParameters:nil
                                       callback:^(NSDictionary *responseDic, NSError *error) {
                                           [self.view showLoading:NO];
                                           self.contributorsName = [responseDic valueForKey:@"login"];
                                           self.contributions = [responseDic valueForKey:@"contributions"];
                                           [self populateControls];
                                       }];
}

- (void)configureNavigationBar {
    [super configureNavigationBar];
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 60)];
    self.topView.backgroundColor = rgbColor(132, 188, 56);
    
    UIButton *titleButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 23, self.topView.width - 20, 30)];
    titleButton.text = [TRANSLATE(@"Repositories Details") uppercaseString];
    titleButton.titleColor = rgbColor(255, 255, 255);
    titleButton.titleLabel.font = FONT_SANSUMI(16);
    [self.topView addSubview:titleButton];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 25, 30, 30)];
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, backButton.width, backButton.height)];
    [backImageView setImage:[UIImage imageNamed:@"navig_bar_back.png"]];
    backImageView.contentMode = UIViewContentModeScaleAspectFill;
    [backButton addSubview:backImageView];
    [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:backButton];
    
    [self.view addSubview:self.topView];
    
}
- (IBAction)backButtonClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)populateControls {
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.topView.height, self.view.width, self.view.height + 60)];
    //        self.scrollView.layer.borderWidth = 2;
    //    self.scrollView.top = kPortraitNavbarHeight + 20;
    self.scrollView.height -= self.scrollView.top;
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.scrollView.backgroundColor = rgbColor(22, 168, 235);
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    CGFloat top = 10;
    CGFloat left = 10;
    CGFloat height = 40;
    CGFloat labelHeight = 35;
    CGFloat labelWidth = self.view.width - 20;
    
    self.name = [self labelWithFrame:CGRectMake(left + 10, top, labelWidth, labelHeight)
                                    withTitle:[TRANSLATE(@"Name:") uppercaseString]];
    self.name.textColor = rgbColor(37, 66, 97);
    
    top += self.name.height;
    self.reposName = [[UITextField alloc] initWithFrame:CGRectMake(left, top, labelWidth, height)];
    self.reposName.delegate = self;
    //    self.loginTextField.borderStyle = UITextBorderStyleNone;
    self.reposName.backgroundColor = rgbColor(255, 255, 255);
    self.reposName.font = FONT_SANSUMI(12);
    self.reposName.textColor = rgbColor(37, 66, 97);
    //    self.loginTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName : rgbColor(255, 255, 255)}];
    self.reposName.text = self.nameString;
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7, 20)];
    self.reposName.leftView = paddingView;
    self.reposName.leftViewMode = UITextFieldViewModeAlways;
    self.reposName.layer.cornerRadius = 5.f;
    self.reposName.layer.borderWidth = 1.f;
    self.reposName.layer.borderColor = rgbColor(213, 213, 213).CGColor;
    self.reposName.layer.masksToBounds = YES;
    self.reposName.keyboardType = UIKeyboardTypeEmailAddress;
    self.reposName.returnKeyType = UIReturnKeyNext;
    self.reposName.enabled = NO;
    self.reposName.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.reposName.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.scrollView addSubview:self.reposName];
    
    top += self.reposName.height;
    self.repoDescription = [self labelWithFrame:CGRectMake(left + 10, top, labelWidth, labelHeight)
                           withTitle:[TRANSLATE(@"Description:") uppercaseString]];
    self.repoDescription.textColor = rgbColor(37, 66, 97);
    
    top += self.repoDescription.height;
//    CGFloat width1 = self.view.width - 220;
//    CGFloat headerHeight = [self.repoDescriptionString heightWithWidth:width1 withFontSize:12];
    self.reposDescription = [[UITextView alloc]initWithFrame:CGRectMake(left, top, labelWidth, 70)];
    self.reposDescription.textColor = rgbColor(37, 66, 97);
    self.reposDescription.font = FONT_SANSUMI(12);
    self.reposDescription.layer.cornerRadius = 5.f;
    self.reposDescription.layer.borderWidth = 1.f;
    self.reposDescription.layer.borderColor = rgbColor(213, 213, 213).CGColor;
    self.reposDescription.layer.masksToBounds = YES;
    self.reposDescription.backgroundColor = [UIColor whiteColor];
    self.reposDescription.text = self.repoDescriptionString;
//    [self.reposDescription sizeToFit];
    self.reposDescription.editable = NO;
    self.reposDescription.scrollEnabled = YES;
    [self.scrollView addSubview:self.reposDescription];
    
    top += self.reposDescription.height;
    self.issues = [self labelWithFrame:CGRectMake(left + 10, top, labelWidth, labelHeight)
                                withTitle:[TRANSLATE(@"Issues:") uppercaseString]];
    self.issues.textColor = rgbColor(69, 98, 138);
    
    CGFloat width = self.view.width - 20;

    top += self.issues.height;
    self.listTableView = [[UITableView alloc]initWithFrame:CGRectMake(left, top, width, 130) style:UITableViewStylePlain];
    self.listTableView.rowHeight = 40.0f;
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    self.listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.listTableView.backgroundColor = [UIColor clearColor];
    self.listTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.listTableView.scrollEnabled = NO;
    [self.listTableView sizeToFit];
//    self.listTableView.layer.borderColor = BORDER_GRAY_COLOR.CGColor;
//    self.listTableView.layer.masksToBounds = YES;
//    self.listTableView.layer.cornerRadius = 5;
//    self.listTableView.layer.borderWidth = 1.0;
    [self.scrollView addSubview:self.listTableView];
    
    top += self.listTableView.height;
    self.contributors = [self labelWithFrame:CGRectMake(left + 10, top, labelWidth, labelHeight)
                             withTitle:[TRANSLATE(@"Contributors:") uppercaseString]];
    self.contributors.textColor = rgbColor(69, 98, 138);
    
    top += self.contributors.height;
    self.contributorsTableView = [[UITableView alloc]initWithFrame:CGRectMake(left, top, width, 130) style:UITableViewStylePlain];
    self.contributorsTableView.rowHeight = 40.0f;
    self.contributorsTableView.delegate = self;
    self.contributorsTableView.dataSource = self;
    self.contributorsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.contributorsTableView.backgroundColor = [UIColor clearColor];
    self.contributorsTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.contributorsTableView.scrollEnabled = NO;
//    self.contributorsTableView.layer.borderColor = BORDER_GRAY_COLOR.CGColor;
//    self.contributorsTableView.layer.masksToBounds = YES;
//    self.contributorsTableView.layer.cornerRadius = 5;
//    self.contributorsTableView.layer.borderWidth = 1.0;
    [self.scrollView addSubview:self.contributorsTableView];
    
    self.scrollView.contentSize = CGSizeMake(0, 750);
    self.scrollView.scrollEnabled = YES;
    
}
- (UILabel *)labelWithFrame:(CGRect)frame withTitle:(NSString *)title {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    //    label.layer.borderWidth = 1.f;
    label.textColor = rgbColor(37, 66, 97);  //[UIColor whiteColor];
    label.font = FONT_SANSUMI_BOLD(10.f);
    label.textAlignment = NSTextAlignmentLeft;
    label.text = title;
    label.layer.cornerRadius = 5.f;
    label.layer.masksToBounds = YES;
    [self.scrollView addSubview:label];
    return label;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.listTableView]) {
        if (self.issuesList.count >= 3) {
            return 3;
        } else {
            return self.issuesList.count;
        }
    } else {
        if (self.contributorsName.count >= 3) {
            return 3;
        } else {
            return self.contributorsName.count;
        }
    }
    
        
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *CellIdentifier = @"LBLeftSideViewCell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    //    cell.contentView.layer.borderWidth = 2;
//    if ([tableView isEqual:self.listTableView]) {
//        cell.textLabel.text = self.issuesList[indexPath.row];
//        cell.detailTextLabel.text = self.issuesCreatedAt[indexPath.row];
//    } else {
//        cell.textLabel.text = self.contributorsName[indexPath.row];
//        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", self.contributions[indexPath.row]];
//    }
    if ([tableView isEqual:self.listTableView]) {
        RepositoriesDetailsCell *cell = [RepositoriesDetailsCell cellForTableView:tableView withItem:nil];
    //        cell.baseDelegate = self;
        cell.indexPath = indexPath;
        cell.nameLabel.text = self.issuesList[indexPath.row];
//        cell.languageLabel.text = self.issuesCreatedAt[indexPath.row];
        
        NSString *string = [NSString stringWithFormat:@"%@", self.issuesCreatedAt[indexPath.row]];
//        NSString *stringDate = [string substringToIndex:[string length] - 14];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
        NSDate *date = [formatter dateFromString:string];
        
        NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
        [formatter1 setDateFormat:@"dd.MM.yyyy HH:mm"];
        cell.languageLabel.text = [formatter1 stringFromDate:date];
        
        return cell;
    } else {
        RepositoriesContributorCell *cell = [RepositoriesContributorCell cellForTableView:tableView withItem:nil];
        //        cell.baseDelegate = self;
        cell.indexPath = indexPath;
        cell.nameLabel.text = self.contributorsName[indexPath.row];
        cell.followersLabel.text = [NSString stringWithFormat:@"%@", self.contributions[indexPath.row]];
        return cell;
    }

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
