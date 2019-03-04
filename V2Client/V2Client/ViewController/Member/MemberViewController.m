//
//  MemberViewController.m
//  V2Client
//
//  Created by summer on 2019/2/19.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import "MemberViewController.h"
#import "MemberInfoCell.h"
#import "V2exColor.h"
#import <HBDNavigationBar/UIViewController+HBD.h>
#import "SVProgressHUD.h"
#import "Constants.h"
#import "TFHpple.h"
#import "V2exUtil.h"
#import "Topic.h"
#import "Node.h"
#import "Member.h"
#import "MemberTopicCell.h"
#import "Masonry.h"
#import "MemberComentCell.h"
#import "DetailViewController.h"

@interface MemberViewController ()

@end

@implementation MemberViewController
{
    CGFloat _gradientProgress;
}

static NSString *CELL_MEMBER_INFO = @"memberInfoIdentifier";
static NSString *CELL_MEMBER_POST = @"memberPostIdentifier";
static NSString *CELL_MEMBER_REPLY = @"memberReplyIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    // 隐藏NavigationBar的title
    self.hbd_titleTextAttributes = @{ NSForegroundColorAttributeName: [UIColor.blackColor colorWithAlphaComponent:0] };
    // 设置NavigationBar alpha变化过程高度
    _gradientProgress = 100;
    // 初始化对象
    if (!self.member)
    {
        self.member = [[Member alloc] init];
    }
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
    [self setup];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
    // 加载数据
    [self crawlHtmlAndParse:[MEMBER_INFO_URL stringByAppendingString:self.memberName]];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
        case 1:
            return [self.topicList count];
        default:
            return [self.replyList count];
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *headLabel = [[UILabel alloc] init];
    headLabel.font = [UIFont systemFontOfSize:14];
    [headLabel sizeToFit];
    UIView *headView = [[UIView alloc] init];
    [headView addSubview:headLabel];
    [headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headView.mas_centerY);
        make.left.equalTo(headView.mas_left).with.offset(10);
    }];
    switch (section) {
        case 1:
            {
                headLabel.text = @"Posts";
                headView.backgroundColor = [UIColor whiteColor];
                break;
            }
        case 2:
            {
                headLabel.text = @"Comments";
                headView.backgroundColor = [UIColor whiteColor];
                break;
            }
    }
    return headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch ([indexPath section]) {
        case 0:
        {
            MemberInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_MEMBER_INFO forIndexPath:indexPath];
            [cell initByMember:self.member];
            return cell;
        }
        case 1:
        {
            MemberTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_MEMBER_POST forIndexPath:indexPath];
            [cell initByTopic:[self.topicList objectAtIndex:[indexPath row]]];
            return cell;
        }
        default:
        {
            MemberComentCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_MEMBER_REPLY forIndexPath:indexPath];
            [cell initByReply:[self.replyList objectAtIndex:[indexPath row]]];
            return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *topicId = nil;
    switch ([indexPath section]) {
        case 0:
        {
            return;
        }
        case 1:
        {
            topicId = [self.topicList objectAtIndex:[indexPath row]].topicId;
            break;
        }
        case 2:
        {
            topicId = [self.replyList objectAtIndex:[indexPath row]].topicId;
            break;
        }
        default:
            break;
    }
    DetailViewController *subViewController = [[DetailViewController alloc] init];
    subViewController.title = @"Topic Details";
    subViewController.topicId = topicId;
    [self.navigationController pushViewController:subViewController animated:YES];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 320;
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //[self changeNavigationBarTintColor];
    CGFloat offsetY = self.tableView.contentOffset.y;
    CGFloat y = _gradientProgress - offsetY;
    if (offsetY < 0)
    {
        y = _gradientProgress - 0;
    }
    else if (offsetY > _gradientProgress)
    {
        y = _gradientProgress - _gradientProgress;
    }
    CGFloat alpha = 1 - (y * (1/_gradientProgress));
    //NSLog(@"-----------------------%f", alpha);

    if (alpha < 0.1) {
        self.hbd_barStyle = UIBarStyleBlack;
        self.hbd_tintColor = UIColor.whiteColor;
        self.hbd_titleTextAttributes = @{ NSForegroundColorAttributeName: [UIColor.blackColor colorWithAlphaComponent:0] };
    } else {
        self.hbd_barStyle = UIBarStyleDefault;
        self.hbd_tintColor = UIColor.blackColor;
        self.hbd_titleTextAttributes = @{ NSForegroundColorAttributeName: [UIColor.blackColor colorWithAlphaComponent:alpha] };
    }
    
    self.hbd_barAlpha = alpha;
    [self hbd_setNeedsUpdateNavigationBar];

}

#pragma mark - Layout
- (void)setup
{
    // 加载背景
    [self setupBackgroundViewWithImage:@"32.jpg" WithFrame:self.view.frame In:self.view];
    // 加载table
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.estimatedRowHeight = 50;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerClass:[MemberInfoCell class] forCellReuseIdentifier:CELL_MEMBER_INFO];
    [self.tableView registerClass:[MemberTopicCell class] forCellReuseIdentifier:CELL_MEMBER_POST];
    [self.tableView registerClass:[MemberComentCell class] forCellReuseIdentifier:CELL_MEMBER_REPLY];
}

// 加载背景
- (void)setupBackgroundViewWithImage:(NSString *)imageName WithFrame:(CGRect)frame In:(UIView *)parentView
{
    if (!self.backgroundView)
    {
        self.backgroundView = [[UIImageView alloc] init];
    }
    self.backgroundView.image = [UIImage imageNamed:imageName];
    self.backgroundView.frame = frame;
    self.backgroundView.contentMode = UIViewContentModeScaleToFill;
    self.backgroundView.alpha = 1;
    [self.backgroundView.layer setMasksToBounds:YES];
    [parentView addSubview:self.backgroundView];
    if (!self.frostedView)
    {
        self.frostedView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    }
    self.frostedView.frame = frame;
    [parentView addSubview:self.frostedView];
    UIVibrancyEffect *blurEffect = [UIVibrancyEffect effectForBlurEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    if (!self.visualEffectView)
    {
        self.visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    }
    self.visualEffectView.userInteractionEnabled = true;
    self.visualEffectView.frame = frame;
    [self.frostedView.contentView addSubview:self.visualEffectView];
}

#pragma mark - Handle Data
- (void)crawlHtmlAndParse:(NSString *)url
{
    [SVProgressHUD showWithStatus:@"加载中"];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [self.manager.requestSerializer setValue:@"Mozilla/5.0 (iPhone; CPU iPhone OS 8_0 like Mac OS X) AppleWebKit/600.1.3 (KHTML, like Gecko) Version/8.0 Mobile/12A4345d Safari/600.1.4" forHTTPHeaderField:@"user-agent"];
    [self.manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        // 解析html
        NSString * htmlStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        TFHpple *htmlParser = [[TFHpple alloc] initWithHTMLData:[htmlStr dataUsingEncoding:NSUTF8StringEncoding]];
        //NSLog(@"response html : %@", htmlStr);
        // 获取头像url
        NSString *avatarUrl = [@"https:" stringByAppendingString:[V2exUtil getAttribute:@"src" FromParse:htmlParser ByXPath:@"//*[@id='Wrapper']/div/div[1]/div/table/tr/td[1]/img"]];
        // 获取简介
        NSString *introd = [V2exUtil getContentFromParse:htmlParser ByXpath:@"//*[@id='Wrapper']/div/div[1]/div/table/tr/td[3]/span[1]"];
//        NSLog(@"avatar ==============%@", avatarUrl);
//        NSLog(@"introduce ===========%@", introd);
        self.member.avatarLarge = avatarUrl;
        self.member.username = self.memberName;
        self.member.introd = introd;
        
        //解析发帖
        if (!self.topicList)
        {
            self.topicList = [[NSMutableArray alloc] init];
        }
        NSArray *topicNodeList = [V2exUtil getElementsFromParse:htmlParser ByXpath:@"//*[@class='cell item']"];
        for (TFHppleElement *element in topicNodeList) {
//            NSLog(@"topic id----------- %@", [[V2exUtil getAttribute:@"href" FromElement:element ByXPath:@"//table/tr/td[1]/span[2]/a[1]"] substringWithRange:NSMakeRange(3, 6)]);
//            NSLog(@"topic title----------- %@", [V2exUtil getContentFromElement:element ByXpath:@"//table/tr/td[1]/span[2]/a[1]"]);
//            NSLog(@"topic reply time----------- %@", [V2exUtil getContentFromElement:element ByXpath:@"//table/tr/td[1]/span[3]"]);
//            NSLog(@"topic reply by----------- %@", [V2exUtil getContentFromElement:element ByXpath:@"//table/tr/td[1]/span[3]/strong/a[1]"]);
//            NSLog(@"topic reply count----------- %@", [V2exUtil getContentFromElement:element ByXpath:@"//table/tr/td[2]/a[1]"]);
//            NSLog(@"node title----------- %@", [V2exUtil getContentFromElement:element ByXpath:@"//table/tr/td[1]/span[1]/a[1]"]);
            
            Topic *topic = [[Topic alloc] init];
            [topic setTopicId:[[V2exUtil getAttribute:@"href" FromElement:element ByXPath:@"//table/tr/td[1]/span[2]/a[1]"] substringWithRange:NSMakeRange(3, 6)]];
            [topic setTitle:[V2exUtil getContentFromElement:element ByXpath:@"//table/tr/td[1]/span[2]/a[1]"]];
            [topic setReplies:[V2exUtil getContentFromElement:element ByXpath:@"//table/tr/td[2]/a[1]"]];
            [topic setLastReplyTime:[V2exUtil getContentFromElement:element ByXpath:@"//table/tr/td[1]/span[3]"]];
            Node *node = [[Node alloc] init];
            [node setTitle:[V2exUtil getContentFromElement:element ByXpath:@"//table/tr/td[1]/span[1]/a[1]"]];
            [topic setNode:node];
            [self.topicList addObject:topic];
        }
        //解析回复的主题
        if (!self.replyList)
        {
            self.replyList = [[NSMutableArray alloc] init];
        }
        NSArray *replyTopicNodeList = [V2exUtil getElementsFromParse:htmlParser ByXpath:@"//*[@class='dock_area']"];
        for (int i = 0; i < [replyTopicNodeList count]; i++) {
            TFHppleElement *element = [replyTopicNodeList objectAtIndex:i];
//            NSLog(@"topic id----------- %@", [[V2exUtil getAttribute:@"href" FromElement:element ByXPath:@"//table/tr/td[1]/span[1]/a[1]"] substringWithRange:NSMakeRange(3, 6)]);
//            NSLog(@"topic title----------- %@", [V2exUtil getContentFromElement:element ByXpath:@"//table/tr/td[1]/span[1]/a[1]"]);
//            NSLog(@"reply content----------- %@", [[[V2exUtil getElementsFromParse:htmlParser ByXpath:@"//*[@class='reply_content']"] objectAtIndex:i] content]);
            Reply *reply = [[Reply alloc] init];
            reply.topicId = [[V2exUtil getAttribute:@"href" FromElement:element ByXPath:@"//table/tr/td[1]/span[1]/a[1]"] substringWithRange:NSMakeRange(3, 6)];
            reply.topicTitle = [V2exUtil getContentFromElement:element ByXpath:@"//table/tr/td[1]/span[1]/a[1]"];
            reply.contentRendered = [[[V2exUtil getElementsFromParse:htmlParser ByXpath:@"//*[@class='reply_content']"] objectAtIndex:i] content];
            [self.replyList addObject:reply];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}
@end
