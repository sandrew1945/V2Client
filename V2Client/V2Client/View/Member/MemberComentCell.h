//
//  MemberComentCell.h
//  V2Client
//
//  Created by summer on 2019/2/22.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reply.h"

NS_ASSUME_NONNULL_BEGIN

@interface MemberComentCell : UITableViewCell

@property (strong, nonatomic) UILabel   *topicTitleLabel;
@property (strong, nonatomic) UIView    *commentPanel;
@property (strong, nonatomic) UILabel   *commentLabel;

- (void)initByReply:(Reply *)reply;
@end

NS_ASSUME_NONNULL_END
