//
//  ZXFontTableViewCell.m
//  printer
//
//  Created by  on 2017/8/9.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "ZXFontTableViewCell.h"
#import "ZXFontModel.h"
@interface ZXFontTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *fontLabel;

@end
@implementation ZXFontTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFontModel:(ZXFontModel *)fontModel{
    _fontModel = fontModel;
    _fontLabel.text = fontModel.name;
}
@end
