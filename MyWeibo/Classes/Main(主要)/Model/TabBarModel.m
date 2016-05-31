//
//  TabBarModel.m
//  MyWeibo
//
//  Created by apple on 15/12/19.
//  Copyright © 2015年 QSP. All rights reserved.
//

#import "TabBarModel.h"

@implementation TabBarModel

+ (instancetype)tabBarModelWithDic:(NSDictionary *)dic
{
    return [[self alloc] initWithDic:dic];
}
- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        if (dic) {
            [self setValuesForKeysWithDictionary:dic];
        }
    }
    
    return self;
}

@end
