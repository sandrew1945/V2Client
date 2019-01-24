//
//  Node.h
//  V2Client
//
//  Created by summer on 2019/1/23.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Node : NSObject

@property (assign, nonatomic) NSInteger *id;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *url;

@end

NS_ASSUME_NONNULL_END
