//
//  NetworkManager.h
//  TianJinDL
//
//  Copyright © 2017年 troilamac. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NetworkManager : NSObject
@property (nonatomic,assign)AFNetworkReachabilityStatus *networkReachabilityStatus;//网络状态
+(NetworkManager *)sharedInstance;
-(NSURLSessionDataTask *)HttpRequestWithType:(NSString *)type withURLString:(NSString *)urlString withParaments:(id)paraments  progress:(void(^)(NSProgress *progress))progress withCompleteBlock:(void(^)(NSError *error,id data))completeBlock;
//下载任务
-(NSURLSessionTask *)downLoadFileWithProgress:(void(^)(NSProgress *progress))progress url:(NSString  *)url completeBlock:(void(^)(NSError *error,NSURL *filePaht))completeBlock;
//上传任务
-(NSURLSessionTask *)uploadFileWithUrl:(NSString *)url filePath:(NSString *)path parameters:(NSDictionary *)parameter completeBlock:(void(^)(NSError *error,id data))completeBlock progress:(void(^)(NSProgress *progress))progress;
@end
