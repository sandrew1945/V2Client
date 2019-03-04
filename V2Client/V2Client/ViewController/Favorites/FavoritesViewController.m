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

@interface FavoritesViewController ()

@end

@implementation FavoritesViewController
static NSString *CELL_IDENTIFIER = @"reuseIdentifier";
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[MainTableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    [cell initByTopic:[self.topicList objectAtIndex:[indexPath row]]];
    return cell;
}

#pragma mark - Handle Data
- (void)crawlHtmlAndParse:(NSString *)url
{
    self.topicList = [[NSMutableArray alloc] init];
    [SVProgressHUD showWithStatus:@"加载中"];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    NSDictionary *params = [[NSDictionary alloc] init];
    [params setValue:@"Mozilla/5.0 (iPhone; CPU iPhone OS 8_0 like Mac OS X) AppleWebKit/600.1.3 (KHTML, like Gecko) Version/8.0 Mobile/12A4345d Safari/600.1.4" forKey:@"user-agent"];
    [V2exUtil get:FAVORITES_URL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //解析html
        NSString * htmlStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"response html : %@", htmlStr);
        // 获取页数
        //totalPage = [self parsePageCount:htmlStr];
        // 解析第一页
        [self parseHtml:htmlStr];
        [SVProgressHUD dismiss];
    }];
}

- (void)parseHtml:(NSString *)html
{
    
}
@end
