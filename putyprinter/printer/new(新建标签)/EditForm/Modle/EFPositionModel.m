//
//  EFPositionModel.m
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import "EFPositionModel.h"
#import "PositionCell.h"
@implementation EFPositionModel

+ (NSString *)cellId
{
    // subclass must overrid it
    return NSStringFromClass([PositionCell class]);
}


- (void)setupWithCell:(EFBaseCell *)cell
{
    PositionCell *rcell = cell;
    if (self.x) {
        rcell.xBtn.titleLable.text = self.x;
            }
    
    if (self.y) {
        rcell.yBtn.titleLable.text = self.y;
        

    }
    if (self.width) {
        rcell.widthBtn.titleLable.text = self.width;
            }
    
    if (self.height) {
        rcell.heightBtn.titleLable.text = self.height;

    }
    rcell.unit = self.unit;
    
    rcell.xBtn.itemTitles = self.itemsArr;
    rcell.yBtn.itemTitles = self.itemsArr;
    rcell.widthBtn.itemTitles = self.itemsArr;
    rcell.heightBtn.itemTitles = self.itemsArr;
    
    rcell.xchangeActin = ^(NSString *result,NSInteger index) {
        self.xindex = index;
        self.x = result;
    };
   rcell.ychangeActin = ^(NSString *result,NSInteger index) {
       self.yindex = index;
       self.y =result;
   };
    rcell.widthchangeActin = ^(NSString *result,NSInteger index) {
        self.windex = index;
        self.width = result;
    };
    rcell.heightchangeActin = ^(NSString *result,NSInteger index) {
        self.hindex = index;
        self.height = result;
    };
}

@end
