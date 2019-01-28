//
//  TopicDetailCell.m
//  V2Client
//
//  Created by summer on 2019/1/25.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import "TopicDetailCell.h"
#import "Masonry.h"

@implementation TopicDetailCell

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
        [self addSubview:self.userName];
        [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.avatarImageView.mas_top);
            make.left.equalTo(self.avatarImageView.mas_right).with.offset(10);
            make.width.equalTo(@100);
            make.height.equalTo(@21);
        }];
        // 添加帖子标题
        self.topic = [[UILabel alloc] init];
        [self.topic setFont:[UIFont systemFontOfSize:14.0f]];
        [self addSubview:self.topic];
        [self.topic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.avatarImageView.mas_bottom).with.offset(10);
            //make.bottom.equalTo(self.mas_bottom).with.offset(-10);
            make.left.equalTo(self.mas_left).with.offset(10);
            make.width.equalTo(self.mas_width).with.offset(-10);
        }];
        // 添加节点名称
        self.node = [[UILabel alloc] init];
        self.node.backgroundColor = [UIColor grayColor];
        self.node.font = [UIFont systemFontOfSize:10.0f];
        [self addSubview:self.node];
        [self.node mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.avatarImageView.mas_top);
            make.right.equalTo(self.mas_right).with.offset(-10);
            //            make.width.equalTo(@40);
            make.height.equalTo(@21);
        }];
    }
    return self;
}

//#pragma mark listen webview height
//- (void)addWebViewObserver {
//    [self.topicView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
//}
//
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
//    /**  < loading：防止滚动一直刷新，出现闪屏 >  */
//    if ([keyPath isEqualToString:@"contentSize"]) {
//        CGRect webFrame = self.topicView.frame;
//        webFrame.size.height = self.topicView.scrollView.contentSize.height;
//        self.topicView.frame = webFrame;
//
//    }
//}
//- (void)removeWebViewObserver {
//    [self.topicView.scrollView removeObserver:self forKeyPath:@"contentSize"];
//}
//
//
//#pragma mark dealloc
//- (void)dealloc
//{
//    [self removeWebViewObserver];
//}

@end
