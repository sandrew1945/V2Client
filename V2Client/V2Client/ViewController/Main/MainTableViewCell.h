//
//  MainTableViewCell.h
//  V2Client
//
//  Created by summer on 2019/1/23.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) UILabel *userName;
@property (strong, nonatomic) UILabel *topic;
@property (strong, nonatomic) UILabel *node;
@property (strong, nonatomic) UIImageView *msgIcon;
@property (strong, nonatomic) UILabel *msgCount;
@property (strong, nonatomic) UILabel *lastReplyTime;
@property (strong, nonatomic) UILabel *lastReplyBy;

@end

NS_ASSUME_NONNULL_END
