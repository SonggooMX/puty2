//
//  PickViewModle.m
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import "PickViewModle.h"
#import "EFPickCell.h"

@implementation PickViewModle


+ (NSString *)cellId
{
    // subclass must overrid it
    return NSStringFromClass([EFPickCell class]);
}

- (EFCellType)type
{
    if ([super type] != EFCellTypePickView) {
        [super setType:EFCellTypePickView];
    }
    
    return [super type];
}

- (void (^)())selectedAction
{
    if (super.selectedAction == nil) {
        [super setSelectedAction:^{
            
        }];
    }
    return [super selectedAction];
}

- (void)setupWithCell:(EFBaseCell *)cell withBaseView:(baseView*)bview
{
    EFPickCell *rcell = (EFPickCell*)cell;
    rcell.bv=bview;
    rcell.titleLable.text = self.title;
    rcell.subTitleLable.text = self.subTitle;
    rcell.showPickView = self.showPickView;
}

@end
