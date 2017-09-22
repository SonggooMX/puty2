//
//  TextAttAcceryCell.m
//  ceshi
//
//  Created by  on 2017/7/26.
//  Copyright © 2017年 . All rights reserved.
//

#import "TextAttAcceryCell.h"
#import "UILabel+CZAddition.h"
#import "UIButton+CZAddition.h"
#import "UIColor+CZAddition.h"
#import "UIImage+Extension.h"

@implementation TextAttAcceryCell

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
    
    
    self.rightLabel = [UILabel cz_labelWithText:@"" fontSize:14 color:[UIColor blackColor]];
    [self.contentView addSubview:self.rightLabel];
    
    UILabel* acceryLabel = [UILabel cz_labelWithText:@">" fontSize:14 color:[UIColor blackColor]];
    [self.contentView addSubview:acceryLabel];
    [acceryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.right.offset(-20);
    }];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.right.equalTo(acceryLabel.mas_left).offset(-5);
    }];
}

@end
