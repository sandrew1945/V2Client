//
//  UserHeaderCell.m
//  V2Client
//
//  Created by summer on 2019/2/12.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import "UserHeaderCell.h"
#import "Masonry.h"
#import "FBKVOController.h"
#import "KVOController.h"
#import "V2exUser.h"
#import "UIKit+AFNetworking.h"
#import "Constants.h"

@implementation UserHeaderCell


- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!_avatar)
        {
            _avatar = [[UIImageView alloc] init];
            _avatar.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.3];
            _avatar.layer.borderWidth = 1.5;
            _avatar.layer.borderColor = [[UIColor colorWithWhite:1 alpha:0.6] CGColor];
            _avatar.layer.masksToBounds = true;
            _avatar.layer.cornerRadius = 38;
            _avatar.image = nil;
        }
        if (!_userNameLabel)
        {
            _userNameLabel = [[UILabel alloc] init];
            [_userNameLabel sizeToFit];
        }
        [self addSubview:_avatar];
        [self addSubview:_userNameLabel];
        
        [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY).with.offset(-8);
            //make.top.equalTo(self.mas_top).with.offset(20);
            make.width.height.equalTo([NSNumber numberWithDouble:(self.avatar.layer.cornerRadius * 2)]);
        }];
        [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.avatar.mas_bottom).with.offset(10);
            make.bottom.equalTo(self.mas_bottom).with.offset(-20);
        }];
        if ([[NSUserDefaults standardUserDefaults] objectForKey:APP_AVATAR_PATH_KEY])
        {
            [V2exUser shareInstance].avatarPath = [[NSUserDefaults standardUserDefaults] objectForKey:APP_AVATAR_PATH_KEY];
        }
        if ([[NSUserDefaults standardUserDefaults] objectForKey:APP_USER_NAME_KEY])
        {
            [V2exUser shareInstance].userName = [[NSUserDefaults standardUserDefaults] objectForKey:APP_USER_NAME_KEY];
        }

        [self setupKVO];
        
    }
    return self;
}


- (void)setupKVO
{
    FBKVOController *KVOController = [FBKVOController controllerWithObserver:self];
    self.KVOController = KVOController;
    [self.KVOController observe:[V2exUser shareInstance] keyPath:@"userName" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        self.userNameLabel.text = [V2exUser shareInstance].userName ? [V2exUser shareInstance].userName : @"请登录";
        if (nil != [V2exUser shareInstance].avatarPath && [V2exUser shareInstance].avatarPath.length > 0)
        {
            NSURL *url = [NSURL URLWithString:[V2exUser shareInstance].avatarPath];
            [self.avatar setImageWithURL:url placeholderImage:nil];
        }
    }];
}
@end
