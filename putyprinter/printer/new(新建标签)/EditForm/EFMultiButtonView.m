//
//  EFMultiButtonView.m
//  EdictForm
//
//  Created by 韦超才 on 2017/8/10.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import "EFMultiButtonView.h"


#define kheightBlue    [UIColor colorWithRed:0 green:124/255.0 blue:224/255.0 alpha:1.0]
#define kdarkBlue      [UIColor colorWithRed:68/255.0 green:155/255.0 blue:227/255.0 alpha:1.0]
#define kdarkLine      [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0]


@interface  EFMultiButtonView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic,strong)UICollectionViewFlowLayout *collectionViewlayout;



@end

@implementation EFMultiButtonView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.currentindex = 0;
}

- (void)addBtnWithIndex:(NSInteger)index
{
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    
    btn.layer.borderWidth = 1.0f;
    btn.layer.borderColor = kdarkLine.CGColor;
    btn.layer.cornerRadius = 5.0f;
    btn.clipsToBounds = true;
    
    [btn setTitle:self.itemStrs[index].str forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateSelected)];
    [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    btn.backgroundColor =  self.itemStrs[index].isSelected ? kheightBlue: [UIColor whiteColor];
    btn.selected  = self.itemStrs[index].isSelected;
    btn.tag  = index;
    [self addSubview:btn];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self setFrameWithBtn:btn index:index];
    
}



- (void)setFrameWithBtn:(UIButton *)btn index:(NSInteger)index
{
    NSInteger row = index % self.numberOfItemPerLine;
    NSInteger section = (int)(index / self.numberOfItemPerLine);
    btn.frame = CGRectMake(row * ([self  itemWidth] + 5 ), (30 + 5) * section , [self itemWidth], 30);
    if (self.itemStrs < 4) {
        CGPoint center = btn.center;
        center.y = self.center.y;
        btn.center = self.center;
    }
}


- (void)btnClick:(UIButton *)btn
{
    self.currentindex = btn.tag;
    if (self.selectedAction) {
        self.selectedAction(self.currentindex);
    }
}


- (void)setItemStrs:(NSArray<ButtonModle *> *)itemStrs
{
    NSMutableArray *arr = [NSMutableArray new];
    for (NSString *str in itemStrs) {
        if ([str isKindOfClass:[NSString class]]) {
            ButtonModle *modle = [ButtonModle new];
            modle.str = str;
            [arr addObject:modle];
        }else{
            [arr addObject:str];
        }
    }
    _itemStrs = arr;
    for (int i = 0; i < itemStrs.count ;i++) {
        [self addBtnWithIndex:i];
    }
    
}

- (CGFloat)itemWidth
{
    CGFloat width = (self.bounds.size.width - 5 * (self.numberOfItemPerLine + 1)) / self.numberOfItemPerLine;
    return width;
}


- (NSInteger)numberOfItemPerLine
{
    if (!_numberOfItemPerLine) {
        _numberOfItemPerLine = self.itemStrs.count;
        if (self.itemStrs.count >= 4) {
            _numberOfItemPerLine = 4;
        }else{
            _numberOfItemPerLine = self.itemStrs.count;
        }
    }
    return _numberOfItemPerLine;
}


- (ButtonModle *)currentModle
{
    return self.itemStrs[self.currentindex];
}


- (void)setupBtn:(UIButton *)btn withIndex:(NSInteger)index
{
    [btn setTitle:self.itemStrs[index].str forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateSelected)];
    [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    btn.backgroundColor =  index == self.currentindex ? kheightBlue: [UIColor whiteColor];
    btn.selected  = index == self.currentindex;
}

- (void)setCurrentindex:(NSInteger)currentindex
{
    _currentindex = currentindex;
    for (int i = 0;i < self.itemStrs.count;i++) {
        ButtonModle *modle = self.itemStrs[currentindex];
        modle.isSelected = i == currentindex;
    }
    
    for (int i = 0;i < self.subviews.count;i++) {
        UIButton *btn = [self subviews][i];
        if ([btn isKindOfClass:[UIButton class]]) {
            [self setupBtn:btn withIndex:i];
        }
    }
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    for (int i = 0;i < self.subviews.count;i++) {
        UIButton *btn = [self subviews][i];
        if ([btn isKindOfClass:[UIButton class]]) {
            [self setFrameWithBtn:btn index:i];
        }
    }
    
}


@end
