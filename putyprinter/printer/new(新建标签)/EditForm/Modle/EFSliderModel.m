//
//  EFSliderModel.m
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import "EFSliderModel.h"
#import "EFSliderCell.h"
#import "imgView.h"

@implementation EFSliderModel

+ (NSString *)cellId
{
    // subclass must overrid it
    return NSStringFromClass([EFSliderCell class]);
}

- (void)setupWithCell:(EFBaseCell *)cell withBaseView:(baseView*)bview withNewLabel:(newLabel *)linfo withTB:(UITableView *)tb
{
    imgView *iv=(imgView*)bview;
    
    EFSliderCell *rcell = (EFSliderCell*)cell;
    rcell.valueBlock = ^(CGFloat value) {
        if(iv.isBlack)
        {
            iv.grayValue=value;
            [iv resetViewWH:iv.frame.size];
        }
    };
    rcell.title.text = self.title;
    if(iv!=nil)
    {
        rcell.slider.enabled=iv.isBlack;
        rcell.slider.value=iv.grayValue;
        [iv resetViewWH:iv.frame.size];
    }
}


@end
