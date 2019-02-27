//
//  UserSettingCell.m
//  V2Client
//
//  Created by summer on 2019/2/18.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import "UserSettingCell.h"
#import "Masonry.h"
#import "V2exColor.h"

@implementation UserSettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    UIView *panel = [[UIView alloc] init];
    panel.backgroundColor = [UIColor colorWithRed:115 green:115 blue:115 alpha:0.5];
    [self.contentView addSubview:panel];
    [panel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.contentView);
    }];
    
    if (!self.iconImage)
    {
        self.iconImage = [[UIImage alloc] init];
        self.iconView.tintColor = [UIColor blackColor];
//        self.iconView.image = [self.iconImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    if (!self.iconView)
    {
        self.iconView = [[UIImageView alloc] init];
        self.iconView.alpha = 0.1;
        self.iconView.tintColor = [V2exColor v2_LeftNodeTintColor];
    }
    self.iconView.image = self.iconImage;
    [panel addSubview:self.iconView];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(panel.mas_centerY);
        make.left.equalTo(panel.mas_left).with.offset(10);
        make.width.height.equalTo(@30);
    }];
    if (!self.title)
    {
        self.title = [[UILabel alloc] init];
        self.title.font = [UIFont systemFontOfSize:16];
        self.title.textColor = [UIColor blackColor];
    }
    [panel addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(panel.mas_centerY);
        make.left.equalTo(self.iconView.mas_right).with.offset(15);
    }];
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Init Data
- (void)bindDate:(NSString *)iconName WithTitle:(NSString *)title
{
    self.iconImage = [UIImage imageNamed:iconName];
    self.iconImage = [self.iconImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.iconView.image = self.iconImage;
//    self.iconView.tintColor = [UIColor whiteColor];
//    [self.iconImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.title.text = title;
}

@end
