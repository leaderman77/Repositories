//
//  RepositoriesViewController.m
//  Repositories
//
//  Created by Admin on 2/16/16.
//  Copyright (c) 2016 microapps. All rights reserved.
//

#import "RepositoriesViewController.h"
#import "RepositoriesListCell.h"
#import "RepositoriesDetailsViewController.h"

@interface RepositoriesViewController ()<UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, BaseControllerDelegate>
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UITableView *listTableView;

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSMutableArray *language;

@property (nonatomic, strong) NSMutableArray *followers;
@property (nonatomic, strong) NSArray *repoDescription;

@property (nonatomic, strong) NSArray *issues;
@property (nonatomic, strong) NSArray *username;

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *urlIssues;
@property (nonatomic, strong) NSArray *contributorsName;
@end

@implementation RepositoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = rgbColor(22, 168, 235);
    self.items = [[NSMutableArray alloc]init];
    self.language = [[NSMutableArray alloc]init];
    self.followers = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view.
    [self callApiMethods];
    [self configureNavigationBar];
    
}
- (void)configureNavigationBar {
    //    self.titleView.layer.borderWidth = 1;
//    [super configureNavigationBar];
    
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 60)];
    self.topView.backgroundColor = rgbColor(132, 188, 56);
    
    UIButton *titleButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 23, self.topView.width - 20, 30)];
    titleButton.text = [TRANSLATE(@"Popular Repositories") uppercaseString];
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
#pragma mark - Class methods Implementation
- (void)callApiMethods {
    [super callApiMethods];
    
    [self getTableInfo];
}


- (void)getTableInfo {
    [self showLoading:YES];
    
    [[RestClient sharedClient] callMethodByPath:self.isSwift ? METHOD_REPOSITORIES_SWIFT : METHOD_REPOSITORIES_OBJECTIVE_C withHTTPMethodType:HTTP_GET withParameters:nil
                                       callback:^(NSDictionary *responseDic, NSError *error) {
                                           [self.view showLoading:NO];
                                           self.items = [responseDic[@"repositories"] valueForKey:@"name"];
                                           self.language = [responseDic[@"repositories"] valueForKey:@"language"];
                                           self.followers = [responseDic[@"repositories"] valueForKey:@"followers"];
                                           self.repoDescription = [responseDic[@"repositories"] valueForKey:@"description"];
                                           
                                           self.issues = [responseDic[@"repositories"] valueForKey:@"open_issues"];
                                           self.username = [responseDic[@"repositories"] valueForKey:@"username"];
                                           
                                           [self populateControls];
                                       }];
}

- (void)populateControls {
    CGFloat width = self.view.width;
    CGFloat padding = 10.0;
    CGFloat left = 0;
    //    CGFloat height = self.view.height - self.view.topNavigationView.height;
    //    CGFloat top = self.view.topNavigationView.bottom;
    
    self.listTableView = [[UITableView alloc]initWithFrame:CGRectMake(left, self.topView.height - 5, width, self.view.height - 55) style:UITableViewStylePlain];
    self.listTableView.rowHeight = 54.4f;
    //    self.homeTableView.height = self.items.count * self.homeTableView.rowHeight;
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    self.listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.listTableView.backgroundColor = [UIColor clearColor];
    self.listTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    //    self.homeTableView.layer.borderColor = BORDER_GRAY_COLOR.CGColor;
    //    self.homeTableView.layer.masksToBounds = YES;
    //    self.homeTableView.layer.cornerRadius = 5;
    //    self.homeTableView.layer.borderWidth = 1.0;
    self.listTableView.scrollEnabled = YES;
    [self.view addSubview:self.listTableView];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableView Data Source& Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUInteger rowsCount = self.items.count;
    return rowsCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RepositoriesListCell *cell = [RepositoriesListCell cellForTableView:tableView withItem:nil];
    //        cell.baseDelegate = self;
    cell.indexPath = indexPath;
    cell.nameLabel.text = self.items[indexPath.row];
    cell.languageLabel.text = self.language[indexPath.row];
    cell.followersLabel.text = [NSString stringWithFormat:@"%@", self.followers[indexPath.row]];
//    [cell.imageView setImage:[UIImage imageNamed:@"Star_icon.ico"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.url = [NSString stringWithFormat:@"https://api.github.com/repos/%@/%@/contributors?sort=contributions", self.username[indexPath.row], self.items[indexPath.row]];
    
    self.urlIssues = [NSString stringWithFormat:@"https://api.github.com/repos/%@/%@/issues?sort=created_at", self.username[indexPath.row], self.items[indexPath.row]];
   
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RepositoriesDetailsViewController *reposDetailsController = [[RepositoriesDetailsViewController alloc]init];
    reposDetailsController.nameString = self.items[indexPath.row];
    reposDetailsController.repoDescriptionString = self.repoDescription[indexPath.row];
    reposDetailsController.followersString = [NSString stringWithFormat:@"%@", self.followers[indexPath.row]];
    reposDetailsController.issuesString = [NSString stringWithFormat:@"%@",self.urlIssues];
    reposDetailsController.watchersString = [NSString stringWithFormat:@"%@", self.url];
    [self.navigationController pushViewController:reposDetailsController animated:YES];
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
