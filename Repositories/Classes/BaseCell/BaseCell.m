//
//  BaseCell.m
//  Yummy
//
//  Created by Администратор on 7/20/14.
//
//

#import "BaseCell.h"

@implementation BaseCell

- (void)dealloc
{
    self.baseDelegate = nil;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withItemsWidths:(NSArray *)itemsWidths {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code

    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withCellHeight:(CGFloat)cellHeight withItemsWidths:(NSArray *)itemsWidths {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code

    }
    return self;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withHeight:(CGFloat)cellHeight {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code

    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellForTableView:(UITableView *)tableView withItem:(id)item
{
    BaseCell *cell = [tableView dequeueReusableCellWithIdentifier:[[BaseCell class] description]];
    if (!cell) {
        cell = [[BaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[[BaseCell class] description]];
        cell.cellTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, tableView.width - 10, tableView.rowHeight)];
        cell.cellTitleLabel.font = FONT_SANSUMI(15.f);
        cell.cellTitleLabel.textColor = TEXT_GRAY_COLOR;
//        cell.cellTitleLabel.layer.borderWidth = 1.f;
        cell.cellTitleLabel.textAlignment = NSTextAlignmentCenter;
        cell.cellTitleLabel.numberOfLines = 2;
        [cell.contentView addSubview:cell.cellTitleLabel];
    }

    return cell;
}

+ (instancetype)cellForTableView:(UITableView *)tableView withItem:(id)item withItemsWidths:(NSArray *)itemsWidths {
    return [self cellForTableView:tableView withItem:item];
}

- (UIEdgeInsets)layoutMargins {
    return UIEdgeInsetsZero;
}


@end
