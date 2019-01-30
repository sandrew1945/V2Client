//
//  Reply.h
//  V2Client
//
//  Created by summer on 2019/1/30.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Topic.h"

NS_ASSUME_NONNULL_BEGIN

@interface Reply : NSObject

@property (strong, nonatomic) Member    *member;
@property (strong, nonatomic) NSString  *content;
@property (strong, nonatomic) NSString  *contentRendered;

@end

NS_ASSUME_NONNULL_END
