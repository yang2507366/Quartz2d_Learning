//
//  Sort.m
//  Quartz2d_Learning
//
//  Created by yangzexin on 13-3-21.
//
//

#import "Sort.h"

@implementation Sort

- (id)init
{
    self = [super init];
//    [self bubbleSort];
    
    [self insertSort];
    return self;
}

- (void)bubbleSort
{
    NSInteger score[] = {67, 69, 75, 87, 89, 90, 99, 100};
    NSInteger arrayLength = 8;
    for(NSInteger i = 0; i < arrayLength - 1; ++i){
        for(NSInteger j = 0; j < arrayLength - i - 1; ++j){
            if(score[j] < score[j + 1]){
                NSInteger temp = score[j];
                score[j] = score[j + 1];
                score[j + 1] = temp;
                NSLog(@"swap:%d->%d", temp, score[j]);
            }
        }
    }
    for(NSInteger i = 0; i < arrayLength; ++i){
        NSLog(@"%d", score[i]);
    }
}

- (void)insertSort
{
    NSInteger score[] = {67, 69, 75, 87, 89, 90, 99, 100};
    NSInteger arrayLength = 8;
    for(NSInteger i = 1; i < arrayLength; ++i){
        NSInteger j = i;
        NSInteger tmp = score[i];
        while(j > 0 && score[j - 1] > tmp){
            score[j] = score[j - 1];
            --j;
        }
        score[j] = tmp;
    }
    
    for(NSInteger i = 0; i < arrayLength; ++i){
        NSLog(@"%d", score[i]);
    }
}

@end
