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


- (void)setupWithCell:(EFBaseCell *)cell withBaseView:(baseView*)bview
{
    PositionCell *rcell = (PositionCell*)cell;
    
    rcell.unit = self.unit;
    
    rcell.xBtn.itemTitles = self.itemsArr;
    rcell.yBtn.itemTitles = self.itemsArr;
    rcell.widthBtn.itemTitles = self.itemsArr;
    rcell.heightBtn.itemTitles = self.itemsArr;
    
    self.x=[NSString stringWithFormat:@"%.2fmm",bview.frame.origin.x/bview.scale/8];
    rcell.xBtn.titleLable.text =self.x;
    
    self.y=[NSString stringWithFormat:@"%.2fmm",bview.frame.origin.y/bview.scale/8];
    rcell.yBtn.titleLable.text = self.y;
    
    self.width=[NSString stringWithFormat:@"%.2fmm",bview.frame.size.width/bview.scale/8];
    rcell.widthBtn.titleLable.text = self.width;
    
    self.height=[NSString stringWithFormat:@"%.2fmm",bview.frame.size.height/bview.scale/8];
    rcell.heightBtn.titleLable.text = self.height;
    
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
