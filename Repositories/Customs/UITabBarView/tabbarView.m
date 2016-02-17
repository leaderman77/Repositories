//
//  tabbarView.m
//  tabbarTest
//
//  Created by Kevin Lee on 13-5-6.
//  Copyright (c) 2013年 Kevin. All rights reserved.
//

#import "tabbarView.h"
#import "NewTypeController.h"
#import "ChatsBottomViewController.h"
#import "SearchAnnouncementsController.h"
#import "CLTokenInputViewController.h"

@interface tabbarView ()
@property (nonatomic) NSInteger buttonTag;
@end

@implementation tabbarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setFrame:frame];
//        [self setBackgroundColor:[UIColor blueColor]];
        [self layoutView];
    }
    return self;
}

-(void)layoutView
{
    _tabbarView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"4"]];
    [_tabbarView setFrame:CGRectMake(0, 15, self.width, 45)];
    [_tabbarView setUserInteractionEnabled:YES];
    
    _tabbarViewCenter = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search.png"]];
//    _tabbarViewCenter.layer.borderWidth = 1;
    _tabbarViewCenter.frame = CGRectMake(170, 0, 70, 60);
    _tabbarViewCenter.center = CGPointMake(self.center.x, self.bounds.size.height/2.0);
    
    [_tabbarViewCenter setUserInteractionEnabled:YES];
    
    _button_center = [UIButton buttonWithType:UIButtonTypeCustom];
    _button_center.adjustsImageWhenHighlighted = YES;
//    [_button_center setBackgroundImage:[UIImage imageNamed:@"tabbar_mainbtn"] forState:UIControlStateNormal];
    
    [_button_center setFrame:CGRectMake(0, 0, 36, 36)];
    
    _button_center.center =CGPointMake(_tabbarViewCenter.bounds.size.width/2.0, _tabbarViewCenter.bounds.size.height/2.0 + 5) ;
    [_button_center addTarget:self action:@selector(searchBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_tabbarViewCenter addSubview:_button_center];
    
    [self addSubview:_tabbarView];
    [self addSubview:_tabbarViewCenter];
    
    [self layoutBtn];

}

-(void)layoutBtn
{
    CGFloat width = self.height;
    CGFloat left = 0;
    CGFloat height = 50;
    
    _button_1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_button_1 setBackgroundColor:[UIColor blueColor]];
//    _button_1.layer.borderWidth = 1;
    [_button_1 setFrame:CGRectMake(left, 0, width, height)];
    [_button_1 setTag:101];
    [_button_1 addTarget:self action:@selector(btn1Click:) forControlEvents:UIControlEventTouchUpInside];
    
    left = left + _button_1.width;
    _button_2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    _button_2.layer.borderWidth = 1;
    [_button_2 setFrame:CGRectMake(left + 10, 0, width, height)];
    [_button_2 setTag:102];
    [_button_2 addTarget:self action:@selector(btn1Click:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.tabbarView.width >= 375) {
        left = 220;
    } else left = 190;
    _button_3 = [UIButton buttonWithType:UIButtonTypeCustom];
//    _button_3.layer.borderWidth = 1;
    [_button_3 setFrame:CGRectMake(left, 0, width, height)];
    [_button_3 setTag:103];
    [_button_3 addTarget:self action:@selector(btn1Click:) forControlEvents:UIControlEventTouchUpInside];
    
    left = left + _button_3.width;
    _button_4 = [UIButton buttonWithType:UIButtonTypeCustom];
//    _button_4.layer.borderWidth = 1;
    [_button_4 setFrame:CGRectMake(left, 0, width + 15, height)];
    [_button_4 setTag:104];
    [_button_4 addTarget:self action:@selector(btn1Click:) forControlEvents:UIControlEventTouchUpInside];
    
    [_tabbarView addSubview:_button_1];
    [_tabbarView addSubview:_button_2];
    [_tabbarView addSubview:_button_3];
    [_tabbarView addSubview:_button_4];
    
}
- (void)searchBtnClicked:(id)sender {
    if (self.buttonTag == 101) {
        
    } else if (self.buttonTag == 102) {
        ChatsBottomViewController *viewController = [[ChatsBottomViewController alloc]init];
//        CLTokenInputViewController *tokenVC = [[CLTokenInputViewController alloc] initWithNibName:nil bundle:nil];
        if ([self.tabBarSearchDelegate respondsToSelector:@selector(openNextController:)]) {
            [self.tabBarSearchDelegate openNextController:viewController];
        }
    } else if (self.buttonTag == 103) {
        NewTypeController *newsTypeController = [[NewTypeController alloc]init];
        if ([self.tabBarSearchDelegate respondsToSelector:@selector(openNewsTypeController:)]) {
            [self.tabBarSearchDelegate openNewsTypeController:newsTypeController];
        }
    } else if (self.buttonTag == 104) {
        SearchAnnouncementsController *searchAnnounceContrller = [[SearchAnnouncementsController alloc]init];
        if ([self.tabBarSearchDelegate respondsToSelector:@selector(openSearchAnnounceController:)]) {
            [self.tabBarSearchDelegate openSearchAnnounceController:searchAnnounceContrller];
        }
    }


    
//    [self.delegate touchBtnAtIndex:0];
}

-(void)btn1Click:(id)sender
{
        
    UIButton *btn = (UIButton *)sender;
    NSLog(@"%i",btn.tag);
    switch (btn.tag) {
        case 101:
        {
            [_tabbarView setImage:[UIImage imageNamed:@"4"]];
            [self.delegate touchBtnAtIndex:0];
            self.buttonTag = btn.tag;
            break;
        }
        case 102:
        {
            [_tabbarView setImage:[UIImage imageNamed:@"3"]];
            [self.delegate touchBtnAtIndex:1];
            self.buttonTag = btn.tag;
            break;
        }
        case 103:
            [_tabbarView setImage:[UIImage imageNamed:@"2"]];
            [self.delegate touchBtnAtIndex:2];
            self.buttonTag = btn.tag;
            break;
        case 104:
            [_tabbarView setImage:[UIImage imageNamed:@"1"]];
            [self.delegate touchBtnAtIndex:3];
            self.buttonTag = btn.tag;
            break;
        default:
            break;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
