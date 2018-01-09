//
//  TopIndexCollectionView.m
//  Debug
//
//  Created by TuFa on 2017/12/28.
//  Copyright © 2017年 TuFa. All rights reserved.
//

#import "TopIndexCollectionView.h"
#import "TopIndexCell.h"

#define COBaseSeparatorColor    @"E2E2E2"
#define COBlueColor             @"00adb2"
#define COCommontextColor       @"393939"

@interface TopIndexCollectionView() <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) NSArray *titleArr;               //!< 标题
@property (nonatomic, strong) NSMutableArray *titleWidthArr; //!< 标题宽度
@property (nonatomic, assign) NSInteger selectedIndex; //!< 当前选中的cell index
@property (nonatomic, strong) UIView *colorView;       //!< 滚动条

@end

@implementation TopIndexCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

    }
    return self;
}

+ (TopIndexCollectionView *)showTopIndexView:(CGRect)frame withTitle:(NSArray *)titles {
    TopIndexCollectionView *topIndexView = [[TopIndexCollectionView alloc] initWithFrame:frame];
    topIndexView.titleArr = titles;
    [topIndexView setCollectionViewWithFrame:frame];
    [topIndexView setupViews];
    return topIndexView;
}

- (void)setupViews {
    [self addSubview:self.lineView];
}

- (void)setCollectionViewWithFrame:(CGRect)frame {
    
    if (!self.selectedIndex) self.selectedIndex = 0;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    flowLayout.itemSize = CGSizeMake(kItemSizeW, frame.size.height);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumLineSpacing = 15;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.bounces = NO;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(TopIndexCell.class) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(TopIndexCell.class)];
    [self addSubview:self.collectionView];
    [self.collectionView addSubview:self.colorView];
}

#pragma mark CollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titleArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TopIndexCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(TopIndexCell.class) forIndexPath:indexPath];
    cell.textLab.text = self.titleArr[indexPath.row];
    cell.textLab.textColor = self.selectedIndex == indexPath.row ? [UIColor redColor] : [UIColor blackColor];
    return cell;
}

#pragma mark -
#pragma mark CollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectedIndex = indexPath.row;
    // collectionView 滚动至中央位置
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    // 更新
    [self.collectionView reloadData];
    [self scrollToCurrentCell:indexPath.row animate:YES];
    if (self.selectedBlock) {
        self.selectedBlock(indexPath.row);
    }
    
}

- (void)rootScorllViewToCurrentCel:(NSInteger)index {
    self.selectedIndex = index;
    NSIndexPath *currentPath = [NSIndexPath indexPathForRow:index inSection:0];
    // collectionView 滚动至中央位置
    [self.collectionView scrollToItemAtIndexPath:currentPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    // 更新
    [self.collectionView reloadData];
    [self scrollToCurrentCell:index animate:YES];
}

//滚动条滚动到指定位置
- (void)scrollToCurrentCell:(NSInteger)index animate:(BOOL)animate {
    if (index >= self.titleWidthArr.count) return;
    CGFloat offset_x = 0;
    for (int i = 0; i < index; i++) {
        offset_x += [self.titleWidthArr[i] floatValue];
    }
    if (!animate) {
        self.colorView.frame = CGRectMake(offset_x, self.frame.size.height - 2, [self.titleWidthArr[index] floatValue], 2);
    }
    [UIView animateWithDuration:0.35 animations:^{
        self.colorView.frame = CGRectMake(offset_x, self.frame.size.height - 2, [self.titleWidthArr[index] floatValue], 2);
    }];
}

#pragma mark -
#pragma mark 底部BaseCollectionView 滚动结束后调用
- (void)BaseCollectionViewDidSelectedIndex:(NSInteger)index {
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    
    [self collectionView:_collectionView didSelectItemAtIndexPath:indexPath];
    
}

#pragma mark - collectionView layout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = CGSizeMake([self.titleWidthArr[indexPath.row] floatValue], self.frame.size.height);
    return size;
}

- (NSArray *)titleWidthArr {
    if (!_titleWidthArr) {
        _titleWidthArr = @[].mutableCopy;
        for (NSString *title in self.titleArr) {
            CGSize textSize = [self sizeWithTitle:title font:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(self.frame.size.width, MAXFLOAT)];
            [_titleWidthArr addObject:@(textSize.width + 30)];
        }
    }
    return _titleWidthArr;
}

- (UIView *)colorView {
    if (!_colorView) {
        _colorView = [[UIView alloc] init];
        _colorView.backgroundColor = [UIColor redColor];
        [self scrollToCurrentCell:self.selectedIndex animate:NO];
    }
    return _colorView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1)];
        _lineView.backgroundColor = [UIColor blackColor];
    }
    return _lineView;
}

- (CGSize)sizeWithTitle:(NSString *)title font:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [title boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

@end
