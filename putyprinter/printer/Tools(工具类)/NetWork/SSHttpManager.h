//
//  SSHttpManager.h
//  printer
//
//  Created by  on 2017/8/8.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface SSHttpManager : AFHTTPSessionManager
typedef enum RequestType {
    RequestGET   = 0,
    RequestPOST
} RequestType;
#define KhttpManager [SSHttpManager sharedManager]

/**
 工厂方法
 
 @return DNSHttpTools
 */
+ (instancetype) sharedManager;

/**
 清除所有网络请求
 */
- (void)cancelAllOperations;

/**
 网络中间层,普通请求
 @param url url字符串
 @param method 请求方式
 @param parameters 请求参数的字典
 @param callBack 完成回调
 */
- (void) reqeustWith: (NSString *)url
              method: (RequestType )method
          parameters: (NSDictionary *) parameters
            callBack: (void(^)(id response)) callBack;

@end
