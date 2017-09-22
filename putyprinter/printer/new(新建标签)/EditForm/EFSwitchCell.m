//
//  EFSwitchCell.m
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import "EFSwitchCell.h"

@implementation EFSwitchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setOn:(BOOL)on
{
    _on = on;
    self.mSwitch.on = on;
}

- (IBAction)switchChange:(UISwitch *)sender {
    if (self.valueBlock) {
        self.valueBlock(sender.isOn);
    }
}


@end
