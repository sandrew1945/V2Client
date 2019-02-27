//
//  V2exUtil.m
//  V2Client
//
//  Created by summer on 2019/2/21.
//  Copyright © 2019 sandrew. All rights reserved.
//


#import "V2exUtil.h"
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

// 获取焦点
+ (void)onFucus:(UIView *)input
{
    [input becomeFirstResponder];
}

@end
