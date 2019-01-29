//
//  TopicDetailViewController.m
//  V2Client
//
//  Created by summer on 2019/1/24.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import "TopicDetailViewController.h"
#import "MainService.h"
#import "Constants.h"
#import "Masonry.h"
#import "TopicDetailCell.h"
#import "UIKit+AFNetworking.h"

@interface TopicDetailViewController ()

@end

@implementation TopicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self.tableView registerClass:[TopicDetailCell class] forCellReuseIdentifier:TOPIC_CELL_INDENTIFIER];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:REPLIES_CELL_INDENTIFIER];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self getTopicDataById:self.topicId];
//    self.headerHolder = [[UIView alloc] init];
    
    self.tableView.tableHeaderView = [[UIView alloc] init];
    [self createHeader];
    [self addWebViewObserver];

}


#pragma mark - TableView delegate & datasource
static NSString *TOPIC_CELL_INDENTIFIER = @"topic_reuseIdentifier";
static NSString *REPLIES_CELL_INDENTIFIER = @"replies_reuseIdentifier";
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *repliesCell = [tableView dequeueReusableCellWithIdentifier:REPLIES_CELL_INDENTIFIER forIndexPath:indexPath];
    repliesCell.textLabel.text = @"cccccccc";
    return repliesCell;
/*
    switch ([indexPath section]) {
        case 0:
        {
            TopicDetailCell *topicCell = [tableView dequeueReusableCellWithIdentifier:TOPIC_CELL_INDENTIFIER forIndexPath:indexPath];
            if (!topicCell)
            {
                topicCell = [[TopicDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TOPIC_CELL_INDENTIFIER];
            }
            if (self.topic)
            {
//                self.holder = topicCell.topicView;
//                [self addWebViewObserver];
                NSURL *url = [NSURL URLWithString:[@"https:" stringByAppendingString:self.topic.member.avatarNormal]];
                [topicCell.avatarImageView setImageWithURL:url placeholderImage:nil];
                // 发帖人
                topicCell.userName.text = self.topic.member.username;
                // 标题
                topicCell.topic.numberOfLines = 0;
                topicCell.topic.text = self.topic.title;
                // 节点名称
                topicCell.node.text = self.topic.node.title;
                // 帖子内容
                NSString *headerString = @"<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>";
                
                [topicCell.topicView loadHTMLString:[headerString stringByAppendingString:self.topic.contentRendered] baseURL:nil];
            }
            return topicCell;
        }
        default:
        {
            UITableViewCell *repliesCell = [tableView dequeueReusableCellWithIdentifier:REPLIES_CELL_INDENTIFIER forIndexPath:indexPath];
            repliesCell.textLabel.text = @"cccccccc";
            return repliesCell;
        }
            
    }
 */
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
        default:
            return 10;
    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 400;
//}

#pragma mark - table header
- (void)createHeader
{
    CGRect screen = [[UIScreen mainScreen] bounds];
//    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen.size.width, 220)];
    UIView *header = [[UIView alloc] init];
    self.headerHolder = header;
    // 添加头像view
    self.avatarImageView = [[UIImageView alloc] init];
    [header addSubview:self.avatarImageView];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@40);
        make.height.equalTo(@40);
        make.top.equalTo(header.mas_top).with.offset(10);
        make.left.equalTo(header.mas_left).with.offset(10);
    }];
    

    // 添加用户名view
    self.userName = [[UILabel alloc] init];
    [self.userName setFont:[UIFont systemFontOfSize:12.0f]];
    [header addSubview:self.userName];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarImageView.mas_top);
        make.left.equalTo(self.avatarImageView.mas_right).with.offset(10);
        make.width.equalTo(@100);
        make.height.equalTo(@21);
    }];
    // 添加帖子标题
    self.topicLabel = [[UILabel alloc] init];
    [self.topicLabel setFont:[UIFont systemFontOfSize:14.0f]];
    self.topicLabel.numberOfLines = 0;
    [header addSubview:self.topicLabel];
    [self.topicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarImageView.mas_bottom).with.offset(10);
//        make.bottom.equalTo(header.mas_bottom).with.offset(-10);
        make.left.equalTo(header.mas_left).with.offset(10);
        make.width.equalTo(header.mas_width).with.offset(-10);
    }];
    // 添加节点名称
    self.node = [[UILabel alloc] init];
    self.node.backgroundColor = [UIColor grayColor];
    self.node.font = [UIFont systemFontOfSize:10.0f];
    [header addSubview:self.node];
    [self.node mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarImageView.mas_top);
        make.right.equalTo(header.mas_right).with.offset(-10);
        make.height.equalTo(@21);
    }];

    // 添加帖子内容
    self.topicView = [[WKWebView alloc] init];
    self.topicView.navigationDelegate = self;
    [header addSubview:self.topicView];
    [self.topicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topicLabel.mas_bottom).with.offset(5);
        make.left.equalTo(header.mas_left).with.offset(5);
        make.right.equalTo(header.mas_right).with.offset(-5);
        make.width.equalTo(header.mas_width).with.offset(-10);
    }];

    
    [header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.topicView.mas_bottom).with.offset(5);
        CGFloat width = self.tableView.frame.size.width;
        make.width.equalTo(@(width));
    }];
}

- (void)loadHeaderData
{
    // 头像
    NSURL *url = [NSURL URLWithString:[@"https:" stringByAppendingString:self.topic.member.avatarNormal]];
    [self.avatarImageView setImageWithURL:url placeholderImage:nil];
    // 发帖人
    self.userName.text = self.topic.member.username;
    // 标题
    self.topicLabel.text = self.topic.title;
    // 节点名称
    self.node.text = self.topic.node.title;
    // 帖子内容
    NSString *headerString = @"<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>";
    NSString *htmlString = [NSString stringWithFormat:@"<html> \n"
                            "<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>\n"
                            "<body>"
                            "<script type='text/javascript'>"
                            "window.onload = function(){\n"
                            "var $img = document.getElementsByTagName('img');\n"
                            "for(var p in  $img){\n"
                            " $img[p].style.width = '100%%';\n"
                            "$img[p].style.height ='auto'\n"
                            "}\n"
                            "}"
                            "</script>%@"
                            "</body>"
                            "</html>", self.topic.contentRendered];

    [self.topicView loadHTMLString:htmlString baseURL:nil];

    // 更新table header的高度
    [self.tableView beginUpdates];
    [self.tableView setTableHeaderView:self.headerHolder];
    [self.tableView endUpdates];
    //下面这部分很关键,重新布局获取最新的frame,然后赋值给myTableHeaderView
    [self.headerHolder setNeedsLayout];
//    [self.headerHolder layoutIfNeeded];
    CGSize size = [self.headerHolder systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    CGRect headerFrame = self.headerHolder.frame;
    headerFrame.size.height = size.height;
    self.headerHolder.frame = headerFrame;
    self.tableView.tableHeaderView = self.headerHolder;
}


#pragma mark - fetch data
- (void)getTopicDataById:(NSString *)topicId
{
    NSDictionary *paramDict = @{@"id":self.topicId};
    self.manager = [AFHTTPSessionManager manager];
    [self.manager GET:TOPIC_CONTENT_URL parameters:paramDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@---%@",[responseObject class],responseObject);
        MainService *service = [[MainService alloc] init];
        [service adapterMapping];
        NSArray *topics = [Topic mj_objectArrayWithKeyValuesArray:responseObject];
        self.topic = [topics objectAtIndex:0];
        NSLog(@"%@---%@",[self.topic class], self.topic);
        [self.tableView reloadData];
        [self loadHeaderData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error");
    }];
}

#pragma mark listen webview height
- (void)addWebViewObserver {
    [self.topicView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    /**  < loading：防止滚动一直刷新，出现闪屏 >  */
    if ([keyPath isEqualToString:@"contentSize"]) {
        CGRect webFrame = self.topicView.frame;
        webFrame.size.height = self.topicView.scrollView.contentSize.height;
        self.topicView.frame = webFrame;
//        self.tableView.tableHeaderView = self.headerHolder;
        
//        [self.tableView beginUpdates];
//        [self.tableView setTableHeaderView:self.headerHolder];
//        [self.tableView endUpdates];
    }
            NSLog(@"frame ------------------- %@", NSStringFromCGRect(self.topicView.frame));
}
- (void)removeWebViewObserver {
    [self.topicView.scrollView removeObserver:self forKeyPath:@"contentSize"];
}


#pragma mark dealloc
- (void)dealloc
{
    [self removeWebViewObserver];
}


#pragma mark NavigateDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSLog(@"网页加载完成");
    [self.headerHolder setNeedsLayout];
}

@end
