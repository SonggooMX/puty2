//
//  EFFontSizeModle.h
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EFBaseModle.h"
#import "tableView.h"

@interface EFFontSizeModle : EFBaseModle


@property (nonatomic,copy)void(^changeActin)(NSString *result);


@property (nonatomic,strong)NSArray <NSString *>*itemTitles;

@property (nonatomic,strong)NSString *unit;// 单位 如mm

@property (nonatomic,assign)NSInteger curentIndex;

@property (nonatomic,strong,readonly)NSString *result;

@end
