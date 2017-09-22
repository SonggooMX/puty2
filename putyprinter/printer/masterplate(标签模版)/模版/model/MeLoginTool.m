//
//  MeLoginTool.m
//  TianJinDL
//
//  Created by 王娜 on 2017/8/16.
//  Copyright © 2017年 troilamac. All rights reserved.
//

#import "MeLoginTool.h"
@implementation MeLoginTool
+(void)saveLoginInfo:(MessageModel *)login{
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [doc stringByAppendingPathComponent:@"login.data"];
    [NSKeyedArchiver archiveRootObject:login toFile:path];
}
+(NSString *)getUserName{
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [doc stringByAppendingPathComponent:@"login.data"];
    MessageModel *login = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return login.username;
}
+(NSString *)getCheckCode{
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [doc stringByAppendingPathComponent:@"login.data"];
    MessageModel *login = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return  login.msg;
}
+(NSString *)getPwd{
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [doc stringByAppendingPathComponent:@"login.data"];
    MessageModel *login =[NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return login.password;
}
+(BOOL)isAutoLogin{
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [doc stringByAppendingPathComponent:@"login.data"];
    MessageModel *login =[NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return login.autoLogin;

}
+(BOOL)isLogin{
    NSString *checkcode = [self getCheckCode];
    return checkcode.length;
}

@end
