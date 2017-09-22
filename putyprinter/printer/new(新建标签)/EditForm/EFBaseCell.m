//
//  EFBaseCell.m
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import "EFBaseCell.h"

@implementation EFBaseCell


//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{}

+ (instancetype)cellWithType:(EFCellType)type tableView:(UITableView *)tableView
{
    NSString *cellid = [EFBaseModle cellIdWithType:type];
    EFBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:cellid owner:nil options:nil].firstObject;
        if (cell == nil) {
            cell = [[NSClassFromString(cellid) alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
        }
    }
    return cell;
}

@end
