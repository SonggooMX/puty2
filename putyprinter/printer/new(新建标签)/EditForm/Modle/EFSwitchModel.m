//
//  EFSwitchModel.m
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import "EFSwitchModel.h"
#import "EFSwitchCell.h"
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
        self.on = value;
        if (self.valueBlock) {
            self.valueBlock(value);
        }
    };
    rcell.on = self.on;
}

@end
