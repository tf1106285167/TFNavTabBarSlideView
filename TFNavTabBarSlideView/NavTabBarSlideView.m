//
//  TopIndexView.m
//  Debug
//
//  Created by TuFa on 2018/1/7.
//  Copyright © 2018年 TuFa. All rights reserved.
//

#import "NavTabBarSlideView.h"

#define HeightfTopView 35

@interface NavTabBarSlideView ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *titleArr;
@property (nonatomic, assign) NSInteger currentIndex;


@end

@implementation NavTabBarSlideView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

+ (NavTabBarSlideView *)addTopIndexViewframe:(CGRect)frame viewController:(NSArray <UIViewController *>*)viewControllers {
    
    NavTabBarSlideView *topIndexView = [[NavTabBarSlideView alloc] initWithFrame:frame];
    topIndexView.viewControllers = viewControllers.mutableCopy; 
    
    [topIndexView setupViews];
    [topIndexView registerRACSignal];
    return topIndexView;
}

- (void)setupViews {
    
    [self addSubview:self.rootScrollView];
    self.currentIndex = 0;
    self.titleArr = @[].mutableCopy;
    for (int i = 0; i < self.viewControllers.count; i++) {
        UIViewController *viewC = self.viewControllers[i];
        NSAssert(viewC.title.length, @"请设置viewController.title");
        [self.titleArr addObject:viewC.title];
        viewC.view.frame = CGRectMake(self.rootScrollView.bounds.size.width * i, 0,
                                       self.rootScrollView.bounds.size.width, self.rootScrollView.bounds.size.height);
        [self.rootScrollView addSubview:viewC.view];
    }
    [self addSubview:self.topIndexCollectionView];
}

- (void)registerRACSignal {
    __weak __typeof(self)weakSelf = self;
    self.topIndexCollectionView.selectedBlock = ^(NSInteger row) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        //滚动到选中的视图
        [strongSelf.rootScrollView setContentOffset:CGPointMake(row * self.bounds.size.width, 0) animated:NO];
    };
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(scrollEndAdjust) withObject:nil afterDelay:0.1];
}

//滚动结束后调整位置
- (void)scrollEndAdjust {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    NSInteger scroll_x = self.rootScrollView.contentOffset.x;
    NSInteger index = scroll_x / self.bounds.size.width;
    if (index == self.currentIndex) {
        return;
    }
    self.currentIndex = index;
    [self.topIndexCollectionView rootScorllViewToCurrentCel:index];
    __weak __typeof(self)weakSelf = self;
    if (self.selectedIndexBlock) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.selectedIndexBlock(index);
    }
}


#pragma mark - 懒加载
- (TopIndexCollectionView *)topIndexCollectionView {
    if (!_topIndexCollectionView) {
        _topIndexCollectionView = [TopIndexCollectionView showTopIndexView:CGRectMake(0, 0, self.bounds.size.width, HeightfTopView) withTitle:self.titleArr];
    }
    return _topIndexCollectionView;
}

- (UIScrollView *)rootScrollView {
    if (!_rootScrollView) {
        //创建主滚动视图
        _rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, HeightfTopView, self.bounds.size.width, self.bounds.size.height - HeightfTopView)];
        _rootScrollView.delegate = self;
        _rootScrollView.pagingEnabled = YES;
        _rootScrollView.userInteractionEnabled = YES;
        _rootScrollView.bounces = NO;
        _rootScrollView.showsHorizontalScrollIndicator = NO;
        _rootScrollView.showsVerticalScrollIndicator = NO;
        _rootScrollView.scrollsToTop = NO;
        //更新主视图的总宽度
        _rootScrollView.contentSize = CGSizeMake(self.bounds.size.width * self.viewControllers.count, 0);
    }
    return _rootScrollView;
}

@end
