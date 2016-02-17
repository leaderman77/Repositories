//
// Created by Sanch0 on 10/20/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//


@implementation UIButton (BarBtnAdditions)

+ (UIButton *)leftBtnWithImageName:(NSString *)imageName withController:(UIViewController *)controller withSelector:(SEL)aSelector {
    UIButton *btn = [[UIButton alloc] init];
//    [btn setBackgroundColor:[UIColor redColor]];
    //    btn.layer.borderWidth = 1.f;
    [btn setTitleColor:NAVIGATION_BAR_BTN_TEXT_COLOR forState:UIControlStateNormal];
    btn.titleLabel.font = FONT_SANSUMI_BOLD(15.f);
    btn.frame = CGRectMake(10, 34, 70, 30);
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    CGFloat padding = 15;
    if (imageName) {
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
//        padding += 10 + btn.image.size.width;
        
    }
    CGSize size = CGSizeZero;
    
    btn.width = size.width + padding + 20;
    [btn setTitle:[@"" uppercaseString] forState:UIControlStateNormal];
    if (controller && aSelector) {
        [btn addTarget:controller action:aSelector forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}

+ (UIButton *)rightBtnWithImageName:(NSString *)imageName withController:(UIViewController *)controller withSelector:(SEL)aSelector {
    UIButton *btn = [[UIButton alloc] init];
//    [btn setBackgroundColor:[UIColor redColor]];
    //    btn.layer.borderWidth = 1.f;
    btn.frame = CGRectMake(305, 34, 60, 30);
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    CGFloat padding = 30;
    if (imageName) {
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 7);
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
//        padding += 10 + btn.image.size.width;
    }
    CGSize size = CGSizeZero;
    
    btn.width = size.width + padding + 30;
    if (controller && aSelector) {
        [btn addTarget:controller action:aSelector forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}
+ (UIButton *)backBtnWithController:(UIViewController *)controller withSelector:(SEL)aSelector {
    return [self leftBtnWithImageName:@"navig_bar_back.png" withController:controller withSelector:aSelector];
}
+ (UIButton *)doneBtnWithController:(UIViewController *)controller withSelector:(SEL)aSelector {
    return [self rightBtnWithImageName:@"navig_bar_save_changes.png" withController:controller withSelector:aSelector];
}
//+ (UIButton *)leftBtnWithTitle:(NSString *)title withImageName:(NSString *)imageName withController:(UIViewController *)controller withSelector:(SEL)aSelector {
//    UIButton *btn = [[UIButton alloc] init];
////    btn.layer.borderWidth = 1.f;
//    [btn setTitleColor:NAVIGATION_BAR_BTN_TEXT_COLOR forState:UIControlStateNormal];
//    btn.titleLabel.font = FONT_SANSUMI_BOLD(15.f);
//    btn.frame = CGRectMake(0, 0, 100, 32);
//    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
//    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    CGFloat padding = 15;
//    if (imageName) {
//        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
//        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
//        padding += 10 + btn.image.size.width;
//
//    }
//    CGSize size = CGSizeZero;
//    if ([title respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
//        size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
//                                   options:NSStringDrawingUsesLineFragmentOrigin
//                                attributes:@{NSFontAttributeName : FONT_SANSUMI_BOLD(15.f)}
//                                   context:nil].size;
//    } else {
//        size = [title sizeWithFont:btn.titleLabel.font];
//    }
//    
//    btn.width = size.width + padding + 20;
//    [btn setTitle:[title uppercaseString] forState:UIControlStateNormal];
//    if (controller && aSelector) {
//        [btn addTarget:controller action:aSelector forControlEvents:UIControlEventTouchUpInside];
//    }
//    return btn;
//}
//
//+ (UIButton *)rightBtnWithTitle:(NSString *)title withImageName:(NSString *)imageName withController:(UIViewController *)controller withSelector:(SEL)aSelector {
//    UIButton *btn = [[UIButton alloc] init];
////    btn.layer.borderWidth = 1.f;
//    [btn setTitleColor:NAVIGATION_BAR_BTN_TEXT_COLOR forState:UIControlStateNormal];
//    btn.titleLabel.font = FONT_SANSUMI_BOLD(15.f);
//    btn.frame = CGRectMake(0, 0, 100, 32);
//    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
//    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    CGFloat padding = 15;
//    if (imageName) {
//        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
//        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 7);
//        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
//        padding += 10 + btn.image.size.width;
//    }
//    CGSize size = [title sizeWithFont:btn.titleLabel.font];
//    btn.width = size.width + padding + 20;
//    [btn setTitle:[title uppercaseString] forState:UIControlStateNormal];
//    if (controller && aSelector) {
//        [btn addTarget:controller action:aSelector forControlEvents:UIControlEventTouchUpInside];
//    }
//    return btn;
//}

//+ (UIButton *)backBtnWithController:(UIViewController *)controller withSelector:(SEL)aSelector {
//    return [self leftBtnWithTitle:[TRANSLATE(@"") uppercaseString] withImageName:@"menu.png"
//                   withController:controller
//                     withSelector:aSelector];
//}

//+ (UIButton *)doneBtnWithController:(UIViewController *)controller withSelector:(SEL)aSelector {
//    return [self rightBtnWithTitle:[TRANSLATE(@"Done") uppercaseString] withImageName:@"approve.png"
//                    withController:controller
//                      withSelector:aSelector];
//}

@end