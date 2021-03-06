//
//  FavoritesViewController.h
//  V2Client
//
//  Created by summer on 2019/3/4.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Topic.h"

NS_ASSUME_NONNULL_BEGIN

@interface FavoritesViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray<Topic *>   *topicList;
@property (strong, nonatomic) NSArray<Topic *>          *topicListHolder;

@end

NS_ASSUME_NONNULL_END
