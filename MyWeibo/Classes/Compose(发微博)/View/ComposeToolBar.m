//
//  ComposeToolBar.m
//  MyWeibo
//
//  Created by     -MINI on 16/3/16.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import "ComposeToolBar.h"
#import "ConFunc.h"

@interface ComposeToolBar ()

@property (weak, nonatomic)UIImageView *imageView;
@property (strong, nonatomic)NSMutableArray *buttons;

@end

@implementation ComposeToolBar

#pragma mark - 属性方法
- (NSMutableArray *)buttons
{
    if (_buttons == nil) {
        _buttons = [NSMutableArray arrayWithCapacity:1];
    }
    
    return _buttons;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self settingSubviews];
    }
    
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self settingSubviews];
    }
    
    return self;
}

- (void)settingSubviews
{
    self.backgroundColor = QSPClolor(240, 240, 240);
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [ConFunc imageWithName:@"compose_toolbar_background_os7"];
    [self addSubview:imageView];
    self.imageView = imageView;
    
    NSArray *arr = @[
                     @{@"image":@"compose_camerabutton_background_os7",@"himage":@"compose_camerabutton_background_highlighted_os7",@"type":@(ComposeToolBarButtonTypeCamera)},
                     @{@"image":@"compose_toolbar_picture_os7",@"himage":@"compose_toolbar_picture_highlighted_os7",@"type":@(ComposeToolBarButtonTypePicture)},
                     @{@"image":@"compose_mentionbutton_background_os7",@"himage":@"compose_mentionbutton_background_highlighted_os7",@"type":@(ComposeToolBarButtonTypeMention)},
                     @{@"image":@"compose_trendbutton_background_os7",@"himage":@"compose_trendbutton_background_highlighted_os7",@"type":@(ComposeToolBarButtonTypeTrend)},
                     @{@"image":@"compose_emoticonbutton_background_os7",@"himage":@"compose_emoticonbutton_background_highlighted_os7",@"type":@(ComposeToolBarButtonTypeEmotion)}
                     ];
    for (NSDictionary *dic in arr) {
        [self.buttons addObject:[self addButtonWithImage:dic[@"image"] hightImage:dic[@"himage"] andType:(ComposeToolBarButtonType)dic[@"type"]]];
    }
}

- (UIButton *)addButtonWithImage:(NSString *)image hightImage:(NSString *)himage andType:(ComposeToolBarButtonType)type
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:himage] forState:UIControlStateHighlighted];
    button.contentMode = UIViewContentModeCenter;
    [button addTarget:self action:@selector(buttonsAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    return button;
}

- (void)buttonsAction:(UIButton *)sender
{
    ComposeToolBarButtonType type = [self.buttons indexOfObject:sender];
    QSPLog(@"您点击了第%i个按钮！",(int)type);
    
    if ([self.delegate respondsToSelector:@selector(composeToolBarDelegate:clickedButtonType:)]) {
        [self.delegate composeToolBarDelegate:self clickedButtonType:type];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = self.frame;
    
    NSInteger count = self.buttons.count;
    CGFloat SW = self.frame.size.width;
    CGFloat SH = self.frame.size.height;
    CGFloat spacing = SPACING;
    CGFloat Y = 0;
    CGFloat W = (SW - (count + 1)*spacing)/count;
    CGFloat H = SH;
    for (int i = 0; i < count; i++) {
        CGFloat X = spacing + (W + spacing)*i;
        UIButton *button = self.buttons[i];
        button.frame = CGRectMake(X, Y, W, H);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
