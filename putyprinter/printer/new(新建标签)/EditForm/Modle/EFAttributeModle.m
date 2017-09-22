//
//  EFAttributeModle.m
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import "EFAttributeModle.h"
#import "EFAttributeCell.h"

@implementation EFAttributeModle


+ (NSString *)cellId
{
    // subclass must overrid it
    return NSStringFromClass([EFAttributeCell class]);
}

- (void)setupWithCell:(EFBaseCell *)cell
{
     EFAttributeCell *rcell = cell;
    rcell.selectedAction = ^(NSInteger index) {
        self.currentIndex = index;
        if (self.selectedAction) {
            self.selectedAction(index);
        }
    };
    rcell.currentIndex = self.currentIndex;
    
}

@end
