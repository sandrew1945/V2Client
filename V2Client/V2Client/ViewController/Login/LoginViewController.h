//
//  LoginViewController.h
//  V2Client
//
//  Created by summer on 2019/2/13.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : UIViewController

@property (strong, nonatomic) UIImageView           *backgroundView;
@property (strong, nonatomic) UIVisualEffectView    *frostedView;
@property (strong, nonatomic) UITextField           *userName;
@property (strong, nonatomic) UITextField           *password;
@property (strong, nonatomic) UITextField           *validateCode;
@property (strong, nonatomic) UIImageView           *validateCodeView;
@property (strong, nonatomic) AFHTTPSessionManager  *manager;

@property (strong, nonatomic) NSString              *userNameInputName;
@property (strong, nonatomic) NSString              *passwordInputName;
@property (strong, nonatomic) NSString              *validaCodeInputName;
@property (strong, nonatomic) NSString              *once;

@end

NS_ASSUME_NONNULL_END
