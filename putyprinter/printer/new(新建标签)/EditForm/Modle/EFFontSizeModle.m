//
//  EFFontSizeModle.m
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import "EFFontSizeModle.h"
#import "EFFontSizeCell.h"
@implementation EFFontSizeModle

+ (NSString *)cellId
{
    // subclass must overrid it
    return NSStringFromClass([EFFontSizeCell class]);
}

- (void)setupWithCell:(EFBaseCell *)cell withBaseView:(baseView*)bview
{
    EFFontSizeCell *rcell =(EFFontSizeCell*) cell;
    rcell.titleLable.text = self.title;
    rcell.itemTitles = self.itemTitles;
    rcell.changeActin = ^(NSString *result,NSInteger index) {
        _result = result;
        self.curentIndex = index;
        if (self.changeActin) {
            self.changeActin(result);
        }
    };
    rcell.curentIndex = self.curentIndex;
}

@end
