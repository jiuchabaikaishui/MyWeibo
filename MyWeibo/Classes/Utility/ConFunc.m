//
//  ConFunc.m
//  MyWeibo
//
//  Created by apple on 16/2/3.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import "ConFunc.h"

@implementation ConFunc

/**
 *  不变形的拉伸图片
 *
 *  @param name 图片名称
 *
 *  @return 拉伸后的图片
 */
+ (UIImage *)imageWithName:(NSString *)name
{
    return [self imageWithName:name fromLeft:0.5 fromTop:0.5];
}
+ (UIImage *)imageWithName:(NSString *)name fromLeft:(float)left fromTop:(float)top
{
    UIImage *image = [UIImage imageNamed:name];
    CGFloat imageW = image.size.width*left;
    CGFloat imageH = image.size.height*top;
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(imageH, imageW, imageH, imageW)];
}
//图片压缩
+ (UIImage *)scaleTosize:(UIImage *)img size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImg;
}

//自适应高度
+ (CGSize)getAutoSize:(CGFloat)targetWeight andStr:(NSString *)str andFont:(UIFont *)font
{
    CGSize size = [str boundingRectWithSize:CGSizeMake(targetWeight, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;//[str sizeWithFont:font constrainedToSize:CGSizeMake(targetWeight, 10000) lineBreakMode:NSLineBreakByWordWrapping];
    return size;
}

//判空
+ (BOOL)isBlankString:(NSString *)string
{
    if (string == nil || string == NULL)
        return YES;
    
    if ([string isKindOfClass:[NSNull class]])
        return YES;
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
        return YES;
    return NO;
}

//UIView->UIImage
+ (UIImage*)convertViewToImage:(UIView*)v
{
    UIGraphicsBeginImageContext(v.bounds.size);
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//获取当前app版本
+ (NSString *)getCurrentLocalVersion
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDic objectForKey:@"CFBundleVersion"];
    return appVersion;
}

+ (UIImage *)imageFromColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, CGFLOAT_MIN + 1, CGFLOAT_MIN + 1);
    
    return [self imageFromColor:color andFram:rect];
}

+ (UIImage *)imageFromColor:(UIColor *)color andFram:(CGRect)frame
{
    //CGRect rect = CGRectMake(0, 0, CGFLOAT_MIN + 1, CGFLOAT_MIN + 1);
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, frame);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

@end
