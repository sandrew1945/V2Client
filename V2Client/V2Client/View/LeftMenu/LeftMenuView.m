//
//  LeftMenuView.m
//  V2Client
//
//  Created by summer on 2019/2/11.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import "LeftMenuView.h"
#import "Masonry.h"

@interface LeftMenuView()
@end
@implementation LeftMenuView


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        UIButton *btn1 = [[UIButton alloc] init];
        [btn1 setTitle:@"测试" forState:UIControlStateNormal];
        btn1.tag = 1;
        [btn1 sizeToFit];
        [self addSubview:btn1];
    }
    return self;
}

- (void)layoutSubviews
{
    self.backgroundColor = [UIColor grayColor];
    UIView *v1 = [self viewWithTag:1];
    [v1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
}

@end
