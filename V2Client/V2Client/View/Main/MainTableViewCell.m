//
//  MainTableViewCell.m
//  V2Client
//
//  Created by summer on 2019/1/23.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import "MainTableViewCell.h"
#import "Masonry.h"
#import "MemberViewController.h"
#import "V2exControllerHolder.h"
#import "UIKit+AFNetworking.h"
#import "MainService.h"

@implementation MainTableViewCell

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
        [self.avatarImageView setUserInteractionEnabled:true];
        UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] init];
        [tgr addTarget:self action:@selector(clickAvatar:)];
        [self.avatarImageView addGestureRecognizer:tgr];
        
        // 添加用户名view
        self.userName = [[UILabel alloc] init];
        [self.userName setFont:[UIFont systemFontOfSize:12.0f]];
        [self.userName sizeToFit];
        [self addSubview:self.userName];
        [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.avatarImageView.mas_top);
            make.left.equalTo(self.avatarImageView.mas_right).with.offset(10);
            //make.width.equalTo(@200);
            make.height.equalTo(@21);
        }];
        
        // 添加最后回复时间
        self.lastReplyTime = [[UILabel alloc] init];
        [self.lastReplyTime setFont:[UIFont systemFontOfSize:10.0f]];
        [self.lastReplyTime setTextColor:[UIColor grayColor]];
        [self.lastReplyTime sizeToFit];
        [self addSubview:self.lastReplyTime];
        [self.lastReplyTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.avatarImageView.mas_bottom);
            make.left.equalTo(self.avatarImageView.mas_right).with.offset(10);
            //make.width.equalTo(@200);
            make.height.equalTo(@21);
        }];
        // 添加最后回复人
        self.lastReplyBy = [[UILabel alloc] init];
        [self.lastReplyBy setFont:[UIFont systemFontOfSize:10.0f]];
        [self.lastReplyBy setTextColor:[UIColor grayColor]];
        [self.lastReplyBy sizeToFit];
        [self addSubview:self.lastReplyBy];
        [self.lastReplyBy mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.avatarImageView.mas_bottom);
            make.left.equalTo(self.lastReplyTime.mas_right).with.offset(10);
            //make.width.equalTo(@200);
            make.height.equalTo(@21);
        }];
        // 添加帖子标题
        self.topic = [[UILabel alloc] init];
        [self.topic setFont:[UIFont systemFontOfSize:14.0f]];
        [self addSubview:self.topic];
        [self.topic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.avatarImageView.mas_bottom).with.offset(10);
            make.bottom.equalTo(self.mas_bottom).with.offset(-10);
            make.left.equalTo(self.mas_left).with.offset(10);
            make.width.equalTo(self.mas_width).with.offset(-10);
        }];
        
        // 添加回复数节点
        self.msgIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"message"]];
        [self addSubview:self.msgIcon];
        [self.msgIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.avatarImageView.mas_top);
            make.left.equalTo(self.mas_right).with.offset(-60);
            make.width.equalTo(@20);
            make.height.equalTo(@20);
        }];
        self.msgCount = [[UILabel alloc] init];
        self.msgCount.font = [UIFont systemFontOfSize:10.0f];
        self.msgCount.numberOfLines = 0;
        [self addSubview:self.msgCount];
        [self.msgCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.avatarImageView.mas_top);
            make.left.equalTo(self.msgIcon.mas_right).with.offset(2);
//            make.width.equalTo(@20);
            make.height.equalTo(@20);
        }];
        
        // 添加节点名称
        self.node = [[UILabel alloc] init];
        self.node.backgroundColor = [UIColor grayColor];
        self.node.font = [UIFont systemFontOfSize:10.0f];
        self.node.numberOfLines = 0;
        [self addSubview:self.node];
        [self.node mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.avatarImageView.mas_top);
            make.right.equalTo(self.msgIcon.mas_left).with.offset(-10);
//            make.width.equalTo(@40);
            make.height.equalTo(@21);
        }];
        
        
    }
    return self;
}

#pragma mark - Bind Data
- (void)initByTopic:(Topic *)topic
{
    NSURL *url;
    // 头像
    if ([topic.member.avatarNormal containsString:@"https:"])
    {
        url = [NSURL URLWithString:topic.member.avatarNormal];
    }
    else
    {
        url = [NSURL URLWithString:[@"https:" stringByAppendingString:topic.member.avatarNormal]];
    }
    [self.avatarImageView setImageWithURL:url placeholderImage:nil];
    // 发帖人
    self.userName.text = topic.member.username;
    // 最后回复人，回复时间
    MainService *mainService = [[MainService alloc] init];
    self.lastReplyTime.text = [mainService handleTimeDifference:topic.lastReplyTime];
    if (nil != topic.lastReplyBy && topic.lastReplyBy.length != 0)
    {
        self.lastReplyBy.text = [@"•    最后回复 " stringByAppendingString:topic.lastReplyBy];
    }
    
    // 标题
    self.topic.numberOfLines = 0;
    self.topic.text = topic.title;
    // 节点名称
    self.node.text = topic.node.title;
    // 回复数
    self.msgCount.text = topic.replies;
}

#pragma mark - Actions
- (void)clickAvatar:(id)sender
{
    MemberViewController *memberViewController = [[MemberViewController alloc] init];
    memberViewController.memberName = self.userName.text;
    memberViewController.title = self.userName.text;
    [[V2exControllerHolder shareInstance].centerViewController pushViewController:memberViewController animated:YES];
}

@end
