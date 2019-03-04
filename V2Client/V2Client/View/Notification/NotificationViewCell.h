//
//  NotificationViewCell.h
//  V2Client
//
//  Created by summer on 2019/2/28.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reply.h"

NS_ASSUME_NONNULL_BEGIN

@interface NotificationViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView   *avatarView;
@property (strong, nonatomic) UILabel       *userNameLabel;
@property (strong, nonatomic) UILabel       *replyTimeLabel;
@property (strong, nonatomic) UIButton      *replyBtn;
@property (strong, nonatomic) UIImageView   *popupView;
@property (strong, nonatomic) UILabel       *topicTitleLabel;
@property (strong, nonatomic) UILabel       *commentLabel;


- (void)initByReply:(Reply *)reply;
@end

NS_ASSUME_NONNULL_END
