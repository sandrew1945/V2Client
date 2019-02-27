//
//  MemberComentCell.m
//  V2Client
//
//  Created by summer on 2019/2/22.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import "MemberComentCell.h"
#import "Masonry.h"
#import "V2exColor.h"

@implementation MemberComentCell

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
    // 回复帖子标题
    if (!self.topicTitleLabel)
    {
        self.topicTitleLabel = [[UILabel alloc] init];
    }
    [self.topicTitleLabel sizeToFit];
    self.topicTitleLabel.font = [UIFont systemFontOfSize:13];
    self.topicTitleLabel.numberOfLines = 0;
    [self addSubview:self.topicTitleLabel];
    [self.topicTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(5);
        make.left.equalTo(self.mas_left).with.offset(10);
        make.right.equalTo(self.mas_right).with.offset(10);
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
    if (!self.commentPanel)
    {
        self.commentPanel = [[UIView alloc] init];
    }
    self.commentPanel.layer.cornerRadius = 3;
    self.commentPanel.layer.masksToBounds = true;
    [self addSubview:self.commentPanel];
    self.commentPanel.backgroundColor = [V2exColor colorWithR:242 G:243 B:245 A:1];
    [self.commentPanel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(popupView.mas_bottom);
        make.left.equalTo(self.mas_left).with.offset(10);
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.bottom.equalTo(self.mas_bottom).with.offset(-5);
    }];
    
    // 评论label
    if (!self.commentLabel)
    {
        self.commentLabel = [[UILabel alloc] init];
    }
    [self.commentLabel sizeToFit];
    self.commentLabel.numberOfLines = 0;
    self.commentLabel.font = [UIFont systemFontOfSize:14];
//    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.commentLabel];
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(popupView.mas_bottom).with.offset(5);
        make.left.equalTo(self.mas_left).with.offset(22);
        make.right.equalTo(self.mas_right).with.offset(-22);
        make.bottom.equalTo(self.mas_bottom).with.offset(-10);
    }];

}

- (void)initByReply:(Reply *)reply
{
    self.topicTitleLabel.text = reply.topicTitle;
    self.commentLabel.text = reply.contentRendered;
}
@end
