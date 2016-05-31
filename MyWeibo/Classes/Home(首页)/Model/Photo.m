//
//  Photo.m
//  MyWeibo
//
//  Created by     -MINI on 16/3/10.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import "Photo.h"

@implementation Photo

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.thumbnail_pic = [coder decodeObjectForKey:@"thumbnail_pic"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.thumbnail_pic forKey:@"thumbnail_pic"];
}


@end
