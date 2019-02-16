//
//  V2exUser.h
//  V2Client
//
//  Created by summer on 2019/2/13.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface V2exUser : NSObject

@property (strong, nonatomic, nullable) NSString *userName;
@property (strong, nonatomic)           NSString *avatarPath;
@property (strong, nonatomic, nullable) NSString *once;

+ (instancetype)shareInstance;

- (BOOL)isLogin;

- (void)logout;

- (void)verifyLoginStatus;
@end

NS_ASSUME_NONNULL_END
