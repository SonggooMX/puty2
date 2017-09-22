//
//  EFToolBar.m
//  EdictForm
//
//  Created by 韦超才 on 2017/8/10.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import "EFToolBar.h"



#define kheightBlue    [UIColor colorWithRed:0 green:124/255.0 blue:224/255.0 alpha:1.0]
#define kdarkBlue      [UIColor colorWithRed:68/255.0 green:155/255.0 blue:227/255.0 alpha:1.0]

@implementation EFToolBar


- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    
    for (UIButton *btn in self.subviews) {
        [self setupBtn:btn isSelected:btn.tag == currentIndex];
    }
    
}


+ (instancetype)instance
{
    
    return [[NSBundle mainBundle] loadNibNamed:@"EFToolBar" owner:nil options:nil].firstObject;
    
}

- (void)setupBtn:(UIButton *)btn  isSelected:(BOOL)isSelected
{
    btn.backgroundColor = isSelected   ?  kheightBlue : kdarkBlue;
}


- (IBAction)btnClick:(UIButton *)sender {
    self.currentIndex = sender.tag;
    if (self.selectedAction) {
        self.selectedAction(sender.tag);
    }
    
}




@end
