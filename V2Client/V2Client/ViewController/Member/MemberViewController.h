//
//  MemberViewController.h
//  V2Client
//
//  Created by summer on 2019/2/19.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPSessionManager.h"
#import "Member.h"
#import "Topic.h"
#import "Reply.h"

NS_ASSUME_NONNULL_BEGIN

@interface MemberViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@property (strong, nonatomic) UITableView           *tableView;
@property (strong, nonatomic) UIImageView           *avatarView;
@property (strong, nonatomic) NSString              *memberName;
@property (strong, nonatomic) UILabel               *memberNameLabel;
@property (strong, nonatomic) Member                *member;

// 背景
@property (strong, nonatomic) UIImageView           *backgroundView;
@property (strong, nonatomic) UIVisualEffectView    *frostedView;
@property (strong, nonatomic) UIVisualEffectView    *visualEffectView;

@property (strong, nonatomic) AFHTTPSessionManager  *manager;
@property (strong, nonatomic) NSMutableArray<Topic *> *topicList;
@property (strong, nonatomic) NSMutableArray<Reply *> *replyList;
@end

NS_ASSUME_NONNULL_END
