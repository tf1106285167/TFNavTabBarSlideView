//
//  TopIndexCollectionView.h
//  Debug
//
//  Created by TuFa on 2017/12/28.
//  Copyright © 2017年 TuFa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DidSelectItemBlock)(NSInteger row);

@interface TopIndexCollectionView : UIView

@property (nonatomic, copy) DidSelectItemBlock selectedBlock;
@property (nonatomic, strong) UIView *lineView;


+ (TopIndexCollectionView *)showTopIndexView:(CGRect)frame withTitle:(NSArray *)titles;

//顶部页标签视图滚动到指定位置
- (void)rootScorllViewToCurrentCel:(NSInteger)index;

@end
