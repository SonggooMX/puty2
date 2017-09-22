//
//  EFBaseCell.h
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EFBaseModle.h"
#import "EFBaseCell.h"

@interface EFBaseCell : UITableViewCell

@property (nonatomic,strong)EFBaseModle *modle;

+ (instancetype)cellWithType:(EFCellType)type tableView:(UITableView *)tableView;

@end
