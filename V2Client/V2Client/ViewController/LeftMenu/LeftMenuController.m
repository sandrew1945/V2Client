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
#import "LoginViewController.h"

@interface LeftMenuController ()

@end

@implementation LeftMenuController

static NSInteger CELL_INDEX_USER_HEADER = 0;
static NSInteger CELL_INDEX_USER_SETTING = 1;
static NSInteger CELL_INDEX_NODE = 2;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = V2exColor.v2_backgroundColor;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[UserHeaderCell class] forCellReuseIdentifier:USER_HEADER_CELL];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:USER_SETTING_CELL];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NODE_CELL];
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
            // Configure the cell...
            return cell;
        }
        case 1:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:USER_SETTING_CELL forIndexPath:indexPath];
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:USER_SETTING_CELL];
            }
            // Configure the cell...
            
            return cell;
        }
        case 2:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NODE_CELL forIndexPath:indexPath];
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NODE_CELL];
            }
            // Configure the cell...
            return cell;
        }
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([indexPath section]) {
        case 0:
        {
            if (![[V2exUser shareInstance] isLogin])
            {
                LoginViewController *loginViewController = [[LoginViewController alloc] init];
                [[V2exControllerHolder shareInstance].centerViewController presentViewController:loginViewController animated:YES completion:nil];
            }
        }
        default:
            break;
    }
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

@end
