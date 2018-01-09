//
//  TopIndexView.h
//  Debug
//
//  Created by TuFa on 2018/1/7.
//  Copyright © 2018年 TuFa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopIndexCollectionView.h"

typedef void(^DidSelectIndexBlock)(NSInteger index);

@interface NavTabBarSlideView : UIView

@property (nonatomic, strong) NSMutableArray *viewControllers;
@property (nonatomic, strong) TopIndexCollectionView *topIndexCollectionView; //!< 顶部页标签视图
@property (nonatomic, strong)  UIScrollView *rootScrollView;                  //!< 主视图
@property (nonatomic, copy) DidSelectIndexBlock selectedIndexBlock;           //!< 当前是哪个视图


+ (NavTabBarSlideView *)addTopIndexViewframe:(CGRect)frame viewController:(NSArray <UIViewController *>*)viewControllers;

@end
