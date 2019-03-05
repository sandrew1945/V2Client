//
//  NetworkingUtil.m
//  V2Client
//
//  Created by summer on 2019/3/4.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import "NetworkingUtil.h"

@implementation NetworkingUtil

static NetworkingUtil * _instance = nil;

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init];
    });
    return _instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [NetworkingUtil shareInstance];
}

- (id)copyWithZone:(struct _NSZone *)zone
{
    return [NetworkingUtil shareInstance] ;
}


- (void)get:(NSString *)url
        parameters:(id)parameters
        preHandle:(void (^)(void))preHandle
        progress:(void (^)(NSProgress * _Nonnull))downloadProgress
        success:(void (^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject))success
        failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure
{
    [self initManager];
    preHandle();
    [self.manager GET:url parameters:parameters progress:downloadProgress success:success failure:failure];
}


- (void)post:(NSString *)url
        parameters:(id)parameters
        preHandle:(void (^)(void))preHandle
        progress:(void (^)(NSProgress * _Nonnull))downloadProgress
        success:(void (^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject))success
        failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure
{
    [self initManager];
    preHandle();
    [self.manager POST:url parameters:parameters progress:downloadProgress success:success failure:failure];
}

- (void)initManager
{
    if (!self.manager)
    {
        // 初始化对象
        self.manager = [AFHTTPSessionManager manager];
        self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"image/png", nil];
    }
}

- (void)setupHeader:(NSDictionary *)params
{
    NSArray *keys = [params allKeys];
    if (params)
    {
        [self initManager];
        for (NSString *key in keys)
        {
            [self.manager.requestSerializer setValue:[params objectForKey:key] forHTTPHeaderField:key];
        }
    }
}


@end
