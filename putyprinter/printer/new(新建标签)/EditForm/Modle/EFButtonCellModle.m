//
//  EFButtonCellModle.m
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import "EFButtonCellModle.h"
#import "ButtonCell.h"

@implementation EFButtonCellModle

+ (NSString *)cellId
{
    // subclass must overrid it
    return NSStringFromClass([ButtonCell class]);
}

- (void)setupWithCell:(EFBaseCell *)cell withBaseView:(baseView*)bview withNewLabel:(newLabel *)linfo withTB:(UITableView *)tb
{
    ButtonCell *rcell = (ButtonCell*)cell;
    [rcell.firBtn setTitle:self.titles.firstObject forState:(UIControlStateNormal)];
    [rcell.secBtn setTitle:self.titles.lastObject forState:(UIControlStateNormal)];
}

@end
