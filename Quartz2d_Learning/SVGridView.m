//
//  SVGridView.m
//  Quartz2d_Learning
//
//  Created by yangzexin on 13-5-15.
//
//

#import "SVGridView.h"

@implementation SVGridView

- (void)dealloc
{
    self.itemViewBlock = nil;
    [super dealloc];
}

- (id)initWithNumberOfRows:(NSInteger)rows columns:(NSInteger)columns
{
    self = [super initWithFrame:CGRectZero];
    
    _numberOfRows = rows;
    _numberOfColumns = columns;
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if(_numberOfColumns != 0 && _numberOfRows != 0 && self.itemViewBlock){
        CGFloat itemViewWidth = self.frame.size.width / _numberOfColumns;
        CGFloat itemViewHeight = self.frame.size.height / _numberOfRows;
        for(NSInteger i = 0; i < _numberOfRows; ++i){
            for(NSInteger j = 0; j < _numberOfColumns; ++j){
                NSInteger index = i * _numberOfColumns + j;
                UIView *view = self.itemViewBlock(index);
                view.frame = CGRectMake(j * itemViewWidth, i * itemViewHeight, itemViewWidth, itemViewHeight);
                [view removeFromSuperview];
                [self addSubview:view];
            }
        }
    }
}

- (void)reload
{
    [self setNeedsLayout];
}

@end
