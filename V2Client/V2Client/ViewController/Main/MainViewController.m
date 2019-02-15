//
//  MainViewController.m
//  V2Client
//
//  Created by summer on 2019/1/22.
//  Copyright © 2019年 sandrew. All rights reserved.
//

#import "Constants.h"
#import "MainViewController.h"
#import "AFNetworking.h"
#import "Topic.h"
#import "Node.h"
#import "UIKit+AFNetworking.h"
#import "MainService.h"
#import "MainTableViewCell.h"
#import "DetailViewController.h"
#import "MJRefreshNormalHeader.h"
#import "MJRefreshGifHeader.h"
#import "MJRefreshAutoNormalFooter.h"
#import "MJRefreshAutoGifFooter.h"


@interface MainViewController ()

@end

@implementation MainViewController

-(instancetype)initWithStyle:(UITableViewStyle)style{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//    self.tableView.rowHeight = 44;
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self setRefresh];
    [self.tableView registerClass:[MainTableViewCell class] forCellReuseIdentifier:CELL_INDENTIFIER];
    [self getMainPageData];
}

#pragma mark - TableView delegate & datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.topics count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

static NSString *CELL_INDENTIFIER = @"reuseIdentifier";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    if (!cell)
    {
        cell = [[MainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_INDENTIFIER];
    }
    // Configure the cell...
    Topic *cellTopic = (Topic*)[self.topics objectAtIndex: [indexPath section]];
    // 头像
    NSURL *url = [NSURL URLWithString:[@"https:" stringByAppendingString:cellTopic.member.avatarNormal]];
    [cell.avatarImageView setImageWithURL:url placeholderImage:nil];
    // 发帖人
    cell.userName.text = cellTopic.member.username;
    // 最后回复人，回复时间
    MainService *mainService = [[MainService alloc] init];
    cell.lastReplyTime.text = [mainService handleTimeDifference:cellTopic.lastReplyTime];
    if (nil != cellTopic.lastReplyBy && cellTopic.lastReplyBy.length != 0)
    {
        cell.lastReplyBy.text = [@"•    最后回复 " stringByAppendingString:cellTopic.lastReplyBy];
    }
    
    // 标题
    cell.topic.numberOfLines = 0;
    cell.topic.text = cellTopic.title;
    // 节点名称
    cell.node.text = cellTopic.node.title;
    // 回复数
    cell.msgCount.text = cellTopic.replies;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    TopicDetailViewController *subViewController = [[TopicDetailViewController alloc] init];
    DetailViewController *subViewController = [[DetailViewController alloc] init];
    Topic *selectedTopic = [self.topics objectAtIndex:[indexPath section]];
    subViewController.topicId = selectedTopic.topicId;
    [self.navigationController pushViewController:subViewController animated:YES];
}

-(UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.0001f)];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001f;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.0001f)];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 200;
//}


#pragma mark - fetch data
- (void)getMainPageData
{
        if (!self.manager)
        {
            self.manager = [AFHTTPSessionManager manager];
        }
        [self.manager GET:ALL_TOPIC_URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            MainService *service = [[MainService alloc] init];
            [service topicHeadAdapterMapping];
            self.topics = [Topic mj_objectArrayWithKeyValuesArray:responseObject];
            [self.tableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error");
        }];
}

- (void)getMoreData
{
    // 将原帖子变为set
    NSSet *set = [[NSSet alloc] init];
    for (int i = 0; i < [self.topics count]; i++)
    {
        Topic *tmp = [self.topics objectAtIndex:i];
        set = [set setByAddingObject:tmp.topicId];
    }
    // 请求新的帖子
    if (!self.manager)
    {
        self.manager = [AFHTTPSessionManager manager];
    }
    [self.manager GET:ALL_TOPIC_URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MainService *service = [[MainService alloc] init];
        [service topicHeadAdapterMapping];
        NSMutableArray *moreTopics = [Topic mj_objectArrayWithKeyValuesArray:responseObject];
    // 与topics合并
        __block Topic *tmpTopic = nil;
        long moreTopicCount = [moreTopics count];
        for (long i = (moreTopicCount - 1); i >= 0; i--)
        {
            tmpTopic = [moreTopics objectAtIndex:i];
            if ([set containsObject:tmpTopic.topicId])
            {
                NSLog(@"i ====%ld", i);
                NSLog(@"moreTopics -------- %ld", [moreTopics count]);
                [moreTopics removeObject:tmpTopic];
            }
        }
        [self.topics addObjectsFromArray:moreTopics];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error");
    }];
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
    [self getMainPageData];
    [self.tableView.mj_header endRefreshing];
}

- (void)loadMoreData
{
    NSLog(@"loading more ..............");
    [self getMoreData];
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
