//
//  Member.h
//  V2Client
//
//  Created by summer on 2019/1/23.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Member : NSObject

@property (assign, nonatomic) NSInteger id;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *avatarNormal;
@property (strong, nonatomic) NSString *avatarLarge;
@property (strong, nonatomic) NSString *avatarMini;

@end

NS_ASSUME_NONNULL_END
