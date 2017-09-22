//
//  EFFontSizeCell.m
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import "EFFontSizeCell.h"

@implementation EFFontSizeCell


- (void)setChangeActin:(void (^)(NSString *,NSInteger))changeActin
{
    _changeActin = changeActin;
    self.pickBtn.changeActin = changeActin;
}

- (void)setCurentIndex:(NSInteger)curentIndex
{
    _curentIndex = curentIndex;
    self.pickBtn.curentIndex = curentIndex;
}

- (void)setItemTitles:(NSArray<NSString *> *)itemTitles
{
    _itemTitles = itemTitles;
    self.pickBtn.itemTitles = itemTitles;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.pickBtn.changeActin =  self.changeActin;
    self.pickBtn.itemTitles = self.itemTitles;
    self.pickBtn.curentIndex = self.curentIndex;
}


@end
