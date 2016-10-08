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

- (void)postImageWithUrl:(NSString *)url Parames:(NSDictionary *)params innerImage:(UIImage *)innerImage outImage:(UIImage *)outImage orgImages:(NSArray *)orgImages success:(SuccessBlock)success errorBlock:(ErrorBlock)errorBlock{

    // 基于AFN3.0+ 封装的HTPPSession句柄
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    // 在parameters里存放照片以外的对象
    [manager POST:[NSString stringWithFormat:@"%@%@",baseUrl,url] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
        if (innerImage) {
            NSData *imageData = UIImageJPEGRepresentation(innerImage, 0.5);
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统时间作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *dateString = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString  stringWithFormat:@"%@.png", dateString];

            [formData appendPartWithFileData:imageData name:@"innerImage" fileName:fileName mimeType:@"image/png/jpg/jpeg"];
        }
        
        if (outImage) {
            NSData *imageData = UIImageJPEGRepresentation(outImage, 0.5);
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统时间作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *dateString = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString  stringWithFormat:@"%@.png", dateString];
            
            [formData appendPartWithFileData:imageData name:@"outImage" fileName:fileName mimeType:@"image/png/jpg/jpeg"];
        }
        // 这里的_photoArr是你存放图片的数组
        for (int i = 0; i < orgImages.count; i++) {
            UIImage *image = orgImages[i];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统时间作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *dateString = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString  stringWithFormat:@"%@.png", dateString];
            /*
             *该方法的参数
             1. appendPartWithFileData：要上传的照片[二进制流]
             2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
             3. fileName：要保存在服务器上的文件名
             4. mimeType：上传的文件的类型
             */
            [formData appendPartWithFileData:imageData name:@"orgImages" fileName:fileName mimeType:@"image/png/jpg/jpeg"];
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

@end
