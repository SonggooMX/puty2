//
//  MeLoginTool.h
//  TianJinDL
//
//  Created by 王娜 on 2017/8/16.
//  Copyright © 2017年 troilamac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageModel.h"

@interface MeLoginTool : NSObject
//存储登陆信息
+(void)saveLoginInfo:(MessageModel *)login;
+(NSString *)getUserName;
+(NSString *)getCheckCode;
+(NSString *)getPwd;
+(BOOL)isAutoLogin;
+(BOOL)isLogin;
@end
