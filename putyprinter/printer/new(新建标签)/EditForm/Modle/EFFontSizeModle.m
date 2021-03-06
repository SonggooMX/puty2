//
//  EFFontSizeModle.m
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import "EFFontSizeModle.h"
#import "EFFontSizeCell.h"
#import "lineView.h"

@implementation EFFontSizeModle

+ (NSString *)cellId
{
    // subclass must overrid it
    return NSStringFromClass([EFFontSizeCell class]);
}

- (void)setupWithCell:(EFBaseCell *)cell withBaseView:(baseView*)bview withNewLabel:(newLabel *)linfo withTB:(UITableView *)tb
{
    EFFontSizeCell *rcell =(EFFontSizeCell*) cell;
    rcell.titleLable.text = self.title;
    rcell.itemTitles = self.itemTitles;
    rcell.changeActin = ^(NSString *result,NSInteger index) {
        
        if([self.title isEqualToString:@"打印浓度"])
        {
            linfo.parent.CURRENT_LABEL_INFO.printDes=result.intValue;
        }
        else if([self.title isEqualToString:@"打印速度"])
        {
            linfo.parent.CURRENT_LABEL_INFO.printSpeed=result.intValue;
        }
        else if([self.title isEqualToString:@"水平打印偏移量"])
        {
            linfo.parent.CURRENT_LABEL_INFO.printHpadding=result.floatValue;
        }
        else if([self.title isEqualToString:@"垂直打印偏移量"])
        {
            linfo.parent.CURRENT_LABEL_INFO.printVpadding=result.floatValue;
        }
        else if([self.title isEqualToString:@"行数"])
        {
            tableView *tv=(tableView*)bview;
            tv.rows=result.intValue;
            [tv resetViewWH:bview.frame.size];
        }
        else if([self.title isEqualToString:@"列数"])
        {
            tableView *tv=(tableView*)bview;
            tv.cols=result.intValue;
            [tv resetViewWH:bview.frame.size];
        }
        else if([self.title isEqualToString:@"线条宽度"])
        {
            tableView *tv=(tableView*)bview;
            tv.lineWidth=result.floatValue;
            [tv resetViewWH:bview.frame.size];
        }
        else if([self.title isEqualToString:@"字符间距"])
        {
            lbView *lb=(lbView*)bview;
            lb.charSpaceWidth=result.floatValue;
            [lb setLineSpace:lb.rowSpaceHeight withMode:lb.rowSpaceMode];
        }
        else if([self.title isEqualToString:@"字体大小"])
        {
            int seq=(int)index;
            seq=seq>=17?0:seq;
            seq=seq<=-1?16:seq;
            bview.fontSizeIndex=seq;
            
            [bview resetViewWH:bview.frame.size];
        }
        else if([self.title isEqualToString:@"虚线间隔"])
        {
            lineView *lv=(lineView*)bview;
            lv.lineSpace=(int)index;
            [lv resetViewWH:lv.frame.size];
        }
        _result = result;
        self.curentIndex = index;
        if (self.changeActin) {
            self.changeActin(result);
        }
    };
    rcell.curentIndex = self.curentIndex;
}

@end
