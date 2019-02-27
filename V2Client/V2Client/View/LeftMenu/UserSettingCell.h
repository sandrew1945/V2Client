//
//  UserSettingCell.h
//  V2Client
//
//  Created by summer on 2019/2/18.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserSettingCell : UITableViewCell

@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) UIImage     *iconImage;
@property (strong, nonatomic) UILabel     *title;

- (void)bindDate:(NSString *)iconName WithTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
