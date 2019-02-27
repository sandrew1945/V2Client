//
//  MemberTopicCell.h
//  V2Client
//
//  Created by summer on 2019/2/22.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Topic.h"

NS_ASSUME_NONNULL_BEGIN

@interface MemberTopicCell : UITableViewCell

@property (strong, nonatomic) UILabel       *lastReplyLabel;
@property (strong, nonatomic) UILabel       *titleLabel;
@property (strong, nonatomic) UILabel       *nodeLabel;
@property (strong, nonatomic) UIImageView   *replyIconView;
@property (strong, nonatomic) UILabel       *replyCountLabel;

- (void)initByTopic:(Topic *)topic;
@end

NS_ASSUME_NONNULL_END
