//
//  V2exUser.m
//  V2Client
//
//  Created by summer on 2019/2/13.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import "V2exUser.h"

@implementation V2exUser

static V2exUser * _instance = nil;

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
    return [V2exUser shareInstance];
}

- (id)copyWithZone:(struct _NSZone *)zone
{
    return [V2exUser shareInstance] ;
}


- (BOOL)isLogin
{
    return self.userName ? true : false;
}

- (void)logout
{
    self.userName = nil;
    self.once = nil;
}

- (void)verifyLoginStatus
{
    
}

@end
