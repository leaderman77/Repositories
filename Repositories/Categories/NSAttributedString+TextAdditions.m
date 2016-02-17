//
// Created by Sanch0 on 10/23/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//


@implementation NSAttributedString (TextAdditions)

+ (NSAttributedString *)attributedStringWithTitle:(NSString *)title withFontSize:(CGFloat)fontSize {
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:(title && ![title isEqual:[NSNull null]]) ? title : @"" attributes:@{NSFontAttributeName :
            FONT_SANSUMI(fontSize), NSForegroundColorAttributeName : TEXT_GRAY_COLOR, NSKernAttributeName : kDefaultKernValue}];

    return string;
}

+ (NSAttributedString *)attributedStringWithTitle:(NSString *)title withBoldFontSize:(CGFloat)fontSize {

    NSAttributedString *string = [[NSAttributedString alloc] initWithString:(title && ![title isEqual:[NSNull null]]) ? title : @"" attributes:@{NSFontAttributeName :
            FONT_SANSUMI_BOLD(fontSize), NSForegroundColorAttributeName : TEXT_GRAY_COLOR, NSKernAttributeName : kDefaultKernValue}];

    return string;
}

+ (NSAttributedString *)attributedStringWithTitle:(NSString *)title withTextAlign:(NSTextAlignment)textAlignment withFontSize:(CGFloat)fontSize {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = textAlignment;
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:(title && ![title isEqual:[NSNull null]]) ? title : @"" attributes:@{NSFontAttributeName :
            FONT_SANSUMI(fontSize), NSForegroundColorAttributeName : TEXT_GRAY_COLOR, NSKernAttributeName : kDefaultKernValue, NSParagraphStyleAttributeName : paragraphStyle}];

    return string;
}

+ (NSAttributedString *)attributedStringWithTitle:(NSString *)title withTextAlign:(NSTextAlignment)textAlignment withBoldFontSize:(CGFloat)fontSize {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = textAlignment;
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:(title && ![title isEqual:[NSNull null]]) ? title : @"" attributes:@{NSFontAttributeName :
            FONT_SANSUMI_BOLD(fontSize), NSForegroundColorAttributeName : TEXT_GRAY_COLOR, NSKernAttributeName : kDefaultKernValue, NSParagraphStyleAttributeName : paragraphStyle}];

    return string;
}

+ (NSAttributedString *)attributedStringForButtonWithTitle:(NSString *)title withFontSize:(CGFloat)fontSize {

    NSAttributedString *string = [[NSAttributedString alloc] initWithString:(title && ![title isEqual:[NSNull null]]) ? title : @"" attributes:@{NSFontAttributeName :
            FONT_SANSUMI(fontSize), NSForegroundColorAttributeName : [UIColor whiteColor], NSKernAttributeName : kDefaultKernValue}];

    return string;
}

+ (NSAttributedString *)attributedStringForButtonWithTitle:(NSString *)title withBoldFontSize:(CGFloat)fontSize {
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:(title && ![title isEqual:[NSNull null]]) ? title : @"" attributes:@{NSFontAttributeName :
            FONT_SANSUMI_BOLD(fontSize), NSForegroundColorAttributeName : [UIColor whiteColor], NSKernAttributeName : kDefaultKernValue}];

    return string;
}

+ (NSAttributedString *)attributedStringWithTitle:(NSString *)title withTextColor:(UIColor *)color withFontSize:(CGFloat)fontSize {
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:(title && ![title isEqual:[NSNull null]]) ? title : @"" attributes:@{NSFontAttributeName :
            FONT_SANSUMI(fontSize), NSForegroundColorAttributeName : color, NSKernAttributeName : kDefaultKernValue}];

    return string;
}

+ (NSAttributedString *)attributedStringWithTitle:(NSString *)title withTextColor:(UIColor *)color withBoldFontSize:(CGFloat)fontSize {
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:(title && ![title isEqual:[NSNull null]]) ? title : @"" attributes:@{NSFontAttributeName :
            FONT_SANSUMI_BOLD(fontSize), NSForegroundColorAttributeName : color, NSKernAttributeName : kDefaultKernValue}];

    return string;
}
/////
+ (NSAttributedString *)attributedStringWithTitle:(NSString *)title withTextColor:(UIColor *)color {
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:(title && ![title isEqual:[NSNull null]]) ? title : @""
                                                                 attributes:@{NSForegroundColorAttributeName : color, NSKernAttributeName : @(1)}];
    
    return string;
}
////
+ (NSAttributedString *)attributedStringWithTitle:(NSString *)title withTextColor:(UIColor *)color withFontSize:(CGFloat)fontSize withLineSpacing:(CGFloat)lineSpacing {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:[NSAttributedString attributedStringWithTitle:title withTextColor:color
                                                                                                                                               withFontSize:fontSize]];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
//    paragraphStyle.alignment = NSTextAlignmentCenter;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedString.length)];
    return attributedString;
}

+ (NSAttributedString *)attributedStringWithTitle:(NSString *)title withTextColor:(UIColor *)color withBoldFontSize:(CGFloat)fontSize withLineSpacing:(CGFloat)lineSpacing {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:[NSAttributedString attributedStringWithTitle:title withTextColor:color
                                                                                                                                           withBoldFontSize:fontSize]];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
//    paragraphStyle.alignment = NSTextAlignmentCenter;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedString.length)];
    return attributedString;
}


- (CGFloat)heightWithWidth:(CGFloat)width {
    return [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
}

- (CGFloat)textWidth {
    return [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.width;
}


@end