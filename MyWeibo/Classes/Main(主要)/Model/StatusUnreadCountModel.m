//
//  StatusUnreadCountModel.m
//  MyWeibo
//
//  Created by     -MINI on 16/3/28.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import "StatusUnreadCountModel.h"

@implementation StatusUnreadCountModel
- (int)messageCount
{
    return self.cmt + self.mention_cmt + self.mention_status + self.dm;
}

- (int)count
{
    return self.messageCount + self.status + self.follower;
}

@end
