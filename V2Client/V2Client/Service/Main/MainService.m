//
//  MainService.m
//  V2Client
//
//  Created by summer on 2019/1/23.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import "MainService.h"
#import "Topic.h"

@implementation MainService

- (void)parseTopicsAndCopyTo:(NSArray<Topic *> *)topicList
{
    __block NSArray<Topic *> *loadList = [[NSArray alloc] init];
    self.manager = [AFHTTPSessionManager manager];
    [self.manager GET:@"https://www.v2ex.com/api/topics/latest.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSLog(@"%@---%@",[responseObject class],responseObject);
        loadList = [Topic mj_objectArrayWithKeyValuesArray:responseObject];
        //NSLog(@"%@---%@",[topicList class], topicList);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error : %@", error);
    }];
}

- (void)adapterMapping
{
    [Topic mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"contentRendered" : @"content_rendered"
                 };
    }];
    [Member mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"avatarNormal" : @"avatar_normal",
                 @"avatarLarge" : @"avatar_large",
                 @"avatarMini" : @"avatar_mini"
                 };
    }];
}

@end
