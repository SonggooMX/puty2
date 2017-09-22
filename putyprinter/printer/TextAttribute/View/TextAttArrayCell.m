//
//  TextAttArrayCell.m
//  ceshi
//
//  Created by  on 2017/7/26.
//  Copyright © 2017年 . All rights reserved.
//

#import "TextAttArrayCell.h"
#import "UILabel+CZAddition.h"
#import "UIButton+CZAddition.h"
#import "UIColor+CZAddition.h"
#import "UIImage+Extension.h"

@implementation TextAttArrayCell
#define kScreenBounds [UIScreen mainScreen].bounds
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
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
    
   
}
- (void)setTagArray:(NSArray *)tagArray{
    _tagArray = tagArray;
    NSInteger rowCount = self.tagArray.count;
    CGFloat tagWidth = (kScreenWidth - 125 - (rowCount - 1) * 5) / rowCount;
    for (NSInteger i = 0;i < rowCount;i ++) {
        UIButton* tagButton  = [UIButton cz_textButton:self.tagArray[i] fontSize:12 normalColor:[UIColor blackColor] selectedColor:[UIColor whiteColor]];
        tagButton.backgroundColor = [UIColor whiteColor];
        tagButton.layer.borderWidth = 1;
        tagButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        tagButton.layer.cornerRadius = 5;
        tagButton.layer.masksToBounds = YES;
        tagButton.frame = CGRectMake(105 + (tagWidth + 5) * i, 6, tagWidth, 30);
        [self.contentView addSubview:tagButton];
        if (i == 0) {
            tagButton.selected = YES;
            tagButton.backgroundColor = [UIColor cz_colorWithHex:0x0b64db];
        }
    }
}


@end
