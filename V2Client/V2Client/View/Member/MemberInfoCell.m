//
//  MemberInfoCell.m
//  V2Client
//
//  Created by summer on 2019/2/20.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import "MemberInfoCell.h"
#import "UIKit+AFNetworking.h"
#import "Masonry.h"

@implementation MemberInfoCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
    }
    [self setup];
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

#pragma mark - Layout
- (void)setup
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!self.avatarView)
    {
        self.avatarView = [[UIImageView alloc] init];
    }
    self.avatarView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.3];
    self.avatarView.layer.borderWidth = 1.5;
    self.avatarView.layer.borderColor = [[UIColor colorWithWhite:1 alpha:0.6] CGColor];
    self.avatarView.layer.masksToBounds = true;
    self.avatarView.layer.cornerRadius = 38;
    [self addSubview:self.avatarView];
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).with.offset(10);
        make.width.height.equalTo([NSNumber numberWithDouble:(self.avatarView.layer.cornerRadius * 2)]);
    }];
    
    if (!self.usernameLabel)
    {
        self.usernameLabel = [[UILabel alloc] init];
    }
    self.usernameLabel.textColor = [UIColor whiteColor];
    [self.usernameLabel sizeToFit];
    [self addSubview:self.usernameLabel];
    [self.usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.avatarView.mas_bottom).with.offset(10);
    }];
    
    if (!self.introdLabel)
    {
        self.introdLabel = [[UILabel alloc] init];
    }
    [self.introdLabel sizeToFit];
    [self.introdLabel setNumberOfLines:0];
    self.introdLabel.textAlignment = NSTextAlignmentCenter;
    self.introdLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.introdLabel];
    [self.introdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.usernameLabel.mas_bottom).with.offset(10);
        make.width.equalTo(self.mas_width).with.offset(-20);
        make.bottom.equalTo(self.mas_bottom).with.offset(-30);
    }];
}

#pragma mark - Data bind
- (void)initByMember:(Member *)member
{
    if (member)
    {
        if (member.avatarLarge)
        {
            NSURL *url = [NSURL URLWithString:member.avatarLarge];
            [self.avatarView setImageWithURL:url placeholderImage:nil];
        }
        self.usernameLabel.text = member.username;
        self.introdLabel.text = member.introd;
    }
    
}
@end
