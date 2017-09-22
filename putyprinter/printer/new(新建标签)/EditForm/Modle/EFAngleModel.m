//
//  EFAngleModel.m
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import "EFAngleModel.h"
#import "FontAngleCell.h"


@implementation EFAngleModel


+ (NSString *)cellId
{
    // subclass must overrid it
    return NSStringFromClass([FontAngleCell class]);
}

- (void)setupWithCell:(EFBaseCell *)cell
{
    FontAngleCell *rcell = cell;
    rcell.seletedIndex = self.seletedIndex;
    rcell.selectedAcction = ^(NSInteger index) {
        self.seletedIndex = index;
        if (self.selectedAcction) {
            self.selectedAcction(index);
        }
    };
}
@end
