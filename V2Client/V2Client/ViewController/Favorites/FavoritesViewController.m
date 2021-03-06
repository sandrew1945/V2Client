//
//  FavoritesViewController.m
//  V2Client
//
//  Created by summer on 2019/3/4.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import "FavoritesViewController.h"
#import "MainTableViewCell.h"
#import "SVProgressHUD.h"
#import "V2exUtil.h"
#import "Constants.h"
#import "Member.h"
#import "Node.h"
#import "DetailViewController.h"
#import "MJRefreshGifHeader.h"
#import "MJRefreshAutoGifFooter.h"

@interface FavoritesViewController ()

@end

@implementation FavoritesViewController
{
    int totalPage;
    int currentPage;
}

static NSString *CELL_IDENTIFIER = @"reuseIdentifier";

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.tableView registerClass:[MainTableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER];
    // 设置下拉刷新，上拉更多
    totalPage = 1;
    currentPage = 1;
    [self setRefresh];
    // 解析数据
    [self crawlHtmlAndParse:FAVORITES_URL];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.topicListHolder count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    [cell initByTopic:[self.topicListHolder objectAtIndex:[indexPath row]]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *subViewController = [[DetailViewController alloc] init];
    subViewController.title = @"Topic Details";
    Topic *selectedTopic = [self.topicListHolder objectAtIndex:[indexPath row]];
    subViewController.topicId = selectedTopic.topicId;
    [self.navigationController pushViewController:subViewController animated:YES];
}

#pragma mark - Handle Data
- (void)crawlHtmlAndParse:(NSString *)url
{
    self.topicList = [[NSMutableArray alloc] init];
    [V2exUtil get:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //解析html
        NSString * htmlStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"response html : %@", htmlStr);
        // 获取页数
        totalPage = [self parsePageCount:htmlStr];
        // 解析第一页
        [self parseHtml:htmlStr];
        [SVProgressHUD dismiss];
    } withLoading:YES];
}

- (int)parsePageCount:(NSString *)html
{
    TFHpple *htmlParser = [[TFHpple alloc] initWithHTMLData:[html dataUsingEncoding:NSUTF8StringEncoding]];
    NSArray *elements = [V2exUtil getElementsFromParse:htmlParser ByXpath:@"//*[@class='page_normal']"];
    return ([elements count] / 2) + 1;
}

- (void)parseHtml:(NSString *)html
{
    TFHpple *htmlParser = [[TFHpple alloc] initWithHTMLData:[html dataUsingEncoding:NSUTF8StringEncoding]];
    NSArray *elements = [V2exUtil getElementsFromParse:htmlParser ByXpath:@"//*[@class='cell item']"];
    for (TFHppleElement *element in elements) {
        Topic *topic = [[Topic alloc] init];
        NSString *avatarPath = [@"https:" stringByAppendingString:[V2exUtil getAttribute:@"src" FromElement:element ByXPath:@"//table/tr/td[1]/a[1]/img[1]"]];
        NSString *memberName = [V2exUtil getContentFromElement:element ByXpath:@"//table/tr/td[3]/span[2]/strong[1]/a[1]"];
        NSString *topicTitle = [V2exUtil getContentFromElement:element ByXpath:@"//table/tr/td[3]/span[1]/a[1]"];
        NSString *topicId = [V2exUtil getAttribute:@"href" FromElement:element ByXPath:@"//table/tr/td[3]/span[1]/a[1]"];
        NSString *replyTime = [V2exUtil getContentFromElement:element ByXpath:@"//table/tr/td[3]/span[2]/strong[1]"];
        NSString *nodeName = [V2exUtil getContentFromElement:element ByXpath:@"//table/tr/td[3]/span[2]/a[1]"];
        NSString *replyCount = [V2exUtil getContentFromElement:element ByXpath:@"//table/tr/td[4]/a[1]"];
        Member *member = [[Member alloc] init];
        member.avatarNormal = avatarPath;
        member.username = memberName;
        topic.member = member;
        topic.topicId = [topicId substringWithRange:NSMakeRange(3, 6)];
        topic.title = topicTitle;
        topic.lastReplyTime = replyTime;
        topic.replies = replyCount;
        Node *node = [[Node alloc] init];
        node.title = nodeName;
        topic.node = node;
        [self.topicList addObject:topic];
    }
    self.topicListHolder = [NSArray arrayWithArray:self.topicList];
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
    NSLog(@"reloading ..............");
    [self resetPageStatus];
    [self crawlHtmlAndParse:FAVORITES_URL];
    [self.tableView.mj_header endRefreshing];
}

- (void)loadMoreData
{
    if (currentPage < totalPage)
    {
        currentPage ++;
        // 解析其他页
        NSString *page = [NSString stringWithFormat:@"?p=%d", currentPage];
        [V2exUtil get:[FAVORITES_URL stringByAppendingString:page] parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSString *pageHtmlStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            [self parseHtml:pageHtmlStr];
            [self.tableView.mj_footer endRefreshing];
        } withLoading:NO];
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
