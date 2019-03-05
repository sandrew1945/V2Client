//
//  NotificationViewController.m
//  V2Client
//
//  Created by summer on 2019/2/28.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import "NotificationViewController.h"
#import "SVProgressHUD.h"
#import "Constants.h"
#import "TFHpple.h"
#import "V2exUtil.h"
#import "Member.h"
#import "NotificationViewCell.h"
#import "MJRefreshNormalHeader.h"
#import "MJRefreshGifHeader.h"
#import "MJRefreshAutoNormalFooter.h"
#import "MJRefreshAutoGifFooter.h"

@interface NotificationViewController ()

@end

@implementation NotificationViewController
static NSString *CELL_IDENTIFIER = @"reuseIdentifier";
static int totalPage = 1;
static int currentPage = 1;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[NotificationViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER];
    self.tableView.estimatedRowHeight = 80;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // 初始化对象
    if (!self.manager)
    {
        if (!self.manager)
        {
            self.manager = [AFHTTPSessionManager manager];
            self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"image/png", nil];
        }
    }
    // 加载布局
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    // 上拉刷新、下拉更多
    [self setRefresh];
    // 处理数据
    [self crawlHtmlAndParse:NOTIFICATION_URL];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.replyListHolder count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NotificationViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    [cell initByReply:[self.replyListHolder objectAtIndex:[indexPath row]]];
    return cell;
}



#pragma mark - Handle Data
- (void)crawlHtmlAndParse:(NSString *)url
{
    self.replyList = [[NSMutableArray alloc] init];
    [SVProgressHUD showWithStatus:@"加载中"];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [self.manager.requestSerializer setValue:@"Mozilla/5.0 (iPhone; CPU iPhone OS 8_0 like Mac OS X) AppleWebKit/600.1.3 (KHTML, like Gecko) Version/8.0 Mobile/12A4345d Safari/600.1.4" forHTTPHeaderField:@"user-agent"];
    [self.manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 解析html
        NSString * htmlStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        //NSLog(@"response html : %@", htmlStr);
        // 获取页数
        totalPage = [self parsePageCount:htmlStr];
        // 解析第一页
        [self parseHtml:htmlStr];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];

    [SVProgressHUD dismiss];
    
}

- (int)parsePageCount:(NSString *)html
{
    TFHpple *htmlParser = [[TFHpple alloc] initWithHTMLData:[html dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *content = [V2exUtil getContentFromParse:htmlParser ByXpath:@"//*[@id='Wrapper']/div/div/div[12]/table/tr/td[2]/strong[1]"];
    NSRange range = [content rangeOfString:@"/"];
    return [[content substringFromIndex:range.location + 1] intValue];
}

- (void)parseHtml:(NSString *)html
{
    TFHpple *htmlParser = [[TFHpple alloc] initWithHTMLData:[html dataUsingEncoding:NSUTF8StringEncoding]];
    NSArray *elements = [V2exUtil getElementsFromParse:htmlParser ByXpath:@"//*[@class='cell']"];
    for (TFHppleElement *element in elements) {
        Reply *reply = [[Reply alloc] init];
        NSString *avatarPath = [@"https:" stringByAppendingString:[V2exUtil getAttribute:@"src" FromElement:element ByXPath:@"//table/tr/td[1]/a[1]/img[1]"]];
        NSString *memberName = [V2exUtil getContentFromElement:element ByXpath:@"//table/tr/td[2]/span[1]/a[1]/strong[1]"];
        NSString *topicTitle = [V2exUtil getContentFromElement:element ByXpath:@"//table/tr/td[2]/span[1]/a[2]"];
        NSString *topicId = [V2exUtil getAttribute:@"href" FromElement:element ByXPath:@"//table/tr/td[2]/span[1]/a[2]"];
        NSString *replyTime = [V2exUtil getContentFromElement:element ByXpath:@"//table/tr/td[2]/span[2]"];
        NSString *contentRendered = [V2exUtil getContentFromElement:element ByXpath:@"//table/tr/td[2]/div[2]"];
        Member *member = [[Member alloc] init];
        member.avatarNormal = avatarPath;
        member.username = memberName;
        reply.member = member;
        reply.topicId = topicId;
        reply.topicTitle = topicTitle;
        reply.replyTime = replyTime;
        reply.contentRendered = contentRendered;
        [self.replyList addObject:reply];
    }
    self.replyListHolder = [NSArray arrayWithArray:self.replyList];
    [self.tableView reloadData];
}

#pragma mark MJRefresh
- (void)setRefresh
{
    // 下拉刷新
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadAllData)];
    [header setTitle:@"Pull down to refresh" forState:MJRefreshStateIdle];
    [header setTitle:@"Release to refresh" forState:MJRefreshStatePulling];
    [header setTitle:@"Loading ..." forState:MJRefreshStateRefreshing];
    self.tableView.mj_header = header;
    // 上拉更多
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [footer setTitle:@"Click or drag up to refresh" forState:MJRefreshStateIdle];
    [footer setTitle:@"Loading more ..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"No more data" forState:MJRefreshStateNoMoreData];
    self.tableView.mj_footer = footer;
}

#pragma mark Actions
- (void)reloadAllData
{
    [self resetPageStatus];
    [self crawlHtmlAndParse:NOTIFICATION_URL];
    [self.tableView.mj_header endRefreshing];
}

- (void)loadMoreData
{
    if (currentPage < totalPage)
    {
        currentPage ++;
        // 解析其他页
        NSString *page = [NSString stringWithFormat:@"?p=%d", currentPage];
        [self.manager GET:[NOTIFICATION_URL stringByAppendingString:page] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSString *pageHtmlStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            [self parseHtml:pageHtmlStr];
            [self.tableView.mj_footer endRefreshing];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD showErrorWithStatus:@"加载失败"];
        }];
    }
    else
    {
        [self.tableView.mj_footer endRefreshing];
    }
    //[self.tableView reloadData];
}

- (void)resetPageStatus
{
    totalPage = 1;
    currentPage = 1;
}

@end
