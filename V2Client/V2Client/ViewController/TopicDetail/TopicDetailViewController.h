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

@interface TopicDetailViewController : UITableViewController <WKNavigationDelegate>

@property (strong, nonatomic) NSString *topicId;
@property (strong, nonatomic) Topic *topic;

@property (strong, nonatomic) UIView *headerHolder;
@property (strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) UILabel *userName;
@property (strong, nonatomic) UILabel *topicLabel;
@property (strong, nonatomic) UILabel *node;
@property (strong, nonatomic) WKWebView *topicView;

@property (strong, nonatomic) AFHTTPSessionManager *manager;

//@property (strong, nonatomic) WKWebView *webHolder;
//@property (strong, nonatomic) NSArray

@end

NS_ASSUME_NONNULL_END
