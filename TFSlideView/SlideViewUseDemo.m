//
//  TopIndexViewController.m
//  Debug
//
//  Created by TuFa on 2017/12/28.
//  Copyright © 2017年 TuFa. All rights reserved.
//

#import "SlideViewUseDemo.h"
#import "NavTabBarSlideView.h"

#define ScreenHeight             [UIScreen mainScreen].bounds.size.height
#define ScreenWidth              [UIScreen mainScreen].bounds.size.width
#define IS_iPhoneX ([UIScreen mainScreen].bounds.size.width == 375 && [UIScreen mainScreen].bounds.size.height == 812)
#define HeightNavigationBarHide   (IS_iPhoneX ? -88.f : -64.f)
#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

@interface SlideViewUseDemo ()

@property (nonatomic, strong) NavTabBarSlideView *slideView;
@property (nonatomic, copy) NSArray *titleArr;
@property (nonatomic, strong) NSMutableArray *viewControllers;

@end

@implementation SlideViewUseDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.slideView];
    
    self.title = @"title";
    
    self.slideView.selectedIndexBlock = ^(NSInteger index) {
        NSLog(@"----当前选择 index= %@", @(index));
    };
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NavTabBarSlideView *)slideView {
    if (!_slideView) {
        _slideView = [NavTabBarSlideView addTopIndexViewframe:CGRectMake(0, -HeightNavigationBarHide, ScreenWidth, ScreenHeight) viewController:self.viewControllers];
    }
    return _slideView;
}

- (NSMutableArray *)viewControllers {
    if (!_viewControllers) {
        _viewControllers = @[].mutableCopy;
        for (NSString *title in self.titleArr) {
            UIViewController *viewC = [[UIViewController alloc] init];
            viewC.title = title;
            
            { //加颜色为了区分
            int R = (arc4random() % 256) ;
            int G = (arc4random() % 256) ;
            int B = (arc4random() % 256) ;
            viewC.view.backgroundColor = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];  
            }
            
            [_viewControllers addObject:viewC];
        }
    }
    return _viewControllers;
}

- (NSArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"家居",
                      @"健康",
                      @"医疗美容",
                      @"户外运动",
                      @"娱乐",
                      @"教育",
                      @"办公用品",
                      @"房屋装修用品",
                      @"安全"];
    }
    return _titleArr;
}

@end
