//
//  ConFunc.h
//  MyWeibo
//
//  Created by apple on 16/2/3.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ConFunc : NSObject

/**
 *  不变形的拉伸图片
 *
 *  @param name 图片名称
 *
 *  @return 拉伸后的图片
 */
+ (UIImage *)imageWithName:(NSString *)name;
+ (UIImage *)imageWithName:(NSString *)name fromLeft:(float)left fromTop:(float)top;

//图片压缩
+ (UIImage *)scaleTosize:(UIImage *)img size:(CGSize)size;

//自适应高度
+ (CGSize)getAutoSize:(CGFloat)targetWeight andStr:(NSString *)str andFont:(UIFont *)font;

//判空
+ (BOOL)isBlankString:(NSString *)string;

//UIView->UIImage
+ (UIImage*)convertViewToImage:(UIView*)v;

//获取当前app版本
+ (NSString *)getCurrentLocalVersion;

+ (UIImage *)imageFromColor:(UIColor *)color;

+ (UIImage *)imageFromColor:(UIColor *)color andFram:(CGRect)frame;

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
