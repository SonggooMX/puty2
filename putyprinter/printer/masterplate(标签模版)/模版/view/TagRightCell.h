//
//  TagRightCell.h
//  TianJinDL
//
//  Created by apple on 17/8/14.
//  Copyright © 2017年 troilamac. All rights reserved.
//

#import "JSONModelLib.h"
#import "SpecificUseModel.h"
#import "YunTempleteModel.h"
@interface TagRightCell : UITableViewCell
@property (nonatomic,strong)UIButton *delete;
@property (nonatomic,strong)UIButton *share;
-(void)setSpecificData:(SpecificUseListModel *)model;
-(void)setYunData:(YunTempleteModel *)model;
@end
