//
//  MainTabBar.m
//  MyWeibo
//
//  Created by apple on 15/12/17.
//  Copyright © 2015年 QSP. All rights reserved.
//

#import "MainTabBar.h"
#import "MainTabBarButton.h"

@interface MainTabBar ()

@property (strong,nonatomic) NSMutableArray *buttons;
@property (strong,nonatomic) NSMutableArray *items;
@property (weak,nonatomic) UIButton *selectButton;
@property (nonatomic, weak) UIButton *plusButton;

@end

@implementation MainTabBar
#pragma mark - 属性方法
- (NSMutableArray *)buttons
{
    if (_buttons == nil) {
        _buttons = [NSMutableArray arrayWithCapacity:1];
    }
    
    return _buttons;
}
- (NSMutableArray *)items
{
    if (_items == nil) {
        _items = [NSMutableArray arrayWithCapacity:1];
    }
    
    return _items;
}
- (UIButton *)plusButton
{
    if (_plusButton == nil) {
        // 添加一个加号按钮
        UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_os7"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted_os7"] forState:UIControlStateHighlighted];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_os7"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted_os7"] forState:UIControlStateHighlighted];
        plusButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        plusButton.bounds = CGRectMake(0, 0, plusButton.currentBackgroundImage.size.width, plusButton.currentBackgroundImage.size.height);
        [plusButton addTarget:self action:@selector(plusButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusButton];
        
        _plusButton = plusButton;
    }
    
    return _plusButton;
}

#pragma mark - 控制器周期
- (void)dealloc
{
    for (UITabBarItem *item in self.items) {
        [item removeObserver:self forKeyPath:@"title"];
        [item removeObserver:self forKeyPath:@"image"];
        [item removeObserver:self forKeyPath:@"selectImage"];
        [item removeObserver:self forKeyPath:@"badgeValue"];
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 调整加号按钮的位置
    QSPLog(@"%@",NSStringFromCGRect(self.frame));
    self.plusButton.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, self.frame.size.height/2);
    NSInteger plus = self.plusButton ? 1 : 0;
    
    for (UIButton *button in self.buttons) {
        NSInteger index = [self.buttons indexOfObject:button];
        CGFloat W = [UIScreen mainScreen].bounds.size.width/(self.buttons.count + plus);
        CGFloat H = self.frame.size.height;
        CGFloat X = W*(index + 1 > self.buttons.count/2 ? index + plus : index);
        CGFloat Y = 0;
        button.frame = CGRectMake(X, Y, W, H);
    }
}

#pragma mark - 触摸点击事件
- (void)clickedButton:(NSInteger)num
{
    if (num < self.buttons.count) {
        [self buttonClicked:self.buttons[num]];
    }
}

- (void)buttonClicked:(MainTabBarButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(mainTabBar:selectedFromIndex:toIndex:)]) {
        [self.delegate mainTabBar:self selectedFromIndex:(int)[self.buttons indexOfObject:self.selectButton] toIndex:(int)[self.buttons indexOfObject:sender]];
        self.selectButton.selected = NO;
        sender.selected = YES;
        self.selectButton = sender;
    }
}
- (void)plusButtonClicked:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(mainTabBarPlusButtonClicked:)]) {
        [self.delegate mainTabBarPlusButtonClicked:self];
    }
}

#pragma mark - 自定义方法
- (void)addButtonWithItem:(UITabBarItem *)item
{
    MainTabBarButton *button = [MainTabBarButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:button];
    [button setTitle:item.title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [button setImage:item.image forState:UIControlStateNormal];
    [button setImage:item.selectedImage forState:UIControlStateSelected];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchDown];
    button.badgeValue = item.badgeValue;
    
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectImage" options:0 context:nil];
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    
    [self.buttons addObject:button];
    [self.items addObject:item];
    
    if ([self.buttons indexOfObject:button] == 0) {
        button.selected = YES;
        self.selectButton = button;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    UITabBarItem *item = (UITabBarItem *)object;
    NSInteger index = [self.items indexOfObject:item];
    
    MainTabBarButton *button = self.buttons[index];
    
    // 设置文字
    [button setTitle:item.title forState:UIControlStateNormal];
    [button setTitle:item.title forState:UIControlStateSelected];
    
    // 设置图片
    [button setImage:item.image forState:UIControlStateNormal];
    [button setImage:item.selectedImage forState:UIControlStateSelected];
    
    // 设置提醒数字
    [button setBadgeValue:item.badgeValue];
}

@end
