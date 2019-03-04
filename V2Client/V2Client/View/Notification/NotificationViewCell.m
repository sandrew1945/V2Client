//
//  NotificationViewCell.m
//  V2Client
//
//  Created by summer on 2019/2/28.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import "NotificationViewCell.h"
#import "Masonry.h"
#import "UIKit+AFNetworking.h"
#import "Member.h"
#import "V2exColor.h"

@implementation NotificationViewCell

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
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setup];
    }
    
    return self;
}

#pragma mark - Layout
- (void)setup
{
    if (!self.avatarView)
    {
        self.avatarView = [[UIImageView alloc] init];
    }
    [self addSubview:self.avatarView];
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@40);
        make.height.equalTo(@40);
        make.top.equalTo(self.mas_top).with.offset(10);
        make.left.equalTo(self.mas_left).with.offset(10);
    }];
    if (!self.userNameLabel)
    {
        self.userNameLabel = [[UILabel alloc] init];
    }
    self.userNameLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.userNameLabel];
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarView.mas_top);
        make.left.equalTo(self.avatarView.mas_right).with.offset(10);
        make.height.equalTo(@21);
    }];
    if (!self.replyTimeLabel)
    {
        self.replyTimeLabel = [[UILabel alloc] init];
    }
    self.replyTimeLabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:self.replyTimeLabel];
    [self.replyTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.avatarView.mas_bottom);
        make.left.equalTo(self.avatarView.mas_right).with.offset(10);
        make.height.equalTo(@21);
    }];
    
    UIView *commentPanel = [[UIView alloc] init];
    [self addSubview:commentPanel];
    [commentPanel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarView.mas_bottom).with.offset(5);
        make.left.equalTo(self.avatarView.mas_left);
        make.right.equalTo(self.mas_right).with.offset(-5);
        make.bottom.equalTo(self.mas_bottom).with.offset(-5);
    }];
    
    if (!self.topicTitleLabel)
    {
        self.topicTitleLabel = [[UILabel alloc] init];
    }
    self.topicTitleLabel.font = [UIFont systemFontOfSize:14];
    [commentPanel addSubview:self.topicTitleLabel];
    self.topicTitleLabel.numberOfLines = 0;
    [self.topicTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(commentPanel.mas_top).with.offset(5);
        make.left.equalTo(commentPanel.mas_left);
        make.right.equalTo(commentPanel.mas_right).with.offset(-5);
    }];
    // 气泡UIImageView
    UIImage *popupImage = [UIImage imageNamed:@"ic_arrow_drop_up"];
    popupImage = [popupImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *popupView = [[UIImageView alloc] initWithImage:popupImage];
    popupView.tintColor = [V2exColor colorWithR:242 G:243 B:245 A:1];
    [self addSubview:popupView];
    [popupView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topicTitleLabel.mas_bottom).with.offset(5);
        make.left.equalTo(self.mas_left).with.offset(30);
    }];
    // 评论的背景
    UIView *commentBG = [[UIView alloc] init];
    commentBG.layer.cornerRadius = 3;
    commentBG.layer.masksToBounds = true;
    [commentPanel addSubview:commentBG];
    commentBG.backgroundColor = [V2exColor colorWithR:242 G:243 B:245 A:1];
    [commentBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(popupView.mas_bottom);
        make.left.equalTo(commentPanel.mas_left);
        make.right.equalTo(commentPanel.mas_right);
        make.bottom.equalTo(commentPanel.mas_bottom).with.offset(-5);
    }];
    
    if (!self.commentLabel)
    {
        self.commentLabel = [[UILabel alloc] init];
    }
    self.commentLabel.font = [UIFont systemFontOfSize:14];
    self.commentLabel.numberOfLines = 0;
    [commentPanel addSubview:self.commentLabel];
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(commentBG.mas_top).with.offset(5);
        make.left.equalTo(commentPanel.mas_left).with.offset(5);
        make.right.equalTo(commentPanel.mas_right).with.offset(-5);
        make.bottom.equalTo(commentPanel.mas_bottom).with.offset(-10);
    }];
}

- (void)initByReply:(Reply *)reply
{
    if (reply)
    {
        NSURL *url = [NSURL URLWithString:reply.member.avatarNormal];
        [self.avatarView setImageWithURL:url placeholderImage:nil];
        self.userNameLabel.text = reply.member.username;
        self.replyTimeLabel.text = reply.replyTime;
        self.topicTitleLabel.text = reply.topicTitle;
        self.commentLabel.text = reply.contentRendered;
    }
    
}
@end
