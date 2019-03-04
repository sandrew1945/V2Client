//
//  NotificationViewController.h
//  V2Client
//
//  Created by summer on 2019/2/28.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reply.h"
#import "AFHTTPSessionManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface NotificationViewController : UITableViewController

@property (strong, nonatomic) AFHTTPSessionManager        *manager;
@property (strong, nonatomic) NSMutableArray<Reply *>     *replyList;
@property (strong, nonatomic) NSArray<Reply *>            *replyListHolder;

@end

NS_ASSUME_NONNULL_END
