//
//  EFMuiltiBtnModle.m
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import "EFMuiltiBtnModle.h"
#import "EFMuiltiButtonCell.h"


@implementation EFMuiltiBtnModle


+ (NSString *)cellId
{
    return NSStringFromClass([EFMuiltiButtonCell class]);
}

- (ButtonModle *)currentModle
{
    return self.itemStrs[self.currentindex];
}

- (void)setupWithCell:(EFBaseCell *)cell
{
    EFMuiltiButtonCell *rcell = cell;
    rcell.selectedAction = ^(NSInteger result) {
        self.currentindex = result;
        if (self.selectedAction) {
            self.selectedAction(result);
        }
    };
    rcell.itemStrs = self.itemStrs;
    rcell.titleLable.text = self.title;
    rcell.currentindex = self.currentindex;
}

@end
