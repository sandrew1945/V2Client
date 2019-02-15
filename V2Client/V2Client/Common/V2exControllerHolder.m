//
//  V2exControllerHolder.m
//  V2Client
//
//  Created by summer on 2019/2/13.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import "V2exControllerHolder.h"

@implementation V2exControllerHolder

static V2exControllerHolder * _instance = nil;

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
    return [V2exControllerHolder shareInstance];
}

- (id)copyWithZone:(struct _NSZone *)zone
{
    return [V2exControllerHolder shareInstance] ;
}

@end
