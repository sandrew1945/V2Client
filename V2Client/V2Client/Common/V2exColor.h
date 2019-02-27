//
//  V2exColor.h
//  V2Client
//
//  Created by summer on 2019/2/12.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface V2exColor : NSObject

+ (UIColor *)v2_backgroundColor;

+ (UIColor *)v2_navigationBarTintColor;

+ (UIColor *)v2_TopicListTitleColor;

+ (UIColor *)v2_LeftNodeTintColor;

+ (UIImage *)createImageWithColor:(UIColor *)color;

+ (UIImage *)createImageWithColor:(UIColor *)color Size:(CGSize)size;

+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
