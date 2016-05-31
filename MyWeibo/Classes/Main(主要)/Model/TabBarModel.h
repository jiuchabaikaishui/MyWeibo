//
//  TabBarModel.h
//  MyWeibo
//
//  Created by apple on 15/12/19.
//  Copyright © 2015年 QSP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TabBarModel : NSObject
//自控制器类型
@property (assign,nonatomic) Class ctrClass;
//子控制器类型
@property (copy,nonatomic) NSString *title;
//消息数
@property (copy,nonatomic) NSString *badgeValue;
//tabBar图片
@property (copy,nonatomic) NSString *imageName;
//tabBar选中时的图片
@property (copy,nonatomic) NSString *selectImageName;

+ (instancetype)tabBarModelWithDic:(NSDictionary *)dic;
- (instancetype)initWithDic:(NSDictionary *)dic;

@end
