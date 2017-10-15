//
//  EFSwitchModel.m
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import "EFSwitchModel.h"
#import "EFSwitchCell.h"
#import "lbView.h"
#import "imgView.h"
#import "EFSliderCell.h"
#import "rectView.h"

@implementation EFSwitchModel

+ (NSString *)cellId
{
    // subclass must overrid it
    return NSStringFromClass([EFSwitchCell class]);
}

- (void)setupWithCell:(EFBaseCell *)cell withBaseView:(baseView*)bview withNewLabel:(newLabel *)linfo withTB:(UITableView *)tb
{
    EFSwitchCell *rcell = (EFSwitchCell*)cell;
    rcell.titleLable.text = self.title;
    rcell.valueBlock = ^(BOOL value) {
        
        if([self.title isEqualToString:@"参与打印"])
        {
            bview.isPrint=value==YES?1:0;
        }
        else if([self.title isEqualToString:@"是否锁定"])
        {
            linfo.parent.CURRENT_LABEL_INFO.isLock=value;
        }
        else if([self.title isEqualToString:@"自动换行"])
        {
            lbView *lv=(lbView*)bview;
            [lv setWarp:value==YES?1:0];
        }
        else if([self.title isEqualToString:@"黑白显示"])
        {
            EFSliderCell *cell2=[tb cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            cell2.slider.enabled=value;

            imgView *iv=(imgView*)bview;
            iv.grayValue=cell2.slider.value=0.5;
            iv.isBlack=value;
            [iv resetViewWH:bview.frame.size];
        }
        else if([self.title isEqualToString:@"图片缩放"])
        {
            imgView *iv=(imgView*)bview;
            iv.isScale=value;
            [iv resetViewWH:bview.frame.size];
        }
        else if([self.title isEqualToString:@"内部填充"])
        {
            rectView *rv=(rectView*)bview;
            rv.fillRect=value?1:0;
            [rv resetViewWH:rv.frame.size];
        }
        
        self.on = value;
        if (self.valueBlock) {
            self.valueBlock(value);
        }
    };
    rcell.on = self.on;
}

@end
