//
//  QSP_ImageSelectView.m
//  QSP_ImageSelector_Sample
//
//  Created by     -MINI on 16/3/17.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import "QSP_ImageSelectView.h"

/**
 *  1.调试阶段，写代码调试错误，需要打印。(系统会自定义一个叫做DEBUG的宏)
 *  2.发布阶段，安装在用户设备上，不需要打印。(系统会删掉这个叫做DEBUG的宏)
 */
#if DEBUG
#define QSPLog(...)    NSLog(__VA_ARGS__)
#else
#define QSPLog(...)
#endif

#define Default_Spacing      8
#define Default_ColumnsNum   3
#define Default_RowHeight    (-1)
#define Default_MaxImagesCount     NSIntegerMax

@interface QSP_ImageSelectView ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic)NSMutableArray *imageButtons;
@property (weak, nonatomic)UIViewController *currentViewController;
@property (assign, nonatomic)BOOL isScrollToBottom;
@property (assign, nonatomic)BOOL isAddImage;
@property (weak, nonatomic)UIButton *currentButton;
@property (assign, nonatomic)BOOL keyBoardShow;
@property (assign, nonatomic)BOOL buttonClicked;

@end

@implementation QSP_ImageSelectView

#pragma mark - 属性方法
//获取当前屏幕显示的viewcontroller
- (UIViewController *)currentViewController
{
    //网络上获取当前window的方法
//    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
//    if (window.windowLevel != UIWindowLevelNormal)
//    {
//        NSArray *windows = [[UIApplication sharedApplication] windows];
//        for(UIWindow * tmpWin in windows)
//        {
//            if (tmpWin.windowLevel == UIWindowLevelNormal)
//            {
//                window = tmpWin;
//                break;
//            }
//        }
//    }
    //自己获取当前window的方法
//    UIWindow *currentWindow = [UIApplication sharedApplication].delegate.window;
//    if (currentWindow) {
//        id responder = [currentWindow nextResponder];
//        if ([responder isKindOfClass:[UIViewController class]]) {
//            return responder;
//        }
//        
//        return currentWindow.rootViewController;
//    }
//    
    //    return nil;
    
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
- (void)setMaxImagesCount:(NSInteger)maxImagesCount
{
    _maxImagesCount = maxImagesCount;
    
}
- (void)setRowHeight:(CGFloat)rowHeight
{
    _rowHeight = rowHeight;
    
    //设置子视图的fram
    [self settingSubviewsFrame];
}
- (void)setColumnsNum:(int)columnsNum
{
    _columnsNum = columnsNum;
    
    //设置子视图的fram
    [self settingSubviewsFrame];
}
- (void)setImageHorizontalSpacing:(float)imageHorizontalSpacing
{
    _imageHorizontalSpacing = imageHorizontalSpacing;
    
    //设置子视图的fram
    [self settingSubviewsFrame];
}
- (void)setImageHorizontalMargin:(float)imageHorizontalMargin
{
    _imageHorizontalMargin = imageHorizontalMargin;
    
    //设置子视图的fram
    [self settingSubviewsFrame];
}
- (void)setImageVerticalSpacing:(float)imageVerticalSpacing
{
    _imageVerticalSpacing = imageVerticalSpacing;
    
    //设置子视图的fram
    [self settingSubviewsFrame];
}
- (void)setImageVerticalMargin:(float)imageVerticalMargin
{
    _imageVerticalMargin = imageVerticalMargin;
    
    //设置子视图的fram
    [self settingSubviewsFrame];
}
- (void)setImages:(NSMutableArray *)images
{
    if (images) {
        _images = images;
    }
}
- (NSMutableArray *)imageButtons
{
    if (_imageButtons == nil) {
        _imageButtons = [NSMutableArray arrayWithCapacity:1];
    }
    
    return _imageButtons;
}
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}

#pragma mark - 系统方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self settingSubviews];
    }
    
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self settingSubviews];
    }
    
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self settingSubviewsFrame];
}

#pragma mark - 点击触摸方法
- (void)addButtonAction:(UIButton *)sender
{
    self.isAddImage = YES;
    self.currentButton = sender;
    self.buttonClicked = YES;

    if (!self.keyBoardShow) {
        self.buttonClicked = NO;
        
        QSPLog(@"%s",__FUNCTION__);
        
        __weak typeof(self) weakSelf = self;
        UIAlertController *alertCtr = [UIAlertController alertControllerWithTitle:@"选择图片来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            QSPLog(@"您点击了相册！");
            
            UIImagePickerController *pickCtr = [[UIImagePickerController alloc] init];
            pickCtr.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            pickCtr.delegate = weakSelf;
            [[weakSelf currentViewController] presentViewController:pickCtr animated:YES completion:nil];
        }];
        UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            QSPLog(@"您选择了相机！");
            
            UIImagePickerController *pickCtr = [[UIImagePickerController alloc] init];
            pickCtr.sourceType = UIImagePickerControllerSourceTypeCamera;
            pickCtr.delegate = weakSelf;
            [[weakSelf currentViewController] presentViewController:pickCtr animated:YES completion:nil];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertCtr addAction:photoAction];
        [alertCtr addAction:cameraAction];
        [alertCtr addAction:cancelAction];
        [self.currentViewController presentViewController:alertCtr animated:YES completion:nil];
    }
    else
    {
        [self.currentViewController.view endEditing:YES];
    }
}
- (void)imageButtonAction:(UIButton *)sender
{
    self.isAddImage = NO;
    self.currentButton = sender;
    self.buttonClicked = YES;
    
    if (!self.keyBoardShow) {
        self.buttonClicked = NO;
        
        NSInteger index = [self.imageButtons indexOfObject:sender];
        QSPLog(@"您点击了第%i张图片！",(int)index);
        
        __weak typeof(self) weakSelf = self;
        UIAlertController *alertCtr = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIImagePickerController *pickerCtr = [[UIImagePickerController alloc] init];
            pickerCtr.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            pickerCtr.delegate = weakSelf;
            [weakSelf.currentViewController presentViewController:pickerCtr animated:YES completion:nil];
        }];
        [alertCtr addAction:photoAction];
        UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIImagePickerController *pickerCtr = [[UIImagePickerController alloc] init];
            pickerCtr.sourceType = UIImagePickerControllerSourceTypeCamera;
            pickerCtr.delegate = weakSelf;
            [weakSelf.currentViewController presentViewController:pickerCtr animated:YES completion:nil];
        }];
        [alertCtr addAction:cameraAction];
        __weak typeof(UIButton) *weakSender = sender;
        UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf deleteImageButton:weakSender];
            
            if ([self.qspDelegate respondsToSelector:@selector(imageSelectViewAfterChangePicture:)]) {
                [self.qspDelegate imageSelectViewAfterChangePicture:self];
            }
        }];
        [alertCtr addAction:deleteAction];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertCtr addAction:cancelAction];
        [self.currentViewController presentViewController:alertCtr animated:YES completion:nil];
    }
    else
    {
        [self.currentViewController.view endEditing:YES];
    }
}
- (void)keyboardDidShowAction:(NSNotification *)sender
{
    self.keyBoardShow = YES;
}
- (void)keyboardDidHideAction:(NSNotification *)sender
{
    self.keyBoardShow = NO;
    
    if (self.buttonClicked) {
        if (self.isAddImage) {
            [self addButtonAction:self.currentButton];
        }
        else
        {
            [self imageButtonAction:self.currentButton];
        }
        self.buttonClicked = NO;
    }
}

#pragma mark - 自定义方法
- (void)settingSubviews
{
    //初始化控件
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"add_image"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"add_image_hight"] forState:UIControlStateHighlighted];
    button.imageView.contentMode = UIViewContentModeScaleToFill;
    [button addTarget:self action:@selector(addButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [self.imageButtons addObject:button];
    
    //初始化数据
    self.columnsNum = Default_ColumnsNum;
    self.rowHeight = Default_RowHeight;
    self.maxImagesCount = Default_MaxImagesCount;
    self.imageHorizontalSpacing = Default_Spacing;
    self.imageHorizontalMargin = Default_Spacing;
    self.imageVerticalSpacing = Default_Spacing;
    self.imageVerticalMargin = Default_Spacing;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShowAction:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHideAction:) name:UIKeyboardDidHideNotification object:nil];
}
/**
 *  设置子控件frame
 */
- (void)settingSubviewsFrame
{
    CGFloat selfWidth = self.frame.size.width;
    NSInteger rowNum = (self.imageButtons.count - 1)/self.columnsNum + 1;
    CGFloat columnsWith = (selfWidth - self.imageHorizontalSpacing*(self.columnsNum - 1) - self.imageHorizontalMargin*2)/self.columnsNum;
    CGFloat rowHeight = self.rowHeight == Default_RowHeight ? columnsWith : self.rowHeight;
    
    for (NSInteger index = 0;index < self.imageButtons.count;index++) {
        NSInteger row = index/self.columnsNum;
        NSInteger columns = index%self.columnsNum;
        CGFloat X = self.imageHorizontalMargin + (columnsWith + self.imageHorizontalSpacing)*columns;
        CGFloat Y = self.imageVerticalMargin + (rowHeight + self.imageVerticalSpacing)*row;
        CGFloat W = columnsWith;
        CGFloat H = rowHeight;
        
        UIButton *button = self.imageButtons[index];
        button.frame = CGRectMake(X, Y, W, H);
        
        button.hidden = index >= self.maxImagesCount;
    }
    
    CGSize size = self.frame.size;
    size.height = self.imageVerticalMargin*2 + (rowHeight + self.imageVerticalSpacing)*rowNum - self.imageVerticalSpacing;
    self.contentSize = size;
    
    if (self.isScrollToBottom) {
        CGFloat offsetH = self.contentSize.height - self.frame.size.height > 0 ? self.contentSize.height - self.frame.size.height : 0;
        self.contentOffset = CGPointMake(0, offsetH);
        self.isScrollToBottom = NO;
    }
}
/**
 *  添加图片按钮
 *
 *  @param images 图片数组
 */
- (void)addImageButtonsWithImages:(NSArray *)images
{
    if (images.count) {
        NSMutableArray *mArr = [NSMutableArray arrayWithCapacity:1];
        NSMutableArray *mImageArr = [NSMutableArray arrayWithCapacity:1];
        [mImageArr addObjectsFromArray:self.images];
        [mImageArr addObjectsFromArray:images];
        _images = mImageArr;
        for (UIImage *image in images) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.backgroundColor = [UIColor cyanColor];
            [button setImage:image forState:UIControlStateNormal];
            button.adjustsImageWhenHighlighted = NO;
            button.imageView.contentMode = UIViewContentModeScaleAspectFill;
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(imageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            self.isScrollToBottom = YES;
            [self addSubview:button];
            [mArr addObject:button];
        }
        
        [self.imageButtons insertObjects:mArr atIndexes:[NSIndexSet indexSetWithIndex:self.imageButtons.count - 1]];
    }
}
/**
 *  删除一张图片
 *
 *  @param button 要删除的图片按钮
 */
- (void)deleteImageButton:(UIButton *)button
{
    [self.images removeObject:[button currentImage]];
    [self.imageButtons removeObject:button];
    [button removeFromSuperview];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [[self currentViewController] dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    if (self.isAddImage) {
        [self addImageButtonsWithImages:[NSArray arrayWithObject:image]];
        
        if ([self.qspDelegate respondsToSelector:@selector(imageSelectViewAfterAddPicture:)]) {
            [self.qspDelegate imageSelectViewAfterAddPicture:self];
        }
    }
    else
    {
        [self.currentButton setImage:image forState:UIControlStateNormal];
        
        if ([self.qspDelegate respondsToSelector:@selector(imageSelectViewAfterChangePicture:)]) {
            [self.qspDelegate imageSelectViewAfterChangePicture:self];
        }
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
