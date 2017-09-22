//
//  SSHttpManager.m
//  printer
//
//  Created by  on 2017/8/8.
//  Copyright © 2017年 puty. All rights reserved.
//

#import "SSHttpManager.h"

@implementation SSHttpManager:AFHTTPSessionManager
/**
 自定义网络单例
 
 @return DNSHttpTools
 */
+ (instancetype) sharedManager {
    static SSHttpManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //baseUrl
        manager = [[SSHttpManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://119.23.125.153:8000"]];
        
        //超时时间
        manager.requestSerializer.timeoutInterval = 30;
        //网络请求解析类型
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html",@"image/jpeg", @"image/png", nil];
        
        AFSecurityPolicy* securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        [securityPolicy setValidatesDomainName:NO];
        manager.securityPolicy = securityPolicy;
    });
    
    return manager;
}



/**
 清除所有网络请求
 */
- (void)cancelAllOperations{
    [self.operationQueue cancelAllOperations];
}
/**
 网络中间层,请求文本
 @param url url字符串
 @param method 请求方式
 @param parameters 请求参数的字典
 @param callBack 完成回调
 */
- (void) reqeustWith: (NSString *)url
              method: (RequestType )method
          parameters: (NSDictionary *) parameters
            callBack: (void(^)(id response)) callBack {

    // [JHHJView backgroudColor:[UIColor colorWithWhite:0.3 alpha:0.5]];
    //调用AFN发起GET请求
    if (method == RequestGET) {
        [self GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          
            callBack(responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            // [MBProgressHUD showOnlyMessage:@"获取数据失败或超时"];
       
            callBack(nil);
        }];
    }
    
    //调用AFN发起post请求
    if (method == RequestPOST) {
        [self POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            callBack(responseObject);
    
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            // [MBProgressHUD showOnlyMessage:@"获取数据失败或超时"];
            callBack(nil);
        }];
    }
}

@end
