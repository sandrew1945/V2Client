//
//  MemberTopicCell.m
//  V2Client
//
//  Created by summer on 2019/2/22.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import "MemberTopicCell.h"
#import "Topic.h"
#import "Node.h"
#import "Masonry.h"

@implementation MemberTopicCell

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
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    }
    [self setup];
    return self;
}

#pragma mark - Layout
- (void)setup
{
    // 最后回复时间、回复人
    if (!self.lastReplyLabel)
    {
        self.lastReplyLabel = [[UILabel alloc] init];
    }
    [self.lastReplyLabel sizeToFit];
    self.lastReplyLabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:self.lastReplyLabel];
    [self.lastReplyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(5);
        make.left.equalTo(self.mas_left).with.offset(5);
    }];
    // 回复数量
    if (!self.replyCountLabel)
    {
        self.replyCountLabel = [[UILabel alloc] init];
    }
    [self.replyCountLabel sizeToFit];
    self.replyCountLabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:self.replyCountLabel];
    [self.replyCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lastReplyLabel.mas_centerY);
        make.right.equalTo(self.mas_right).with.offset(-5);
    }];
    // 回复图标
    if(!self.replyIconView)
    {
        self.replyIconView = [[UIImageView alloc] init];
    }
    self.replyIconView.image = [UIImage imageNamed:@"message"];
    [self addSubview:self.replyIconView];
    [self.replyIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.replyCountLabel);
        make.right.equalTo(self.replyCountLabel.mas_left).with.offset(-5);
        make.width.height.equalTo(@10);
    }];
    // 节点名称
    if (!self.nodeLabel)
    {
        self.nodeLabel = [[UILabel alloc] init];
    }
    [self.nodeLabel sizeToFit];
    self.nodeLabel.backgroundColor = [UIColor grayColor];
    self.nodeLabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:self.nodeLabel];
    [self.nodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.replyIconView);
        make.right.equalTo(self.replyIconView.mas_left).with.offset(-10);
    }];
    // 帖子主题
    if(!self.titleLabel)
    {
        self.titleLabel = [[UILabel alloc] init];
    }
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(10);
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.top.equalTo(self.lastReplyLabel.mas_bottom).with.offset(5);
        make.bottom.equalTo(self.mas_bottom).with.offset(-5);
    }];
}

- (void)initByTopic:(Topic *)topic
{
    self.titleLabel.text = topic.title;
    self.lastReplyLabel.text = topic.lastReplyTime;
    self.nodeLabel.text = topic.node.title;
    self.replyCountLabel.text = topic.replies;
}
@end
