//
//  LeftMenuController.h
//  V2Client
//
//  Created by summer on 2019/2/12.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LeftMenuController : UIViewController <UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) UIVisualEffectView    *frostedView;
@property (strong, nonatomic) UIImageView           *backgroundView;
@property (strong, nonatomic) UIVisualEffectView    *visualEffectView;
@property (strong, nonatomic) UITableView           *tableView;

@end

NS_ASSUME_NONNULL_END
