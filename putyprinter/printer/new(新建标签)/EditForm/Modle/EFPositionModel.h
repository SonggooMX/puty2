//
//  EFPositionModel.h
//  EdictForm
//
//  Created by 韦超才 on 2017/8/12.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EFBaseModle.h"
@interface EFPositionModel : EFBaseModle
{
    NSString *_x;
    NSString *_y;
    NSString *_width;
    NSString *_height;
}

@property (nonatomic,strong)NSString *x;
@property (nonatomic,strong)NSString *y;
@property (nonatomic,strong)NSString *width;
@property (nonatomic,strong)NSString *height;

@property (nonatomic,strong)NSArray *itemsArr;

@property (nonatomic,assign)NSInteger xindex;
@property (nonatomic,assign)NSInteger yindex;
@property (nonatomic,assign)NSInteger windex;
@property (nonatomic,assign)NSInteger hindex;

@property (nonatomic,strong)NSString *unit;// 单位 如mm

@end
