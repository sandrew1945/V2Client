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
        _userNameLabel.text = @"123123";
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
        
        FBKVOController *KVOController = [FBKVOController controllerWithObserver:self];
        self.KVOController = KVOController;
        [self.KVOController observe:[V2exUser shareInstance] keyPath:@"userName" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
            self.userNameLabel.text = [V2exUser shareInstance].userName ? [V2exUser shareInstance].userName : @"请登录";
            
        }];
        
    }
    return self;
}

@end
