//
//  ButtonCell.m
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import "ButtonCell.h"

@implementation ButtonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.firBtn.layer.cornerRadius=5;
    self.secBtn.layer.cornerRadius=5;
}

- (IBAction)firAction:(id)sender {
}

- (IBAction)secAction:(id)sender {
}



@end
