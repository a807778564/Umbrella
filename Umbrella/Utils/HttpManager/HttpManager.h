//
//  HttpManager.h
//  Umbrella
//
//  Created by huangrensheng on 16/9/28.
//  Copyright © 2016年 umbrella. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlock)(id successData);
typedef void(^ErrorBlock)(NSError *error);

@interface HttpManager : NSObject

+ (HttpManager *)sharedHttpManager;

- (void)postWithUrl:(NSString *)url Parames:(NSDictionary *)params success:(SuccessBlock)success errorBlock:(ErrorBlock)errorBlock;

- (void)getWithUrl:(NSString *)url Parames:(NSDictionary *)params success:(SuccessBlock)success errorBlock:(ErrorBlock)errorBlock;

- (void)postImageWithUrl:(NSString *)url Parames:(NSDictionary *)params innerImage:(UIImage *)innerImage outImage:(UIImage *)outImage orgImages:(NSArray *)orgImages success:(SuccessBlock)success errorBlock:(ErrorBlock)errorBlock;

@end
