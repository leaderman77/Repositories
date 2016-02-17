//
//  RepositoriesListCell.m
//  Repositories
//
//  Created by Admin on 2/16/16.
//  Copyright (c) 2016 microapps. All rights reserved.
//

#import "RepositoriesListCell.h"

@implementation RepositoriesListCell
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
+ (instancetype)cellForTableView:(UITableView *)tableView withItem:(id)item
{
    RepositoriesListCell *cell = [tableView dequeueReusableCellWithIdentifier:[[RepositoriesListCell class] description]];
    CGFloat left = 15;
    CGFloat top = 5;
    
    if (!cell) {
        cell = [[RepositoriesListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[[RepositoriesListCell class] description]];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        CGFloat width = cell.contentView.width - 100;
        cell.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(left, top, width, 30)];
//        cell.nameLabel.layer.borderWidth = 1;
        cell.nameLabel.numberOfLines = 0.f;
        cell.nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.nameLabel.textColor = rgbColor(37, 66, 97);
        cell.nameLabel.font = FONT_SANSUMI_BOLD(12);
        [cell.contentView addSubview:cell.nameLabel];
        
        top += cell.nameLabel.height;
        cell.languageLabel = [[UILabel alloc] initWithFrame:CGRectMake(left, top, width, 20)];
        cell.languageLabel.textColor = rgbColor(37, 66, 97);
        cell.languageLabel.font = FONT_SANSUMI(10);
        [cell.contentView addSubview:cell.languageLabel];
        
        cell.imgButton = [[UIButton alloc]initWithFrame:CGRectMake(left + cell.nameLabel.width, 20, 20, 20)];
        cell.starImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.imgButton.width, cell.imgButton.height)];
        [cell.starImageView setImage:[UIImage imageNamed:@"star_PNG.png"]];
        //    imageView.layer.borderWidth = 1;
        cell.starImageView.contentMode = UIViewContentModeScaleAspectFill;
        cell.starImageView.left = 0.5 * (cell.starImageView.width - cell.starImageView.width);
        cell.starImageView.top = 0.5 * (cell.starImageView.height - cell.starImageView.height);
        //        cell.announceImageView.layer.borderWidth = 1.0f;
        //        cell.announceImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        cell.starImageView.layer.cornerRadius = 0.5 * cell.starImageView.width;
        cell.starImageView.layer.masksToBounds = YES;
        [cell.imgButton addSubview:cell.starImageView];
        [cell.imgButton addTarget:self action:@selector(buttonClicked:withItem:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:cell.imgButton];

        
        cell.followersLabel = [[UILabel alloc] initWithFrame:CGRectMake(left + cell.nameLabel.width + 20, 10, 40, 40)];
//        cell.followersLabel.layer.borderWidth = 1;
        cell.followersLabel.textColor = rgbColor(37, 66, 97);
        cell.followersLabel.font = FONT_SANSUMI(15);
        [cell.contentView addSubview:cell.followersLabel];
    }
    return cell;
}
- (IBAction)buttonClicked:(UIButton *)sender withItem:(id)item {
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
