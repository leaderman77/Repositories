//
//  BaseCell.h
//
//  Created by Администратор on 7/20/14.
//
//

#import <UIKit/UIKit.h>

@class BaseCell;
@protocol BaseCellDelegate <NSObject>

@optional
- (void)cell:(BaseCell *)cell didAction:(NSInteger)actionType withValue:(id)value;
@end

@interface BaseCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *cellImageView;
@property (nonatomic, strong) IBOutlet UILabel *cellTitleLabel;
@property (nonatomic, assign) id<BaseCellDelegate> baseDelegate;
@property (nonatomic, strong) id tagObject;
@property (nonatomic, strong) NSIndexPath *indexPath;

+ (instancetype)cellForTableView:(UITableView *)tableView withItem:(id)item;

+ (instancetype)cellForTableView:(UITableView *)tableView withItem:(id)item withItemsWidths:(NSArray *)itemsWidths;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withHeight:(CGFloat)cellHeight;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withItemsWidths:(NSArray *)itemsWidths;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withCellHeight:(CGFloat)cellHeight withItemsWidths:(NSArray *)itemsWidths;

@end
