//
//  TopicDetailViewController.h
//  V2Client
//
//  Created by summer on 2019/1/24.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "Topic.h"
#import "AFNetworking.h"

NS_ASSUME_NONNULL_BEGIN

@interface TopicDetailViewController : UITableViewController

@property (strong, nonatomic) NSString *topicId;
@property (strong, nonatomic) Topic *topic;
@property (strong, nonatomic) AFHTTPSessionManager *manager;
//@property (strong, nonatomic) NSArray

@end

NS_ASSUME_NONNULL_END
