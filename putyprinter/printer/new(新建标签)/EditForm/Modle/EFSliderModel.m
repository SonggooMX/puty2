//
//  EFSliderModel.m
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import "EFSliderModel.h"
#import "EFSliderCell.h"
@implementation EFSliderModel

+ (NSString *)cellId
{
    // subclass must overrid it
    return NSStringFromClass([EFSliderCell class]);
}

- (void)setupWithCell:(EFBaseCell *)cell withBaseView:(baseView*)bview withNewLabel:(newLabel *)linfo
{
     EFSliderCell *rcell = (EFSliderCell*)cell;
    rcell.title.text = self.title;
    
    
}


@end
