//
//  EFAttributeCell.m
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import "EFAttributeCell.h"

@implementation EFAttributeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    [self setupBtnWithIndex:currentIndex];
}

- (void)setupBtnWithIndex:(NSInteger)index
{
    for (UIView *view  in self.contentView.subviews) {
        for (UIButton *btn in view.subviews) {
            if ([btn isKindOfClass:[UIButton class]]) {
                btn.selected = btn.tag == index;
            }
        }
    }
}

- (IBAction)btnAction:(UIButton *)sender {
    
    self.currentIndex = sender.tag;
    self.selectedAction(self.currentIndex);
}


@end
