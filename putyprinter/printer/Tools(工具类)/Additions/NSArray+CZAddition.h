//
//  NSArray+CZAddition.h
//  printer
//
//  Created by 周宏全 on 2017/7/17.
//  Copyright © 2017年 puty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (CZAddition)

/// 从 plist 文件创建指定 clsName 对象数组
///
/// @param plistName plist 文件名
/// @param clsName   要创建模型的类名
///
/// @return clsName 的对象数组
+ (NSArray *)cz_objectListWithPlistName:(NSString *)plistName clsName:(NSString *)clsName;

@end
