//
//  V2exUtil.h
//  V2Client
//
//  Created by summer on 2019/2/21.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TFHpple.h"

NS_ASSUME_NONNULL_BEGIN

@interface V2exUtil : NSObject

// 根据XPATH获取属性值
+ (NSString *)getAttribute:(NSString *)attribute FromParse:(TFHpple *)parse ByXPath:(NSString *)xpath;
// 获取节点内XPATH下属性值
+ (NSString *)getAttribute:(NSString *)attribute FromElement:(TFHppleElement *)element ByXPath:(NSString *)xpath;
// 根据XPATH获取节点内容
+ (NSString *)getContentFromParse:(TFHpple *)parse ByXpath:(NSString *)xpath;
// 获取节点内XPATH下内容
+ (NSString *)getContentFromElement:(TFHppleElement *)element ByXpath:(NSString *)xpath;
// 根据XPATH获取下面所有节点
+ (NSArray *)getElementsFromParse:(TFHpple *)parse ByXpath:(NSString *)xpath;
// 网络请求GET
+ (void)get:(NSString *)url
        parameters:(id)parameters
        success:(void (^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject))success
        withLoading:(BOOL)withLoading;
// 网络请求POST
+ (void)post:(NSString *)url
        parameters:(id)parameters
        success:(void (^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject))success
        withLoading:(BOOL)withLoading;
// 获取焦点
+ (void)onFucus:(UIView *)input;

@end

NS_ASSUME_NONNULL_END
