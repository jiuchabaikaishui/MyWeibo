//
//  SearchTextField.m
//  MyWeibo
//
//  Created by apple on 16/2/4.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import "SearchTextField.h"
#import "ConFunc.h"

@implementation SearchTextField

+ (instancetype)searchTextFieldWithFrame:(CGRect)frame
{
    return [[self alloc] initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置背景图片
        [self setBackground:[ConFunc imageWithName:@"searchbar_textfield_background_os7"]];
        
        // 设置字体
        self.font = [UIFont systemFontOfSize:14];
        
        // 设置提醒文字
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索" attributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor], NSFontAttributeName:[UIFont systemFontOfSize:12]}];
        
        // 设置右边的清除按钮
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        // 设置左边的放大镜图标
        UIImageView *searchLeftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.height, self.frame.size.height)];
        searchLeftView.contentMode = UIViewContentModeCenter;
        searchLeftView.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        self.leftView = searchLeftView;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        // 设置键盘右下角按钮的样式
        self.returnKeyType = UIReturnKeySearch;
        self.enablesReturnKeyAutomatically = YES;
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.leftView.frame = CGRectMake(0, 0, self.frame.size.height, self.frame.size.height);
}

@end
