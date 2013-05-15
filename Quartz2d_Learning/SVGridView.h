//
//  SVGridView.h
//  Quartz2d_Learning
//
//  Created by yangzexin on 13-5-15.
//
//

#import <Foundation/Foundation.h>

@interface SVGridView : UIView

@property(nonatomic, readonly)NSInteger numberOfRows;
@property(nonatomic, readonly)NSInteger numberOfColumns;

@property(nonatomic, copy)UIView *(^itemViewBlock)(NSInteger index);

- (id)initWithNumberOfRows:(NSInteger)rows columns:(NSInteger)columns;
- (void)reload;

@end
