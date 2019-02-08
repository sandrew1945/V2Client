//
//  MainViewController.h
//  V2Client
//
//  Created by summer on 2019/1/22.
//  Copyright © 2019年 sandrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray        *topics;
@property (strong, nonatomic) AFHTTPSessionManager  *manager;

@end

NS_ASSUME_NONNULL_END
