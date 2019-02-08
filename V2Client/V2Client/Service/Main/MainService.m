//
//  MainService.m
//  V2Client
//
//  Created by summer on 2019/1/23.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import "MainService.h"
#import "Topic.h"
#import "Reply.h"

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

- (void)topicHeadAdapterMapping
{
    [Topic mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"topicId"         : @"id",
                 @"contentRendered" : @"content_rendered",
                 @"lastReplyTime"   : @"last_modified",
                 @"lastReplyBy"     : @"last_reply_by"
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

- (void) topicReplyAdapterMapping
{
    [Reply mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"contentRendered" : @"content_rendered",
                 @"replyTime"       : @"last_modified"
                 };
    }];
}


- (NSString *)handleTimeDifference:(NSString *)timestamp
{
    double orginTimestamp = [timestamp doubleValue];//传入的时间戳str如果是精确到毫秒的记得要/1000
    double currentTimestamp = [[NSDate date] timeIntervalSince1970];
    long minute = (currentTimestamp - orginTimestamp) / 60;
    if (minute < 60)
    {
        return [NSString stringWithFormat:@"%ld分钟以前", minute];
    }
    else if(minute >= 60)
    {
        long hours = minute / 60;
        long andMinute = minute % 60;
        return [NSString stringWithFormat:@"%ld小时%ld分钟以前", hours, andMinute];
    }
    else if(minute >= (60*24))
    {
        long days = minute / (60*24);
        return [NSString stringWithFormat:@"%ld天以前", days];
    }
    return @"";
}
@end
