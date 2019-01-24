//
//  Topic.h
//  V2Client
//
//  Created by summer on 2019/1/23.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@class Node;
@class Member;
NS_ASSUME_NONNULL_BEGIN

@interface Topic : NSObject

@property (assign, nonatomic) NSInteger *id;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *contentRendered;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *replies;
@property (strong, nonatomic) Node *node;
@property (strong, nonatomic) Member *member;

@end

NS_ASSUME_NONNULL_END
