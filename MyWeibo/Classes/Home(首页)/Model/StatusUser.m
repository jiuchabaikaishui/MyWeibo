//
//  StatusUser.m
//  MyWeibo
//
//  Created by     -MINI on 16/2/25.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import "StatusUser.h"

@implementation StatusUser

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.gender = [aDecoder decodeObjectForKey:@"gender"];
        self.idstr = [aDecoder decodeObjectForKey:@"idstr"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.profile_image_url = [aDecoder decodeObjectForKey:@"profile_image_url"];
        self.vip = [aDecoder decodeBoolForKey:@"vip"];
        self.mbrank = [aDecoder decodeIntForKey:@"mbrank"];
        self.mbtype = [aDecoder decodeIntForKey:@"mbtype"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.gender forKey:@"gender"];
    [aCoder encodeObject:self.idstr forKey:@"idstr"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.profile_image_url forKey:@"profile_image_url"];
    [aCoder encodeBool:self.vip forKey:@"vip"];
    [aCoder encodeInt:self.mbrank forKey:@"mbrank"];
    [aCoder encodeInt:self.mbtype forKey:@"mbtype"];
}

@end
