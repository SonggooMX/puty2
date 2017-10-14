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
    int seq=0;
    for (UIView *view  in self.contentView.subviews) {
        for (UIButton *btn in view.subviews) {
            if ([btn isKindOfClass:[UIButton class]]) {
                //btn.selected = btn.tag == index;
                //btn.selected=self.state==1;
                if(seq==0)
                {
                    btn.selected=self.baseV.fontBlod==1;
                }
                else if(seq==1)
                {
                    btn.selected=self.baseV.fontItalic==1;
                }
                else if(seq==2)
                {
                    btn.selected=self.baseV.fontUnderline==1;
                }
                else{
                    btn.selected=self.baseV.fontDeleteline==1;
                }
                seq++;
            }
        }
    }
}

- (IBAction)btnAction:(UIButton *)sender {
    
    switch (sender.tag) {
        case 1:
            self.baseV.fontItalic=self.baseV.fontItalic==1?0:1;
            break;
        case 2:
            self.baseV.fontUnderline=self.baseV.fontUnderline==1?0:1;
            break;
        case 3:
            self.baseV.fontDeleteline=self.baseV.fontDeleteline==1?0:1;
            break;
        default:
            self.baseV.fontBlod=self.baseV.fontBlod==1?0:1;
            break;
    }
    [self.baseV resetViewWH:self.baseV.frame.size];
    self.currentIndex = sender.tag;
    self.selectedAction(self.currentIndex);
}


@end
