//
//  V2exUtil.m
//  V2Client
//
//  Created by summer on 2019/2/21.
//  Copyright © 2019 sandrew. All rights reserved.
//


#import "V2exUtil.h"
#import "NetworkingUtil.h"
#import "SVProgressHUD.h"

@implementation V2exUtil

// 根据XPATH获取属性值
+ (NSString *)getAttribute:(NSString *)attribure FromParse:(TFHpple *)parse ByXPath:(NSString *)xpath
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

// 获取节点内XPATH下属性值
+ (NSString *)getAttribute:(NSString *)attribute FromElement:(TFHppleElement *)element ByXPath:(NSString *)xpath
{
    NSString *value = nil;
    NSArray *elements = [element searchWithXPathQuery:xpath];
    if ([elements count] > 0)
    {
        TFHppleElement *tmpEle = [elements objectAtIndex:0];
        value = [tmpEle attributes][attribute];
    }
    return value;
}

// 根据XPATH获取节点内容
+ (NSString *)getContentFromParse:(TFHpple *)parse ByXpath:(NSString *)xpath
{
    NSString *value = nil;
    NSArray *elements = [parse searchWithXPathQuery:xpath];
    if ([elements count] > 0)
    {
        TFHppleElement *element = [elements objectAtIndex:0];
        value = [element content];
    }
    return value;
}

// 获取节点内XPATH下内容
+ (NSString *)getContentFromElement:(TFHppleElement *)element ByXpath:(NSString *)xpath
{
    NSString *value = nil;
    NSArray *elements = [element searchWithXPathQuery:xpath];
    if ([elements count] > 0)
    {
        TFHppleElement *tmpEle = [elements objectAtIndex:0];
        value = [tmpEle content];
    }
    return value;
}

// 根据XPATH获取下面所有节点
+ (NSArray *)getElementsFromParse:(TFHpple *)parse ByXpath:(NSString *)xpath
{
    NSArray *elements = [parse searchWithXPathQuery:xpath];
    return elements;
}

// 网络请求GET
+ (void)get:(NSString *)url
        parameters:(id)parameters
        success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
        withLoading:(BOOL)withLoading
{
    NSMutableDictionary *header = [[NSMutableDictionary alloc] init];
    [header setValue:@"Mozilla/5.0 (iPhone; CPU iPhone OS 8_0 like Mac OS X) AppleWebKit/600.1.3 (KHTML, like Gecko) Version/8.0 Mobile/12A4345d Safari/600.1.4" forKey:@"user-agent"];
    [[NetworkingUtil shareInstance] setupHeader:header];
    [[NetworkingUtil shareInstance] get:url parameters:parameters preHandle:^{
        if (withLoading)
        {
            [SVProgressHUD showWithStatus:@"加载中"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        }
    } progress:nil success:success failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}
// 网络请求POST
+ (void)post:(NSString *)url
        parameters:(id)parameters
        success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
        withLoading:(BOOL)withLoading
{
    [[NetworkingUtil shareInstance] post:url parameters:parameters preHandle:^{
        if (withLoading)
        {
            [SVProgressHUD showWithStatus:@"加载中"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        }
    } progress:nil success:success failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}

// 获取焦点
+ (void)onFucus:(UIView *)input
{
    [input becomeFirstResponder];
}

@end
