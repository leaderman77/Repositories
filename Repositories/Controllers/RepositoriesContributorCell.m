//
//  RepositoriesContributorCell.m
//  Repositories
//
//  Created by Admin on 2/16/16.
//  Copyright (c) 2016 microapps. All rights reserved.
//

#import "RepositoriesContributorCell.h"

@implementation RepositoriesContributorCell
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
+ (instancetype)cellForTableView:(UITableView *)tableView withItem:(id)item
{
    RepositoriesContributorCell *cell = [tableView dequeueReusableCellWithIdentifier:[[RepositoriesContributorCell class] description]];
    CGFloat left = 15;
    CGFloat top = 0;
    if (!cell) {
        cell = [[RepositoriesContributorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[[RepositoriesContributorCell class] description]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CGFloat width = cell.contentView.width - 80;
        cell.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(left, top, width, 40)];
//                cell.nameLabel.layer.borderWidth = 1;
        cell.nameLabel.numberOfLines = 0.f;
        cell.nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.nameLabel.textColor = rgbColor(37, 66, 97);
        cell.nameLabel.font = FONT_SANSUMI_BOLD(12);
        [cell.contentView addSubview:cell.nameLabel];
        
        cell.followersLabel = [[UILabel alloc] initWithFrame:CGRectMake(left + cell.nameLabel.width, 5, 30, 30)];
//                cell.followersLabel.layer.borderWidth = 1;
        cell.followersLabel.textColor = rgbColor(37, 66, 97);
        cell.followersLabel.font = FONT_SANSUMI(15);
        [cell.contentView addSubview:cell.followersLabel];
        
    }
    return cell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
