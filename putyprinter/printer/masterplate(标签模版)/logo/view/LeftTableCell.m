//
//  LeftTableCell.m
//  TianJinDL
//
//  Created by 王娜 on 2017/8/14.
//  Copyright © 2017年 troilamac. All rights reserved.
//

#import "LeftTableCell.h"

@implementation LeftTableCell
{
    UILabel *titleLab;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        titleLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 90, 44)];
        titleLab.textAlignment = NSTextAlignmentLeft;
        [titleLab setFont:[UIFont systemFontOfSize:14]];
         [self.contentView addSubview:titleLab];
        self.clipsToBounds = YES;
    }
    return self;
}
-(void)resetData:(LogoTypeListModel *)model{
    titleLab.text = [NSString stringWithFormat:@"%@(%ld)",model.name,model.imgArr.count];
}
@end
