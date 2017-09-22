//
//  EFFontSizeCell.h
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EFPickButton.h"
#import "EFBaseCell.h"
@interface EFFontSizeCell : EFBaseCell


@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet EFPickButton *pickBtn;

@property (nonatomic,copy)void(^changeActin)(NSString *result,NSInteger index);


@property (nonatomic,strong)NSArray <NSString *>*itemTitles;

@property (nonatomic,strong)NSString *unit;// 单位 如mm

@property (nonatomic,assign)NSInteger curentIndex;

@property (nonatomic,strong,readonly)NSString *result;

@end
