//
//  EFSliderCell.m
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import "EFSliderCell.h"

@implementation EFSliderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}




- (IBAction)slideChange:(UISlider *)sender {
    
    if (self.valueBlock) {
        self.valueBlock(sender.value);
    }
    
}

@end
