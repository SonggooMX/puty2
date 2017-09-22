//
//  EdictBoxView.m
//  EdictForm
//
//  Created by 韦超才 on 2017/8/10.
//  Copyright © 2017年 韦超才. All rights reserved.
//

#import "EdictBoxView.h"

@implementation EdictBoxView

+ (instancetype)instance
{
    return [[NSBundle mainBundle] loadNibNamed:@"EdictBoxView" owner:nil options:nil].firstObject;
}

@end
