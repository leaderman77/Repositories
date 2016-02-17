//
//  RepositoriesContributorCell.h
//  Repositories
//
//  Created by Admin on 2/16/16.
//  Copyright (c) 2016 microapps. All rights reserved.
//

#import "BaseCell.h"

@interface RepositoriesContributorCell : BaseCell
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *languageLabel;
@property (nonatomic, strong) UILabel *followersLabel;

@property (nonatomic, strong) NSIndexPath *indexPath;

+ (instancetype)cellForTableView:(UITableView *)tableView withItem:(id)item;
@end
