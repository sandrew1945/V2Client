//
//  LeftMenuController.m
//  V2Client
//
//  Created by summer on 2019/2/12.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import "LeftMenuController.h"
#import "V2exColor.h"
#import "V2exUser.h"
#import "V2exControllerHolder.h"
#import "UserHeaderCell.h"
#import "UserSettingCell.h"
#import "LoginViewController.h"
#import "Masonry.h"
#import "MyViewController.h"
#import "NotificationViewController.h"
#import "FavoritesViewController.h"

@interface LeftMenuController ()

@end

@implementation LeftMenuController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = V2exColor.v2_backgroundColor;
    
    [self setup:self.backgroundView Cover:self.frostedView WithImage:@"32.jpg" WithFrame:self.view.frame In:self.view];
    [self setupTable];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger sectionCountArray[] = {1,3,2};
    return sectionCountArray[section];
}

static NSString *USER_HEADER_CELL = @"userHeaderCellIdentifier";
static NSString *USER_SETTING_CELL = @"userSettingCellIdentifier";
static NSString *NODE_CELL = @"nodeCellIdentifier";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([indexPath section])
    {
        case 0:
        {
            UserHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:USER_HEADER_CELL forIndexPath:indexPath];
            if (!cell)
            {
                cell = [[UserHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:USER_HEADER_CELL];
            }
            return cell;
        }
        case 1:
        {
            UserSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:USER_SETTING_CELL forIndexPath:indexPath];
            if (!cell)
            {
                cell = [[UserSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:USER_SETTING_CELL];
            }
            switch ([indexPath row]) {
                case 0:
                    [cell bindDate:@"ic_face" WithTitle:@"My Center"];
                    break;
                case 1:
                    [cell bindDate:@"ic_notifications_none" WithTitle:@"Notifications"];
                    break;
                case 2:
                    [cell bindDate:@"ic_turned_in" WithTitle:@"Favorite"];
                    break;
            }
            return cell;
        }
        case 2:
        {
            UserSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:NODE_CELL forIndexPath:indexPath];
            if (!cell)
            {
                cell = [[UserSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NODE_CELL];
            }
            switch ([indexPath row]) {
                case 0:
                    [cell bindDate:@"ic_navigation" WithTitle:@"Nodes"];
                    break;
                case 1:
                    [cell bindDate:@"ic_settings_input_svideo" WithTitle:@"More"];
                    break;
            }
            return cell;
        }
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch ([indexPath section]) {
        case 0:
        {
            if (![[V2exUser shareInstance] isLogin])
            {
                [self showLogin];
            }
            else
            {
                [self showMyCenter];
            }
            break;
        }
        case 1:
        {
            if (![[V2exUser shareInstance] isLogin])
            {
                [self showLogin];
                break;
            }
            else
            {
                switch ([indexPath row]) {
                    case 0:
                    {
                        [self showMyCenter];
                        break;
                    }
                    case 1:
                    {
                        [self showNotification];
                        break;
                    }
                    case 2:
                    {
                        [self showFavorites];
                        break;
                    }
                }
            }
        }
        case 2:
        {
            if (![[V2exUser shareInstance] isLogin])
            {
                [self showLogin];
                break;
            }
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 0;
        case 1:
            return 0;
        default:
            return 10;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @" ";
}

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

#pragma mark - layout
// 加载背景
- (void)setup:(UIImageView *)backgroundView Cover:(UIVisualEffectView *)frostedView WithImage:(NSString *)imageName WithFrame:(CGRect)frame In:(UIView *)parentView
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
// 加载tableview
- (void)setupTable
{
    self.tableView = [[UITableView alloc] init];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[UserHeaderCell class] forCellReuseIdentifier:USER_HEADER_CELL];
    [self.tableView registerClass:[UserSettingCell class] forCellReuseIdentifier:USER_SETTING_CELL];
    [self.tableView registerClass:[UserSettingCell class] forCellReuseIdentifier:NODE_CELL];
    [self.visualEffectView.contentView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.visualEffectView.mas_centerY);
        make.left.equalTo(self.visualEffectView.mas_left);
        //make.centerY.equalTo(self.visualEffectView.mas_centerY);
        make.width.equalTo(@180);
        make.height.equalTo(self.visualEffectView.mas_height);
    }];
}

#pragma mark - Actions
- (void)showMyCenter
{
    MemberViewController *memberViewController = [[MemberViewController alloc] init];
    memberViewController.memberName = [V2exUser shareInstance].userName;
    memberViewController.title = [V2exUser shareInstance].userName;
    [[V2exControllerHolder shareInstance].centerViewController pushViewController:memberViewController animated:YES];
    [[V2exControllerHolder shareInstance].drawerController closeDrawerAnimated:YES completion:nil];
}

- (void)showLogin
{
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    [[V2exControllerHolder shareInstance].centerViewController presentViewController:loginViewController animated:YES completion:nil];
}

- (void)showNotification
{
    NotificationViewController *notificationViewController = [[NotificationViewController alloc] init];
    [[V2exControllerHolder shareInstance].centerViewController pushViewController:notificationViewController animated:YES];
    [[V2exControllerHolder shareInstance].drawerController closeDrawerAnimated:YES completion:nil];
}

- (void)showFavorites
{
    FavoritesViewController *favoritesViewController = [[FavoritesViewController alloc] init];
    [[V2exControllerHolder shareInstance].centerViewController pushViewController:favoritesViewController animated:YES];
    [[V2exControllerHolder shareInstance].drawerController closeDrawerAnimated:YES completion:nil];
}
@end
