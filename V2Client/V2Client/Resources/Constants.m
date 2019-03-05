//
//  Constants.m
//  V2Client
//
//  Created by summer on 2019/1/24.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import "Constants.h"

@implementation Constants

NSString * const V2EX_URL = @"https://www.v2ex.com";
NSString * const LOGIN_URL = @"https://www.v2ex.com/signin";
NSString * const GET_VALIDATE_CODE_URL = @"https://www.v2ex.com/_captcha";
NSString * const ALL_TOPIC_URL = @"https://www.v2ex.com/?tab=all";
NSString * const RECENT_TOPIC_URL = @"https://www.v2ex.com/recent";
NSString * const LAST_TOPIC_URL = @"https://www.v2ex.com/api/topics/latest.json";
NSString * const TOPIC_CONTENT_URL = @"https://www.v2ex.com/api/topics/show.json";
NSString * const TOPIC_REPLY_URL = @"https://www.v2ex.com/api/replies/show.json";
NSString * const MEMBER_INFO_URL = @"https://www.v2ex.com/member/";
NSString * const NOTIFICATION_URL = @"https://www.v2ex.com/notifications";
NSString * const FAVORITES_URL = @"https://www.v2ex.com/my/topics";

NSString * const APP_USER_NAME_KEY = @"k_userName";
NSString * const APP_AVATAR_PATH_KEY = @"k_avatarPath";
@end
