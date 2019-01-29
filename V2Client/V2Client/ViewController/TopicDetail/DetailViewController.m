//
//  DetailViewController.m
//  NatvieWebView
//
//  Created by hejianyuan on 2018/7/18.
//  Copyright © 2018年 ThinkCode. All rights reserved.
//

#import "DetailViewController.h"
#import <WebKit/WebKit.h>
#import "UIView+HSKit.h"
#import "Topic.h"
#import "UIKit+AFNetworking.h"
#import "MainService.h"
#import "Constants.h"
#import "Masonry.h"

/**
 * 最上面有个View，WebView和TableView
 */
@interface DetailViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate,
WKNavigationDelegate>

@property (strong, nonatomic) AFHTTPSessionManager *manager;

@property (strong, nonatomic) Topic         *topic;

@property (nonatomic, strong) WKWebView     *webView;

@property (nonatomic, strong) UITableView   *tableView;

@property (nonatomic, strong) UIScrollView  *containerScrollView;

@property (nonatomic, strong) UIView        *contentView;

@property (nonatomic, strong) UIView        *topView;
@property (strong, nonatomic) UIImageView   *avatarImageView;
@property (strong, nonatomic) UILabel       *userName;
@property (strong, nonatomic) UILabel       *topicLabel;
@property (strong, nonatomic) UILabel       *node;

@end

@implementation DetailViewController{
    CGFloat _lastWebViewContentHeight;
    CGFloat _lastTableViewContentHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self initValue];
    [self initView];
    [self addObservers];
    [self getTopicDataById:self.topicId];
//    NSString *path = @"https://www.jianshu.com/p/f31e39d3ce41";

    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:path]];
//    request.cachePolicy = NSURLRequestReloadIgnoringCacheData;
//    [self.webView loadRequest:request];
}

- (void)dealloc{
    [self removeObservers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initValue{
    _lastWebViewContentHeight = 0;
    _lastTableViewContentHeight = 0;
}

- (void)initView{
    
    [self.contentView addSubview:self.topView];
    [self.contentView addSubview:self.webView];
    [self.contentView addSubview:self.tableView];
    
    [self.view addSubview:self.containerScrollView];
    [self.containerScrollView addSubview:self.contentView];
    
    self.contentView.frame = CGRectMake(0, 0, self.view.width, self.view.height * 2);
    //self.topView.frame = CGRectMake(0, 0, self.view.width, 100);
    
    self.webView.top = self.topView.height;
    self.webView.height = self.view.height;
    self.tableView.top = self.webView.bottom;
}


#pragma mark - Observers
- (void)addObservers{
    [self.webView addObserver:self forKeyPath:@"scrollView.contentSize" options:NSKeyValueObservingOptionNew context:nil];
    [self.tableView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeObservers{
    [self.webView removeObserver:self forKeyPath:@"scrollView.contentSize"];
    [self.tableView removeObserver:self forKeyPath:@"contentSize"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (object == _webView) {
        if ([keyPath isEqualToString:@"scrollView.contentSize"]) {
            [self updateContainerScrollViewContentSize:0 webViewContentHeight:0];
        }
    }else if(object == _tableView) {
        if ([keyPath isEqualToString:@"contentSize"]) {
            [self updateContainerScrollViewContentSize:0 webViewContentHeight:0];
        }
    }
}

- (void)updateContainerScrollViewContentSize:(NSInteger)flag webViewContentHeight:(CGFloat)inWebViewContentHeight{
    
    CGFloat webViewContentHeight = flag==1 ?inWebViewContentHeight :self.webView.scrollView.contentSize.height;
    CGFloat tableViewContentHeight = self.tableView.contentSize.height;
    
    if (webViewContentHeight == _lastWebViewContentHeight && tableViewContentHeight == _lastTableViewContentHeight) {
        return;
    }
    
    _lastWebViewContentHeight = webViewContentHeight;
    _lastTableViewContentHeight = tableViewContentHeight;
    
    self.containerScrollView.contentSize = CGSizeMake(self.view.width, self.webView.top + webViewContentHeight + tableViewContentHeight);
    
    CGFloat webViewHeight = (webViewContentHeight < self.view.height) ?webViewContentHeight :self.view.height ;
    CGFloat tableViewHeight = tableViewContentHeight < self.view.height ?tableViewContentHeight :self.view.height;
    self.webView.height = webViewHeight <= 0.1 ?0.1 :webViewHeight;
    self.contentView.height = self.webView.top +webViewHeight + tableViewHeight;
    self.tableView.height = tableViewHeight;
    self.tableView.top = self.webView.bottom;
    
    //Fix:contentSize变化时需要更新各个控件的位置
    [self scrollViewDidScroll:self.containerScrollView];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_containerScrollView != scrollView) {
        return;
    }
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    CGFloat webViewHeight = self.webView.height;
    CGFloat tableViewHeight = self.tableView.height;
    
    CGFloat webViewContentHeight = self.webView.scrollView.contentSize.height;
    CGFloat tableViewContentHeight = self.tableView.contentSize.height;
    //CGFloat topViewHeight = self.topView.height;
    CGFloat webViewTop = self.webView.top;
    
    CGFloat netOffsetY = offsetY - webViewTop;
    
    if (netOffsetY <= 0) {
        self.contentView.top = 0;
        self.webView.scrollView.contentOffset = CGPointZero;
        self.tableView.contentOffset = CGPointZero;
    }else if(netOffsetY  < webViewContentHeight - webViewHeight){
        self.contentView.top = netOffsetY;
        self.webView.scrollView.contentOffset = CGPointMake(0, netOffsetY);
        self.tableView.contentOffset = CGPointZero;
    }else if(netOffsetY < webViewContentHeight){
        self.contentView.top = webViewContentHeight - webViewHeight;
        self.webView.scrollView.contentOffset = CGPointMake(0, webViewContentHeight - webViewHeight);
        self.tableView.contentOffset = CGPointZero;
    }else if(netOffsetY < webViewContentHeight + tableViewContentHeight - tableViewHeight){
        self.contentView.top = offsetY - webViewHeight - webViewTop;
        self.tableView.contentOffset = CGPointMake(0, offsetY - webViewContentHeight - webViewTop);
        self.webView.scrollView.contentOffset = CGPointMake(0, webViewContentHeight - webViewHeight);
    }else if(netOffsetY <= webViewContentHeight + tableViewContentHeight ){
        self.contentView.top = self.containerScrollView.contentSize.height - self.contentView.height;
        self.webView.scrollView.contentOffset = CGPointMake(0, webViewContentHeight - webViewHeight);
        self.tableView.contentOffset = CGPointMake(0, tableViewContentHeight - tableViewHeight);
    }else {
        //do nothing
        NSLog(@"do nothing");
    }
}

#pragma mark - UITableViewDataSouce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    cell.textLabel.text = @(indexPath.row).stringValue;
    return cell;
}

#pragma mark - load data
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
    // 重新适配webview的top属性
    [self changeWebViewTop];
    // 帖子内容
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
    
    [self.webView loadHTMLString:htmlString baseURL:nil];
}

- (void)changeWebViewTop
{
    // 更新view
    [_topView layoutIfNeeded];
    // 重新获取高度
    CGFloat tagViewHeight = _topView.height + 1;
    self.webView.top = tagViewHeight;
}

#pragma mark - private
- (WKWebView *)webView{
    if (_webView == nil) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
        _webView.scrollView.scrollEnabled = NO;
        _webView.navigationDelegate = self;
    }
    
    return _webView;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.scrollEnabled = NO;
        
    }
    return _tableView;
}

- (UIScrollView *)containerScrollView{
    if (_containerScrollView == nil) {
        _containerScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _containerScrollView.delegate = self;
        _containerScrollView.alwaysBounceVertical = YES;
    }
    
    return _containerScrollView;
}

- (UIView *)contentView{
    if (_contentView == nil) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

- (UIView *)topView{
    if (_topView == nil) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor whiteColor];
    }
    // 添加头像view
    self.avatarImageView = [[UIImageView alloc] init];
    [_topView addSubview:self.avatarImageView];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@40);
        make.height.equalTo(@40);
        make.top.equalTo(_topView.mas_top).with.offset(10);
        make.left.equalTo(_topView.mas_left).with.offset(10);
    }];
    
    
    // 添加用户名view
    self.userName = [[UILabel alloc] init];
    [self.userName setFont:[UIFont systemFontOfSize:12.0f]];
    [_topView addSubview:self.userName];
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
    [_topView addSubview:self.topicLabel];
    [self.topicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarImageView.mas_bottom).with.offset(10);
        //        make.bottom.equalTo(header.mas_bottom).with.offset(-10);
        make.left.equalTo(_topView.mas_left).with.offset(10);
        make.width.equalTo(_topView.mas_width).with.offset(-10);
    }];
    // 添加节点名称
    self.node = [[UILabel alloc] init];
    self.node.backgroundColor = [UIColor grayColor];
    self.node.font = [UIFont systemFontOfSize:10.0f];
    [_topView addSubview:self.node];
    [self.node mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarImageView.mas_top);
        make.right.equalTo(_topView.mas_right).with.offset(-10);
        make.height.equalTo(@21);
    }];
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.topicLabel.mas_bottom).with.offset(5);
        CGFloat width = self.tableView.frame.size.width;
        make.width.equalTo(@(width));
    }];
    return _topView;
}


@end
