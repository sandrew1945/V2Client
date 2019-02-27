//
//  V2exColor.m
//  V2Client
//
//  Created by summer on 2019/2/12.
//  Copyright © 2019 sandrew. All rights reserved.
//

#import "V2exColor.h"

@implementation V2exColor

+ (UIColor *)v2_backgroundColor
{
    UIColor *color = [UIColor colorWithRed:242 green:243 blue:245 alpha:1];
    return color;
}

+ (UIColor *)v2_navigationBarTintColor
{
    UIColor *color = [UIColor colorWithRed:102 green:102 blue:102 alpha:1];
    return color;
}

+ (UIColor *)v2_TopicListTitleColor
{
    UIColor *color = [UIColor colorWithRed:15 green:15 blue:15 alpha:1];
    return color;
}

+ (UIColor *)v2_LeftNodeTintColor
{
    UIColor *color = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    return color;
}

+ (UIImage *)createImageWithColor:(UIColor *)color
{
    return [self createImageWithColor:color Size:CGRectMake(0, 0, 1, 1).size];
}

+ (UIImage *)createImageWithColor:(UIColor *)color Size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha
{
    return [UIColor colorWithRed:(red/255.0) green:(green/255.0) blue:(blue/255.0) alpha:alpha];
}
//
//func createImageWithColor(_ color:UIColor) -> UIImage{
//    return createImageWithColor(color, size: CGSize(width: 1, height: 1))
//}
//func createImageWithColor(_ color:UIColor,size:CGSize) -> UIImage {
//    let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
//    UIGraphicsBeginImageContext(rect.size);
//    let context = UIGraphicsGetCurrentContext();
//    context?.setFillColor(color.cgColor);
//    context?.fill(rect);
//
//    let theImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return theImage!;
//}

@end
