//
//  TextSectionSwitchCell.m
//  ceshi
//
//  Created by  on 2017/7/26.
//  Copyright © 2017年 . All rights reserved.
//

#import "TextSectionSwitchCell.h"
#import "UILabel+CZAddition.h"
#import "UIColor+CZAddition.h"

@implementation TextSectionSwitchCell

- (void)awakeFromNib {
    [super awakeFromNib];
     [self setupUI];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
   self.titleLabel = [UILabel cz_labelWithText:@"" fontSize:14 color:[UIColor blackColor]];
    [self.contentView addSubview:self.titleLabel ];
    [self.titleLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.offset(15);
    }];
    
    self.switchView = [UISwitch new];
    self.switchView .onTintColor = [UIColor cz_colorWithHex:0x0b64db];
    self.switchView.transform = CGAffineTransformMakeScale(1.1, 1);
    [self.contentView addSubview:self.switchView ];
    [self.switchView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.right.offset(-20);
    }];
}
@end
