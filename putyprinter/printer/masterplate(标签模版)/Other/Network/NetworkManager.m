//
//  NetworkManager.m
//  TianJinDL
//
//  Copyright © 2017年 troilamac. All rights reserved.
//
/*
 内存中只有一个实例，减少了内存的开支
 
 
 */
#import "NetworkManager.h"
@implementation NetworkManager
+(NetworkManager *)sharedInstance
{
    static NetworkManager *manager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[NetworkManager alloc]init];
    });
    return manager;
}
//POST  GET 请求
-(NSURLSessionDataTask *)HttpRequestWithType:(NSString *)type withURLString:(NSString *)urlString withParaments:(id)paraments progress:(void (^)(NSProgress *))progress withCompleteBlock:(void (^)(NSError *, id))completeBlock
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:configuration];
    manager.securityPolicy.allowInvalidCertificates = YES;
    NSError *error;
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:type URLString:urlString parameters:paraments error:&error];
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    response.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",@"text/html", nil];
    manager.responseSerializer = response;
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        completeBlock(error,responseObject);
    }];
    [dataTask resume];
    return dataTask;
    
}
//下载任务
-(NSURLSessionDownloadTask *)downLoadFileWithProgress:(void (^)(NSProgress *))progress url:(NSString *)url completeBlock:(void (^)(NSError *, NSURL *))completeBlock
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:configuration];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
//        progress(downloadProgress);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSURL *documentDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        completeBlock(error,filePath);
    }];
    [downloadTask resume];
    return downloadTask;
}
//上传
-(NSURLSessionTask *)uploadFileWithUrl:(NSString *)url filePath:(NSString *)path parameters:(NSDictionary *)parameter completeBlock:(void (^)(NSError *, id))completeBlock progress:(void (^)(NSProgress *))progress
{
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:path] name:@"file" error:nil];
    } error:nil];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    AFHTTPResponseSerializer *response = [AFHTTPResponseSerializer serializer];
    response.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"audio/mpeg",@"text/plain",@"application/zip",@"audio/x-aac",@"application/json",@"text/xml",@"image/png",@"image/jpg",@"image/jpeg",@"image/gif", nil];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.responseSerializer = response;
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:progress completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        completeBlock(error,responseObject);
    }];
    [uploadTask resume];
    return uploadTask;
}
@end
