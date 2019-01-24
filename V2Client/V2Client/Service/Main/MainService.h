//
//  MainService.h
//  V2Client
//
//  Created by summer on 2019/1/23.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Topic.h"
#import "Node.h"
#import "Member.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainService : NSObject

@property (strong, nonatomic) AFHTTPSessionManager *manager;

- (void)parseTopicsAndCopyTo:(NSArray<Topic *> *)topicList;

- (void)adapterMapping;
@end

NS_ASSUME_NONNULL_END
