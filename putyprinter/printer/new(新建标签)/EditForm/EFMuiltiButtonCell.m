//
//  EFMuiltiButtonCell.m
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import "EFMuiltiButtonCell.h"

@implementation EFMuiltiButtonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.muiltiBtnView.selectedAction = self.selectedAction;
}

- (void)setSelectedAction:(void (^)(NSInteger))selectedAction
{
    self.muiltiBtnView.selectedAction = selectedAction;
}

- (void)setCurrentindex:(NSInteger)currentindex
{
    self.muiltiBtnView.currentindex = currentindex;
}

- (ButtonModle *)currentModle
{
    return self.muiltiBtnView.currentModle;
}

- (void)setItemStrs:(NSArray<ButtonModle *> *)itemStrs
{
    _itemStrs = itemStrs;
    self.muiltiBtnView.itemStrs = itemStrs;
}

- (UILabel *)subTitleLable
{
    
    return nil;
}

@end
