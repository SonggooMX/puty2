
//
//  RightTableCell.m
//  TianJinDL
//
//  Created by 王娜 on 2017/8/14.
//  Copyright © 2017年 troilamac. All rights reserved.
//

#import "RightTableCell.h"
#import "TianJinDLConfig.h"
#import "TianJinDLApi.h"

@implementation RightTableCell
{
    UIImageView *img;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        img = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-130)/2-30, 15, 60, 60)];
        img.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:img];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
-(void)resetData:(LogoImageModel *)model{
 //[img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://119.23.125.153:8000/puty/%@",model.image]] placeholderImage:[UIImage imageNamed:@"save_button_n"]];
}
@end
