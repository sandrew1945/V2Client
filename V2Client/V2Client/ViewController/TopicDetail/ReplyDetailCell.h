//
//  TopicDetailCell.h
//  V2Client
//
//  Created by summer on 2019/1/25.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReplyDetailCell : UITableViewCell

@property (strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) UILabel *userName;
@property (strong, nonatomic) UILabel *reply;

@end

NS_ASSUME_NONNULL_END
