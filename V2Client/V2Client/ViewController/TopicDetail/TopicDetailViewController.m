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
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerClass:[TopicDetailCell class] forCellReuseIdentifier:TOPIC_CELL_INDENTIFIER];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:REPLIES_CELL_INDENTIFIER];
    [self getTopicDataById:self.topicId];
}


#pragma mark - TableView delegate & datasource
static NSString *TOPIC_CELL_INDENTIFIER = @"topic_reuseIdentifier";
static NSString *REPLIES_CELL_INDENTIFIER = @"replies_reuseIdentifier";
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {

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
                NSURL *url = [NSURL URLWithString:[@"https:" stringByAppendingString:self.topic.member.avatarNormal]];
                [topicCell.avatarImageView setImageWithURL:url placeholderImage:nil];
                // 发帖人
                topicCell.userName.text = self.topic.member.username;
                // 标题
                topicCell.topic.numberOfLines = 0;
                topicCell.topic.text = self.topic.title;
                // 节点名称
                topicCell.node.text = self.topic.node.title;
            }
            return topicCell;
        }
        default:
        {
            UITableViewCell *repliesCell = [tableView dequeueReusableCellWithIdentifier:REPLIES_CELL_INDENTIFIER forIndexPath:indexPath];
            return repliesCell;
        }
            
    }
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
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error");
    }];
}




@end
