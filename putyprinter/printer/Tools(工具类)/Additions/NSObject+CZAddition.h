//
//  NSObject+CZAddition.h
//  printer
//
//  Created by 周宏全 on 2017/7/17.
//  Copyright © 2017年 puty. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface NSObject (CZAddition)

/// 使用字典创建模型对象
///
/// @param dict 字典
///
/// @return 模型对象
+ (instancetype)cz_objectWithDict:(NSDictionary *)dict;

@end
