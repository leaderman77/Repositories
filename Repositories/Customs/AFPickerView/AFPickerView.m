//
//  AFPickerView.m
//  PickerView
//
//  Created by Fraerman Arkady on 24.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AFPickerView.h"

#define ROW_HEIGHT 30
@implementation AFPickerView

#pragma mark - Synthesization

@synthesize dataSource;
@synthesize delegate;
@synthesize selectedRow = currentRow;
@synthesize rowFont = _rowFont;
@synthesize rowIndent = _rowIndent;


#pragma mark - Custom getters/setters

- (void)setSelectedRow:(NSInteger)selectedRow {
    if (selectedRow >= rowsCount) {
        return;
    }

    currentRow = selectedRow;
    [contentView setContentOffset:CGPointMake(0.0, ROW_HEIGHT * currentRow) animated:YES];
}


- (void)setRowFont:(UIFont *)rowFont {
    _rowFont = rowFont;

    for (UILabel *aLabel in visibleViews) {
        aLabel.font = _rowFont;
    }

    for (UILabel *aLabel in recycledViews) {
        aLabel.font = _rowFont;
    }
}


- (void)setRowIndent:(CGFloat)rowIndent {
    _rowIndent = rowIndent;

    for (UILabel *aLabel in visibleViews) {
        CGRect frame = aLabel.frame;
        frame.origin.x = _rowIndent;
        frame.size.width = self.frame.size.width - _rowIndent;
        aLabel.frame = frame;
    }

    for (UILabel *aLabel in recycledViews) {
        CGRect frame = aLabel.frame;
        frame.origin.x = _rowIndent;
        frame.size.width = self.frame.size.width - _rowIndent;
        aLabel.frame = frame;
    }
}


#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // setup
        [self setup];

        // backgound
        UIImageView *bacground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pickerBackground.png"]];
        [self addSubview:bacground];

        // content
        contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, frame.size.width, frame.size.height)];
        contentView.showsHorizontalScrollIndicator = NO;
        contentView.showsVerticalScrollIndicator = NO;
        contentView.delegate = self;
        [self addSubview:contentView];

        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
        [contentView addGestureRecognizer:tapRecognizer];


        // shadows
        UIImageView *shadows = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pickerShadows.png"]];
        [self addSubview:shadows];

        // glass
        UIImage *glassImage = [UIImage imageNamed:@"pickerGlass.png"];
        glassImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.5 * (self.height - glassImage.size.height) + 2, glassImage.size.width, glassImage.size.height)];
        glassImageView.image = glassImage;
        glassImageView.width = self.width;
        [self addSubview:glassImageView];

        /*   bacground.width = self.width;
           shadows.width = self.width;
           glassImageView.width = self.width;
           glassImageView.contentMode = UIViewContentModeScaleAspectFill;
           bacground.contentMode = UIViewContentModeScaleAspectFill;
           shadows.contentMode = UIViewContentModeScaleAspectFill;*/
    }
    return self;
}


- (void)setup {
    _rowFont = FONT_SANSUMI_BOLD(24);//[UIFont boldSystemFontOfSize:24.0];
    _rowIndent = 15.0;

    currentRow = 0;
    rowsCount = 0;
    visibleViews = [[NSMutableSet alloc] init];
    recycledViews = [[NSMutableSet alloc] init];
}


#pragma mark - Buisness

- (void)reloadData {
    // empry views
    currentRow = 0;
    rowsCount = 0;

    for (UIView *aView in visibleViews)
        [aView removeFromSuperview];

    for (UIView *aView in recycledViews)
        [aView removeFromSuperview];

    visibleViews = [[NSMutableSet alloc] init];
    recycledViews = [[NSMutableSet alloc] init];

    rowsCount = [dataSource numberOfRowsInPickerView:self];
    [contentView setContentOffset:CGPointMake(0.0, 0.0) animated:NO];
    contentView.contentSize = CGSizeMake(contentView.frame.size.width, ROW_HEIGHT * rowsCount + 4 * ROW_HEIGHT);
    [self tileViews];
}


- (void)determineCurrentRow {
    CGFloat delta = contentView.contentOffset.y;
    int position = round(delta / ROW_HEIGHT);
    currentRow = position;
    [contentView setContentOffset:CGPointMake(0.0, ROW_HEIGHT * position) animated:YES];
    [delegate pickerView:self didSelectRow:currentRow];
}


- (void)didTap:(id)sender {
    UITapGestureRecognizer *tapRecognizer = (UITapGestureRecognizer *) sender;
    CGPoint point = [tapRecognizer locationInView:self];
    int steps = floor(point.y / ROW_HEIGHT) - 2;
    [self makeSteps:steps];
}


- (void)makeSteps:(int)steps {
    if (steps == 0 || steps > 2 || steps < -2) {
        return;
    }

    [contentView setContentOffset:CGPointMake(0.0, ROW_HEIGHT * currentRow) animated:NO];

    NSInteger newRow = currentRow + steps;
    if (newRow < 0 || newRow >= rowsCount) {
        if (steps == -2) {
            [self makeSteps:-1];
        } else if (steps == 2) {
            [self makeSteps:1];
        }

        return;
    }

    currentRow = currentRow + steps;
    [contentView setContentOffset:CGPointMake(0.0, ROW_HEIGHT * currentRow) animated:YES];
    [delegate pickerView:self didSelectRow:currentRow];
}


#pragma mark - recycle queue

- (UIView *)dequeueRecycledView {
    UIView *aView = [recycledViews anyObject];

    if (aView) {
        [recycledViews removeObject:aView];
    }
    return aView;
}


- (BOOL)isDisplayingViewForIndex:(NSUInteger)index {
    BOOL foundPage = NO;
    for (UIView *aView in visibleViews) {
        int viewIndex = aView.frame.origin.y / ROW_HEIGHT - 2;
        if (viewIndex == index) {
            foundPage = YES;
            break;
        }
    }
    return foundPage;
}


- (void)tileViews {
    // Calculate which pages are visible
    CGRect visibleBounds = contentView.bounds;
    int firstNeededViewIndex = floorf(CGRectGetMinY(visibleBounds) / ROW_HEIGHT) - 2;
    int lastNeededViewIndex = floorf((CGRectGetMaxY(visibleBounds) / ROW_HEIGHT)) - 2;
    firstNeededViewIndex = MAX(firstNeededViewIndex, 0);
    lastNeededViewIndex = MIN(lastNeededViewIndex, rowsCount - 1);

    // Recycle no-longer-visible pages 
    for (UIView *aView in visibleViews) {
        int viewIndex = aView.frame.origin.y / ROW_HEIGHT - 2;
        if (viewIndex < firstNeededViewIndex || viewIndex > lastNeededViewIndex) {
            [recycledViews addObject:aView];
            [aView removeFromSuperview];
        }
    }

    [visibleViews minusSet:recycledViews];

    // add missing pages
    for (int index = firstNeededViewIndex; index <= lastNeededViewIndex; index++) {
        if (![self isDisplayingViewForIndex:index]) {
            UILabel *label = (UILabel *) [self dequeueRecycledView];

            if (label == nil) {
                label = [[UILabel alloc] initWithFrame:CGRectMake(_rowIndent, 0, self.frame.size.width - _rowIndent, ROW_HEIGHT)];
                label.backgroundColor = [UIColor clearColor];
                label.font = self.rowFont;
                label.textColor = rgbColorWithAlpha(0.0, 0.0, 0.0, 0.75);
            }

            [self configureView:label atIndex:index];
            [contentView addSubview:label];
            [visibleViews addObject:label];
        }
    }
}


- (void)configureView:(UIView *)view atIndex:(NSUInteger)index {
    UILabel *label = (UILabel *) view;
    id text = [dataSource pickerView:self titleForRow:index];
    if ([text isKindOfClass:[NSAttributedString class]]) {
        label.attributedText = text;
    } else if ([text isKindOfClass:[NSString class]]) {
        label.text = text;
    }
//    label.layer.borderWidth = 1.f;
    CGRect frame = label.frame;
    frame.origin.y = ROW_HEIGHT * index + ROW_HEIGHT * 2;
    label.frame = frame;
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self tileViews];
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self determineCurrentRow];
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self determineCurrentRow];
}

@end
