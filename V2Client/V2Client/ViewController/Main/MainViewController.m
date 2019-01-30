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

@interface MainViewController ()

@end

@implementation MainViewController

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
//    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return [self.topics count];
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
    subViewController.topicId = selectedTopic.id;
    [self.navigationController pushViewController:subViewController animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return @" ";
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 200;
//}


#pragma mark - fetch data
- (void)getMainPageData
{
        self.manager = [AFHTTPSessionManager manager];
        [self.manager GET:ALL_TOPIC_URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@---%@",[responseObject class],responseObject);
            MainService *service = [[MainService alloc] init];
            [service topicHeadAdapterMapping];
            self.topics = [Topic mj_objectArrayWithKeyValuesArray:responseObject];
            NSLog(@"%@---%@",[self.topics class], self.topics);
            [self.tableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error");
        }];
}
#pragma mark MJRefresh
- (void)setRefresh
{
    MJRefreshGifHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [header setTitle:@"Pull down to refresh" forState:MJRefreshStateIdle];
    [header setTitle:@"Release to refresh" forState:MJRefreshStatePulling];
    [header setTitle:@"Loading ..." forState:MJRefreshStateRefreshing];
    self.tableView.header = header;
    
}

#pragma mark Actions
- (void)loadMoreData
{
    NSLog(@"loading ..............");
    [self getMainPageData];
    [self.tableView.mj_header endRefreshing];
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
