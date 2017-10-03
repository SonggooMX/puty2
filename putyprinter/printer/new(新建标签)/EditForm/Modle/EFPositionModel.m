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


- (void)setupWithCell:(EFBaseCell *)cell withBaseView:(baseView*)bview withNewLabel:(newLabel *)linfo
{
    PositionCell *rcell = (PositionCell*)cell;
    
    rcell.unit = self.unit;
    
    rcell.xBtn.itemTitles = self.itemsArr;
    rcell.yBtn.itemTitles = self.itemsArr;
    rcell.widthBtn.itemTitles = self.itemsArr;
    rcell.heightBtn.itemTitles = self.itemsArr;
    
    float x=[bview getXMM];
    self.x=[NSString stringWithFormat:@"%.2f",x];
    if(self.x){
        rcell.xBtn.titleLable.text =self.x;
        for(int i=0;i<rcell.xBtn.itemTitles.count;i++)
        {
            if(rcell.xBtn.itemTitles[i].floatValue==self.x.floatValue)
            {
                rcell.xBtn.curentIndex=i;
                break;
            }
        }
    }
    
    self.y=[NSString stringWithFormat:@"%.2f",[bview getYMM]];
    if(self.y){
        rcell.yBtn.titleLable.text = self.y;
        for(int i=0;i<rcell.yBtn.itemTitles.count;i++)
        {
            if(rcell.yBtn.itemTitles[i].floatValue==self.y.floatValue)
            {
                rcell.yBtn.curentIndex=i;
                break;
            }
        }
    }
    
    self.width=[NSString stringWithFormat:@"%.2f",[bview getWidthMM]];
    if(self.width){
        rcell.widthBtn.titleLable.text = self.width;
        for(int i=0;i<rcell.widthBtn.itemTitles.count;i++)
        {
            if(rcell.widthBtn.itemTitles[i].floatValue==self.width.floatValue)
            {
                rcell.widthBtn.curentIndex=i;
                break;
            }
        }
    }
    
    self.height=[NSString stringWithFormat:@"%.2f",[bview getHeightMM]];
    if(self.height){
        rcell.heightBtn.titleLable.text = self.height;
        for(int i=0;i<rcell.heightBtn.itemTitles.count;i++)
        {
            if(rcell.heightBtn.itemTitles[i].floatValue==self.height.floatValue)
            {
                rcell.heightBtn.curentIndex=i;
                break;
            }
        }
    }
    
    rcell.xchangeActin = ^(NSString *result,NSInteger index) {
        if(index<0)
        {
            [rcell.xBtn setCurentIndex:0];
            return ;
        }
        else if(index>=rcell.xBtn.itemTitles.count)
        {
            rcell.xBtn.curentIndex=rcell.xBtn.itemTitles.count-1;
            return ;
        }
        self.xindex = index;
        self.x =result;
        //修改元素的坐标位置
        bview.frame=CGRectMake(result.floatValue*8*bview.scale, bview.frame.origin.y, bview.frame.size.width, bview.frame.size.height);
        [bview refreshMsg];
    };
   rcell.ychangeActin = ^(NSString *result,NSInteger index) {
       if(index<0)
       {
           [rcell.yBtn setCurentIndex:0];
           return ;
       }
       else if(index>=rcell.yBtn.itemTitles.count)
       {
           rcell.yBtn.curentIndex=rcell.yBtn.itemTitles.count-1;
           return ;
       }
       self.yindex = index;
       self.y =result;
       bview.frame=CGRectMake(bview.frame.origin.x, result.floatValue*8*bview.scale, bview.frame.size.width, bview.frame.size.height);
       [bview refreshMsg];
   };
    rcell.widthchangeActin = ^(NSString *result,NSInteger index) {
        if(index<0)
        {
            [rcell.widthBtn setCurentIndex:0];
            return ;
        }
        else if(index>=rcell.widthBtn.itemTitles.count)
        {
            rcell.widthBtn.curentIndex=rcell.widthBtn.itemTitles.count-1;
            return ;
        }
        self.windex = index;
        self.width = result;
        
        if(bview.elementType==1)
        {
            //设置高
            [rcell.heightBtn setCurentIndexNoAction:index];
            //二维码
            CGRect rect=CGRectMake(bview.frame.origin.x, bview.frame.origin.y, result.floatValue*8*bview.scale, result.floatValue*8*bview.scale);
            [bview resetViewWH:rect.size];
            [bview refreshMsg];
            return;
        }
        
        CGRect rect=CGRectMake(bview.frame.origin.x, bview.frame.origin.y, result.floatValue*8*bview.scale, bview.frame.size.height);
        [bview resetViewWH:rect.size];
        [bview refreshMsg];
    };
    rcell.heightchangeActin = ^(NSString *result,NSInteger index) {
        if(index<0)
        {
            [rcell.heightBtn setCurentIndex:0];
            return ;
        }
        else if(index>=rcell.heightBtn.itemTitles.count)
        {
            rcell.heightBtn.curentIndex=rcell.heightBtn.itemTitles.count-1;
            return ;
        }
        
        self.hindex = index;
        self.height = result;
        
        if(bview.elementType==8)
        {
            //文本
            return;
        }
        else if(bview.elementType==1)
        {
            [rcell.widthBtn setCurentIndexNoAction:index];
            //二维码
            CGRect rect=CGRectMake(bview.frame.origin.x, bview.frame.origin.y, result.floatValue*8*bview.scale, result.floatValue*8*bview.scale);
            [bview resetViewWH:rect.size];
            [bview refreshMsg];
            return;
        }
        
        CGRect rect=CGRectMake(bview.frame.origin.x, bview.frame.origin.y, bview.frame.size.width, result.floatValue*8*bview.scale);
        [bview resetViewWH:rect.size];
        [bview refreshMsg];
    };
}

@end
