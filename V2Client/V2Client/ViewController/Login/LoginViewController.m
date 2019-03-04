//
//  LoginViewController.m
//  V2Client
//
//  Created by summer on 2019/2/13.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import "LoginViewController.h"
#import "Masonry.h"
#import "Constants.h"
#import "TFHpple.h"
#import "V2exUser.h"
#import "SVProgressHUD.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 注册点击背景隐藏键盘功能
    [self hideKeyboardWhenBlur];
    [self setup];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    [UIView animateWithDuration:20 animations:^{
//        //        UIScreen.main.bounds.size.width
//
//        self.backgroundView.frame = CGRectMake((-1*( 1000 - UIScreen.mainScreen.bounds.size.width )/2), 0, UIScreen.mainScreen.bounds.size.height+500, UIScreen.mainScreen.bounds.size.width + 500);
//    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"opacity"];
//    ani.fromValue = @(0);
//    ani.toValue = @(1);
//    ani.duration = 2.f;
//    ani.fillMode = kCAFillModeForwards;
//    [self.backgroundView.layer addAnimation:ani forKey:nil];
    [UIView animateWithDuration:2 animations:^{
        self.backgroundView.alpha = 1;
    }];
}
#pragma mark - Layout
- (void)setup
{
    self.view.backgroundColor = [UIColor blackColor];

    self.backgroundView = [[UIImageView alloc] init];
    self.backgroundView.image = [UIImage imageNamed:@"32.jpg"];
    self.backgroundView.frame = self.view.frame;
    self.backgroundView.contentMode = UIViewContentModeCenter;
    self.backgroundView.alpha = 0;
    [self.backgroundView.layer setMasksToBounds:YES];
    [self.view addSubview:self.backgroundView];

    self.frostedView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    self.frostedView.frame = self.view.frame;
    [self.view addSubview:self.frostedView];
    UIVibrancyEffect *blurEffect = [UIVibrancyEffect effectForBlurEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    UIVisualEffectView * visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    visualEffectView.userInteractionEnabled = true;
    visualEffectView.frame = self.view.frame;
    [self.frostedView.contentView addSubview:visualEffectView];
    
    UILabel *v2exLabel = [[UILabel alloc] init];
    v2exLabel.text = @"Explore";
    v2exLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:25];
    [visualEffectView.contentView addSubview:v2exLabel];
    [v2exLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(visualEffectView.mas_centerX);
        make.top.equalTo(visualEffectView.mas_top).with.offset(40);
        //make.width.equalTo(@100);
        make.height.equalTo(@21);
    }];
    
    UILabel *subTitleLabel = [[UILabel alloc] init];
    subTitleLabel.font = [UIFont systemFontOfSize:13];
    subTitleLabel.text = @"创意者的工作社区";
    [visualEffectView.contentView addSubview:subTitleLabel];
    [subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(visualEffectView.mas_centerX);
        make.top.equalTo(v2exLabel.mas_bottom).with.offset(5);
    }];
    
    
    if (!self.userName)
    {
        self.userName = [[UITextField alloc] init];
        self.userName.autocorrectionType = UITextAutocorrectionTypeNo;
        self.userName.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.userName.textColor = [UIColor whiteColor];
        self.userName.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];
        self.userName.font = [UIFont systemFontOfSize:15];
        self.userName.layer.cornerRadius = 3;
        self.userName.layer.borderWidth = 0.5;
        self.userName.keyboardType = UIKeyboardTypeASCIICapable;
        self.userName.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.8].CGColor;
        self.userName.placeholder = @"用户名";
        self.userName.clearButtonMode = UITextFieldViewModeAlways;
        
        UIImage     *userNameIcon     = [UIImage imageNamed:@"ic_account_circle"];
        [userNameIcon imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImageView *userNameIconView = [[UIImageView alloc] initWithImage:userNameIcon];
        userNameIconView.frame = CGRectMake(0, 0, 34, 22);
        userNameIconView.tintColor = [UIColor whiteColor];
        userNameIconView.contentMode = UIViewContentModeScaleAspectFit;
        self.userName.leftView = userNameIconView;
        self.userName.leftViewMode = UITextFieldViewModeAlways;
        
        [visualEffectView.contentView addSubview:self.userName];
        [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(visualEffectView.mas_centerX);
            make.top.equalTo(subTitleLabel.mas_bottom).with.offset(30);
            make.width.equalTo(@300);
            make.height.equalTo(@38);
        }];
    }
    if (!self.password)
    {
        self.password = [[UITextField alloc] init];
        self.password.autocorrectionType = UITextAutocorrectionTypeNo;
        self.password.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.password.secureTextEntry = true;
        self.password.textColor = [UIColor whiteColor];
        self.password.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];
        self.password.font = [UIFont systemFontOfSize:15];
        self.password.layer.cornerRadius = 3;
        self.password.layer.borderWidth = 0.5;
        self.password.keyboardType = UIKeyboardTypeASCIICapable;
        self.password.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.8].CGColor;
        self.password.placeholder = @"密码";
        self.password.clearButtonMode = UITextFieldViewModeAlways;
        
        UIImage     *passwordIcon     = [UIImage imageNamed:@"ic_lock"];
        [passwordIcon imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImageView *passwordIconView = [[UIImageView alloc] initWithImage:passwordIcon];
        passwordIconView.frame = CGRectMake(0, 0, 34, 22);
        passwordIconView.tintColor = [UIColor whiteColor];
        passwordIconView.contentMode = UIViewContentModeScaleAspectFit;
        self.password.leftView = passwordIconView;
        self.password.leftViewMode = UITextFieldViewModeAlways;
        
        [visualEffectView.contentView addSubview:self.password];
        [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(visualEffectView.mas_centerX);
            make.top.equalTo(self.userName.mas_bottom).with.offset(15);
            make.width.equalTo(@300);
            make.height.equalTo(@38);
        }];
    }
    
    if (!self.validateCode)
    {
        self.validateCode = [[UITextField alloc] init];
        self.validateCode.autocorrectionType = UITextAutocorrectionTypeNo;
        self.validateCode.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.validateCode.textColor = [UIColor whiteColor];
        self.validateCode.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];
        self.validateCode.font = [UIFont systemFontOfSize:15];
        self.validateCode.layer.cornerRadius = 3;
        self.validateCode.layer.borderWidth = 0.5;
        self.validateCode.keyboardType = UIKeyboardTypeASCIICapable;
        self.validateCode.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.8].CGColor;
        self.validateCode.placeholder = @"验证码";
        self.validateCode.clearButtonMode = UITextFieldViewModeAlways;
        
        UIImage     *validateCodeIcon     = [UIImage imageNamed:@"ic_vpn_key"];
        [validateCodeIcon imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImageView *validateCodeView = [[UIImageView alloc] initWithImage:validateCodeIcon];
        validateCodeView.frame = CGRectMake(0, 0, 34, 22);
        validateCodeView.tintColor = [UIColor whiteColor];
        validateCodeView.contentMode = UIViewContentModeScaleAspectFit;
        self.validateCode.leftView = validateCodeView;
        self.validateCode.leftViewMode = UITextFieldViewModeAlways;
        
        [visualEffectView.contentView addSubview:self.validateCode];
        [self.validateCode mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.password.mas_left);
            make.top.equalTo(self.password.mas_bottom).with.offset(15);
            make.width.equalTo(@180);
            make.height.equalTo(@38);
        }];
    }
    
    
    if (!self.validateCodeView)
    {
        self.validateCodeView = [[UIImageView alloc] init];
        [visualEffectView.contentView addSubview:self.validateCodeView];
        [self.validateCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.validateCode.mas_right).with.offset(5);
            make.top.equalTo(self.password.mas_bottom).with.offset(15);
            make.right.equalTo(self.password.mas_right);
            make.height.equalTo(@38);
        }];
        [self.validateCodeView setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] init];
        [tgr addTarget:self action:@selector(reloadValidateCodeImage:)];
        [self.validateCodeView addGestureRecognizer:tgr];
    }
    
    UIButton *loginBtn = [[UIButton alloc] init];
    [loginBtn setTitle:@"登  录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    loginBtn.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.8].CGColor;
    loginBtn.layer.borderWidth = 0.5;
    loginBtn.layer.cornerRadius = 3;
    [visualEffectView.contentView addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(visualEffectView.mas_centerX);
        make.top.equalTo(self.validateCodeView.mas_bottom).with.offset(15);
        make.width.equalTo(@300);
        make.height.equalTo(@38);
    }];
    [loginBtn addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *remindLabel = [[UILabel alloc] init];
    remindLabel.text = @"验证码不显示？";
    remindLabel.font = [UIFont systemFontOfSize:12];
    remindLabel.alpha = 0.5;
    [remindLabel setUserInteractionEnabled:true];
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] init];
    [tgr addTarget:self action:@selector(remindCode:)];
    [remindLabel addGestureRecognizer:tgr];
    [visualEffectView.contentView addSubview:remindLabel];
    [remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(loginBtn.mas_right);
        make.top.equalTo(loginBtn.mas_bottom).with.offset(15);
    }];
    
    UILabel *footLabel = [[UILabel alloc] init];
    footLabel.text = @"Create by SuMMeR";
    footLabel.font = [UIFont systemFontOfSize:12];
    footLabel.alpha = 0.5;
    [visualEffectView.contentView addSubview:footLabel];
    [footLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(visualEffectView.mas_centerX);
        make.bottom.equalTo(visualEffectView.mas_bottom).with.offset(-20);
    }];
    
    UIButton *cancelBtn = [[UIButton alloc] init];
    cancelBtn.contentMode = UIViewContentModeCenter;
    [cancelBtn setImage:[[UIImage imageNamed:@"ic_cancel"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [visualEffectView.contentView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(footLabel.mas_centerY);
        make.right.equalTo(visualEffectView.mas_right).with.offset(-5);
        make.width.height.equalTo(@40);
    }];
    [cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self refreshValidateCode];
}

#pragma mark - Actions
- (void)loginClick:(id)sender
{
    [SVProgressHUD showWithStatus:@"正在登录"];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    NSString *inputUserName = self.userName.text;
    NSString *inputPassword = self.password.text;
    NSString *inputValidateCode = self.validateCode.text;
    if (inputUserName ==nil || inputUserName.length <= 0)
    {
        [self onFucus:self.userName];
        return;
    }
    if (inputPassword == nil || inputPassword.length <= 0)
    {
        [self onFucus:self.password];
        return;
    }
    if (inputValidateCode == nil || inputValidateCode.length <= 0)
    {
        [self onFucus:self.validateCode];
        return;
    }
    NSDictionary *params = @{self.userNameInputName : inputUserName,
                             self.passwordInputName : inputPassword,
                             self.validaCodeInputName : inputValidateCode,
                             @"once" : self.once,
                             @"next" : @"/"
                             };
    [self.manager.requestSerializer setValue:@"Mozilla/5.0 (iPhone; CPU iPhone OS 8_0 like Mac OS X) AppleWebKit/600.1.3 (KHTML, like Gecko) Version/8.0 Mobile/12A4345d Safari/600.1.4" forHTTPHeaderField:@"user-agent"];
    [self.manager.requestSerializer setValue:@"https://v2ex.com/signin" forHTTPHeaderField:@"Referer"];
    [self.manager POST:LOGIN_URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
        NSHTTPURLResponse* response = (NSHTTPURLResponse* )task.response;
        NSDictionary *allHeaderFieldsDic = response.allHeaderFields;
        NSString *setCookie = allHeaderFieldsDic[@"Set-Cookie"];
        
        NSString * htmlStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        TFHpple *htmlParser = [[TFHpple alloc] initWithHTMLData:[htmlStr dataUsingEncoding:NSUTF8StringEncoding]];
        //NSLog(@"response html : %@", htmlStr);
        // 判断是否有头像，如果有那么登录成功
        
        NSString *username = [self getAttribute:@"href" FromParse:htmlParser ByXPath:@"//*[@id='Top']/div/div/table/tr/td[3]/a[1]"];
        NSString *avatarPath = [self getAttribute:@"src" FromParse:htmlParser ByXPath:@"//*[@id='Top']/div/div/table/tr/td[3]/a[1]/img[1]"];

        if ([username hasPrefix:@"/member/"])
        {
            username = [username stringByReplacingOccurrencesOfString:@"/member/" withString:@""];
        }
        avatarPath = [@"https:" stringByAppendingString:avatarPath];
        NSLog(@"username : %@", username);
        NSLog(@"avatarPath : %@", avatarPath);
        [V2exUser shareInstance].avatarPath = avatarPath;
        [V2exUser shareInstance].userName = username;
        [[NSUserDefaults standardUserDefaults] setObject:avatarPath forKey:APP_AVATAR_PATH_KEY];
        [[NSUserDefaults standardUserDefaults] setObject:username forKey:APP_USER_NAME_KEY];
        // 关闭登录页
        [SVProgressHUD dismiss];
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"login faild, Error : %@", error);
        [SVProgressHUD showErrorWithStatus:@"登录失败"];
    }];
}

- (void)refreshValidateCode
{
    if (!self.manager)
    {
        self.manager = [AFHTTPSessionManager manager];
        self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"image/png", nil];
        [self.manager.requestSerializer setValue:@"Mozilla/5.0 (iPhone; CPU iPhone OS 8_0 like Mac OS X) AppleWebKit/600.1.3 (KHTML, like Gecko) Version/8.0 Mobile/12A4345d Safari/600.1.4" forHTTPHeaderField:@"user-agent"];
    }
    [self.manager GET:LOGIN_URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString * htmlStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        TFHpple *htmlParser = [[TFHpple alloc] initWithHTMLData:[htmlStr dataUsingEncoding:NSUTF8StringEncoding]];
        
        // 获取once
        NSString *onceStr = nil;
        NSArray *elements  = [htmlParser searchWithXPathQuery:@"//*[@name='once'][1]"];
        if ([elements count] > 0)
        {
            TFHppleElement *codeElement = [elements objectAtIndex:0];
            onceStr = [codeElement attributes][@"value"];
            self.userNameInputName = [self getAttribute:@"name" FromParse:htmlParser ByXPath:@"//*[@id='Wrapper']/div/div[1]/div[2]/form/table/tr[1]/td[2]/input[@class='sl']"];
            self.passwordInputName = [self getAttribute:@"name" FromParse:htmlParser ByXPath:@"//*[@id='Wrapper']/div/div[1]/div[2]/form/table/tr[2]/td[2]/input[@class='sl']"];
            self.validaCodeInputName = [self getAttribute:@"name" FromParse:htmlParser ByXPath:@"//*[@id='Wrapper']/div/div[1]/div[2]/form/table/tr[4]/td[2]/input[@class='sl']"];
            self.once = onceStr;
            // 获取用户名、密码、验证码输入框的name
            NSLog(@"userNameInputName：%@" , self.userNameInputName);
            NSLog(@"passwordInputName：%@", self.passwordInputName);
            NSLog(@"validaCodeInputName：%@", self.validaCodeInputName);
            NSLog(@"once: %@", onceStr);
            
            // 获取验证码图片
            NSDictionary *params = @{@"once" : onceStr};
            [self.manager GET:GET_VALIDATE_CODE_URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                UIImage *codeImage = [UIImage imageWithData:responseObject];
                self.validateCodeView.image = codeImage;
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"error: %@", error);
                [SVProgressHUD showErrorWithStatus:@"加载失败"];
            }];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}

- (void)remindCode:(id)sender
{
    UIAlertController *remindAlert = [UIAlertController alertControllerWithTitle:@"验证码不显示？" message:@"如果验证码输错次数过多，V2EX将暂时禁止你的登录。" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil];
    [remindAlert addAction:okAction];
    [self presentViewController:remindAlert animated:YES completion:nil];
}

- (void)cancelClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)reloadValidateCodeImage:(id)sender
{
    [self refreshValidateCode];
}

#pragma mark - utils
// 根据XPATH获取属性值
- (NSString *)getAttribute:(NSString *)attribure FromParse:(TFHpple *)parse ByXPath:(NSString *)xpath
{
    NSString *value = nil;
    NSArray *elements = [parse searchWithXPathQuery:xpath];
    if ([elements count] > 0)
    {
        TFHppleElement *element = [elements objectAtIndex:0];
        value = [element attributes][attribure];
    }
    return value;
}

// 获取焦点
- (void)onFucus:(UIView *)input
{
    [input becomeFirstResponder];
}


#pragma mark - Keyboard
- (void)hideKeyboardWhenBlur
{
    UITapGestureRecognizer *keyBoardRecognizer = [[UITapGestureRecognizer alloc] init];
    [keyBoardRecognizer addTarget:self action:@selector(dismissKeyboard:)];
    [self.view addGestureRecognizer:keyBoardRecognizer];
}

- (void)dismissKeyboard:(id)sender
{
    [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
