//
//  HttpManager.m
//  Umbrella
//
//  Created by huangrensheng on 16/9/28.
//  Copyright © 2016年 umbrella. All rights reserved.
//

#import "HttpManager.h"

#define baseUrl @"http://121.43.158.118:8080/kobold"

@implementation HttpManager

static HttpManager *shared = nil;

+ (HttpManager *)sharedHttpManager
{
    static dispatch_once_t _once;
    dispatch_once(&_once, ^{
        shared = [[HttpManager alloc] init];
    });
    return shared;
}

- (void)postWithUrl:(NSString *)url Parames:(NSDictionary *)params success:(SuccessBlock)success errorBlock:(ErrorBlock)errorBlock{
    
    AFHTTPSessionManager *net = [AFHTTPSessionManager manager];
    [net POST:[NSString stringWithFormat:@"%@%@",baseUrl,url] parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
        NSLog(@"error : %@",error.description);
    }];
}


- (void)getWithUrl:(NSString *)url Parames:(NSDictionary *)params success:(SuccessBlock)success errorBlock:(ErrorBlock)errorBlock{
    AFHTTPSessionManager *net = [AFHTTPSessionManager manager];
    [net GET:[NSString stringWithFormat:@"%@%@",baseUrl,url] parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
        NSLog(@"error : %@",error.description);
    }];
}

@end
