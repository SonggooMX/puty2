//
//  EFAngleModel.m
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import "EFAngleModel.h"
#import "FontAngleCell.h"
#import "PositionCell.h"


@implementation EFAngleModel


+ (NSString *)cellId
{
    // subclass must overrid it
    return NSStringFromClass([FontAngleCell class]);
}

- (void)setupWithCell:(EFBaseCell *)cell withBaseView:(baseView*)bview withNewLabel:(newLabel *)linfo withTB:(UITableView *)tb
{
    FontAngleCell *rcell = (FontAngleCell*)cell;
    rcell.seletedIndex = self.seletedIndex;
    rcell.selectedAcction = ^(NSInteger index) {
        self.seletedIndex = index;
        if (self.selectedAcction) {
            self.selectedAcction(index);
        }
        
        //旋转角度
        [bview rotate:(int)self.seletedIndex];
        
        PositionCell *cell2;
        
        if(bview.elementType==0||bview.elementType==8)
        {
            //一维码
            //更新数据 坐标数据
            cell2=[tb cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]];
        }
        else if(bview.elementType==1)
        {
            //二维码
            cell2=[tb cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
        }
        else if(bview.elementType==2||bview.elementType==3||bview.elementType==4||bview.elementType==5||bview.elementType==6)
        {
            //图片 表格 线条 矩形 logo
            cell2=[tb cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        }
        
        if(cell2==nil) return;
        
        for(int i=0;i<cell2.xBtn.itemTitles.count;i++)
        {
            if(cell2.xBtn.itemTitles[i].floatValue==[bview getXMM])
            {
                cell2.xBtn.curentIndex=i;
                break;
            }
        }
        for(int i=0;i<cell2.yBtn.itemTitles.count;i++)
        {
            if(cell2.yBtn.itemTitles[i].floatValue==[bview getYMM])
            {
                cell2.yBtn.curentIndex=i;
                break;
            }
        }
        for(int i=0;i<cell2.widthBtn.itemTitles.count;i++)
        {
            if(cell2.widthBtn.itemTitles[i].floatValue==[bview getWidthMM])
            {
                cell2.widthBtn.curentIndex=i;
                break;
            }
        }
        for(int i=0;i<cell2.heightBtn.itemTitles.count;i++)
        {
            if(cell2.heightBtn.itemTitles[i].floatValue==[bview getHeightMM])
            {
                cell2.heightBtn.curentIndex=i;
                break;
            }
        }
    };
}
@end
