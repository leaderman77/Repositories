//
// Created by Sanch0 on 7/14/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "BaseRightTableView.h"
#import "CustomSearchBar.h"


@implementation BaseRightTableView {

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _withSections ? 1 : _items.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _withSections ? _items.count : 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return _withSections ? 10.0 : 0.001;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = _withSections && indexPath.section % 2 == 1 ? rgbColor(239, 239, 239) : [UIColor whiteColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}


@end