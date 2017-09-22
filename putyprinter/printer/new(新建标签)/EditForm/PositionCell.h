//
//  PositionCell.h
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EFBaseCell.h"
#import "EFPickButton.h"

@interface PositionCell : EFBaseCell

@property (weak, nonatomic) IBOutlet EFPickButton *xBtn;

@property (weak, nonatomic) IBOutlet EFPickButton *widthBtn;
@property (weak, nonatomic) IBOutlet EFPickButton *yBtn;
@property (weak, nonatomic) IBOutlet EFPickButton *heightBtn;

@property (nonatomic,strong)NSString *unit;// 单位 如mm

@property (nonatomic,copy)void(^xchangeActin)(NSString *result,NSInteger index);
@property (nonatomic,copy)void(^ychangeActin)(NSString *result,NSInteger index);
@property (nonatomic,copy)void(^widthchangeActin)(NSString *result,NSInteger index);
@property (nonatomic,copy)void(^heightchangeActin)(NSString *result,NSInteger index);


@end
