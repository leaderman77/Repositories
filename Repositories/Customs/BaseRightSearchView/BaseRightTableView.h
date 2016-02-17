//
// Created by Sanch0 on 7/14/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRightSearchView.h"

@class CustomSearchBar;


@interface BaseRightTableView : BaseRightSearchView <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CustomSearchBar *searchBar;

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, assign) BOOL withSections;
@end