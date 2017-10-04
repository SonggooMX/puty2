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

@implementation EFSwitchModel

+ (NSString *)cellId
{
    // subclass must overrid it
    return NSStringFromClass([EFSwitchCell class]);
}

- (void)setupWithCell:(EFBaseCell *)cell withBaseView:(baseView*)bview withNewLabel:(newLabel *)linfo
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
            linfo.isLock=value;
        }
        else if([self.title isEqualToString:@"自动换行"])
        {
            lbView *lv=(lbView*)bview;
            [lv setWarp:value==YES?1:0];
        }
        
        self.on = value;
        if (self.valueBlock) {
            self.valueBlock(value);
        }
    };
    rcell.on = self.on;
}

@end
