//
//  Status.m
//  MyWeibo
//
//  Created by     -MINI on 16/2/25.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import "Status.h"
#import "NSDate+QSP.h"
#import "MJExtension.h"
#import "Photo.h"
#import "ConFunc.h"

@implementation Status
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"pic_urls":[Photo class]};
}
- (NSString *)created_time
{
    if (_created_at) {
        // _created_at == Fri May 09 16:30:34 +0800 2014
        //                Fri Mar 04 09:46:15 +0800 2016
        // 1.获得微博的发送时间
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
        NSDate *creatDate = [fmt dateFromString:_created_at];
        
        if ([creatDate isToday]) {
            NSDateComponents *components = creatDate.deltaWithNow;
            if (components.hour >= 1) {
                return [NSString stringWithFormat: @"%i小时前",(int)components.hour];
            }
            else if (creatDate.deltaWithNow.minute >= 1)
            {
                return [NSString stringWithFormat: @"%i分钟前",(int)components.minute];
            }
            else
            {
                return @"刚刚";
            }
        }
        else if ([creatDate isYesterday])
        {
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:creatDate];
        }
        else if ([creatDate isThisYear])
        {
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:creatDate];
        }
        else
        {
            fmt.dateFormat = @"yyyy-MM-dd HH:mm";
            return [fmt stringFromDate:creatDate];
        }
    }
    
    return nil;
}

- (void)setSource:(NSString *)source
{
    if (![ConFunc isBlankString:source]) {
//        <a href=\"http://weibo.com/\" rel=\"nofollow\">\U5fae\U535a weibo.com</a>
        QSPLog(@"%@",source);
        if ([source rangeOfString:@">"].location == NSNotFound) {
            _source = [source copy];
        }
        else
        {
            NSInteger loc = [source rangeOfString:@">"].location + 1;
            NSInteger lenth = [source rangeOfString:@"</"].location - loc;
            NSString *str = [source substringWithRange:NSMakeRange(loc, lenth)];
            _source = [[NSString stringWithFormat:@"来源：%@",str] copy];
        }
    }
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.idstr = [aDecoder decodeObjectForKey:@"idstr"];
        self.reposts_count = [aDecoder decodeInt64ForKey:@"reposts_count"];
        self.comments_count = [aDecoder decodeInt64ForKey:@"comments_count"];
        self.attitudes_count = [aDecoder decodeInt64ForKey:@"attitudes_count"];
        self.created_at = [aDecoder decodeObjectForKey:@"created_at"];
        self.pic_urls = [aDecoder decodeObjectForKey:@"pic_urls"];
        self.source = [aDecoder decodeObjectForKey:@"source"];
        self.text = [aDecoder decodeObjectForKey:@"text"];
        self.retweeted_status = [aDecoder decodeObjectForKey:@"retweeted_status"];
        self.user = [aDecoder decodeObjectForKey:@"user"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.idstr forKey:@"idstr"];
    [aCoder encodeInt64:self.reposts_count forKey:@"reposts_count"];
    [aCoder encodeInt64:self.comments_count forKey:@"comments_count"];
    [aCoder encodeInt64:self.attitudes_count forKey:@"attitudes_count"];
    [aCoder encodeObject:self.created_at forKey:@"created_at"];
    [aCoder encodeObject:self.pic_urls forKey:@"pic_urls"];
    [aCoder encodeObject:self.source forKey:@"source"];
    [aCoder encodeObject:self.text forKey:@"text"];
    [aCoder encodeObject:self.retweeted_status forKey:@"retweeted_status"];
    [aCoder encodeObject:self.user forKey:@"user"];
}

@end
