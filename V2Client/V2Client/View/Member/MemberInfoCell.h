//
//  MemberInfoCell.h
//  V2Client
//
//  Created by summer on 2019/2/20.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Member.h"

NS_ASSUME_NONNULL_BEGIN

@interface MemberInfoCell : UITableViewCell

@property (strong, nonatomic) UIImageView   *avatarView;
@property (strong, nonatomic) UILabel       *usernameLabel;
@property (strong, nonatomic) UILabel       *introdLabel;

- (void)initByMember:(Member *)member;
@end

NS_ASSUME_NONNULL_END
