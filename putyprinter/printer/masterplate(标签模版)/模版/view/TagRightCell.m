


//
//  TagRightCell.m
//  TianJinDL
//
//  Created by apple on 17/8/14.
//  Copyright © 2017年 troilamac. All rights reserved.
//

#import "TagRightCell.h"
#import "NetworkManager.h"
#import "TianJinDLConfig.h"

@implementation TagRightCell
{
    UIImageView *templeteImg;
    UILabel *markLab;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _delete = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-175, 15, 25, 25)];
        [_delete setBackgroundImage:[UIImage imageNamed:@"delete_button_blue"] forState:UIControlStateNormal];
        [self.contentView addSubview:_delete];
        _share = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-175, 58, 25, 25)];
        [_share setBackgroundImage:[UIImage imageNamed:@"share_buton_blue"] forState:UIControlStateNormal];
        [self.contentView addSubview:_share];
        templeteImg = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, SCREEN_WIDTH-227, 40)];
        [self.contentView addSubview:templeteImg];
        templeteImg.contentMode = UIViewContentModeScaleAspectFit;
        markLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 70, SCREEN_WIDTH-215, 15)];
        [markLab setTextColor:[UIColor darkGrayColor]];
        [markLab setTextAlignment:NSTextAlignmentCenter];
        [markLab setFont:[UIFont systemFontOfSize:13]];
        [self.contentView addSubview:markLab];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}
-(void)setSpecificData:(SpecificUseListModel *)model{
    //[templeteImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://119.23.125.153:8000/puty/%@",model.image]]];
    [markLab setText:model.name];
}
-(void)setYunData:(YunTempleteModel *)model{
    //[templeteImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://119.23.125.153:8000/puty/%@",model.image]]];
    [markLab setText:model.name];
}
@end
