//
//  NetworkingUtil.h
//  V2Client
//
//  Created by summer on 2019/3/4.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkingUtil : NSObject

@property (strong, nonatomic) AFHTTPSessionManager        *manager;
// 构造器
+ (instancetype)shareInstance;
// 设置请求头
- (void)setupHeader:(NSDictionary *)params;
// 发起GET请求
- (void)get:(NSString *)url
        parameters:(id)parameters
        preHandle:(void (^)(void))preHandle
        progress:(void (^)(NSProgress * _Nonnull))downloadProgress
        success:(void (^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject))success
        failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure;
// 发起POST请求
- (void)post:(NSString *)url
        parameters:(id)parameters
        preHandle:(void (^)(void))preHandle
        progress:(void (^)(NSProgress * _Nonnull))downloadProgress
        success:(void (^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject))success
        failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure;
@end

NS_ASSUME_NONNULL_END
