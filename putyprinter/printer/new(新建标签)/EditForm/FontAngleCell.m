//
//  FontAngleCell.m
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import "FontAngleCell.h"

#define kheightBlue    [UIColor colorWithRed:0 green:124/255.0 blue:224/255.0 alpha:1.0]
#define kdarkBlue      [UIColor colorWithRed:68/255.0 green:155/255.0 blue:227/255.0 alpha:1.0]

@implementation FontAngleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor whiteColor];
}
- (IBAction)tapAction:(UITapGestureRecognizer *)sender {
    self.seletedIndex = sender.view.tag;
    self.selectedAcction(sender.view.tag);
}

- (IBAction)btnClick:(id)sender {
    UIButton *btn=(UIButton*)sender;
    self.seletedIndex = btn.tag;
    self.selectedAcction(btn.tag);
}


-(void) rate
{
    
}

- (void)setSeletedIndex:(NSInteger)seletedIndex
{
    _seletedIndex = seletedIndex;
    for( UIView *view in self.contentView.subviews){
        [self setupWithView:view isSelected:view.tag == seletedIndex];
    }
}

- (void)setupWithView:(UIView *)view isSelected:(BOOL)isSelected
{
    if (isSelected) {
        view.backgroundColor = kheightBlue;
    }else{
        view.backgroundColor = [UIColor whiteColor];
    }
}



@end
