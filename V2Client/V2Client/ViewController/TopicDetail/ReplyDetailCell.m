//
//  TopicDetailCell.m
//  V2Client
//
//  Created by summer on 2019/1/25.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import "ReplyDetailCell.h"
#import "Masonry.h"

@implementation ReplyDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
//    [self addWebViewObserver];
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // 添加头像view
        self.avatarImageView = [[UIImageView alloc] init];
        [self addSubview:self.avatarImageView];
        [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@40);
            make.height.equalTo(@40);
            make.top.equalTo(self.mas_top).with.offset(10);
            make.left.equalTo(self.mas_left).with.offset(10);
        }];
        // 添加用户名view
        self.userName = [[UILabel alloc] init];
        [self.userName setFont:[UIFont systemFontOfSize:12.0f]];
        [self.userName sizeToFit];
        [self addSubview:self.userName];
        [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.avatarImageView.mas_top);
            make.left.equalTo(self.avatarImageView.mas_right).with.offset(10);
            //make.width.equalTo(@100);
            make.height.equalTo(@21);
        }];
        // 添加楼层View
        self.floor = [[UILabel alloc] init];
        [self.floor setFont:[UIFont systemFontOfSize:10.0f]];
        self.floor.textColor = [UIColor grayColor];
        [self.floor sizeToFit];
        [self addSubview:self.floor];
        [self.floor mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.avatarImageView.mas_bottom);
            make.left.equalTo(self.avatarImageView.mas_right).with.offset(10);
            //make.width.equalTo(@100);
            make.height.equalTo(@21);
        }];
        // 添加回复时间View
        self.replyTime = [[UILabel alloc] init];
        [self.replyTime setFont:[UIFont systemFontOfSize:10.0f]];
        self.replyTime.textColor = [UIColor grayColor];
        [self.replyTime sizeToFit];
        [self addSubview:self.replyTime];
        [self.replyTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.avatarImageView.mas_bottom);
            make.left.equalTo(self.floor.mas_right).with.offset(5);
            //make.width.equalTo(@100);
            make.height.equalTo(@21);
        }];
        // 添加回复内容
        self.reply = [[UILabel alloc] init];
        self.reply.numberOfLines = 0;
        [self.reply setFont:[UIFont systemFontOfSize:14.0f]];
        [self addSubview:self.reply];
        [self.reply mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.avatarImageView.mas_bottom).with.offset(10);
            make.bottom.equalTo(self.mas_bottom).with.offset(-10);
            make.left.equalTo(self.mas_left).with.offset(10);
            make.width.equalTo(self.mas_width).with.offset(-10);
        }];

    }
    return self;
}

@end
