//
//  ComposeViewController.m
//  MyWeibo
//
//  Created by     -MINI on 16/3/14.
//  Copyright © 2016年 QSP. All rights reserved.
//

#import "ComposeViewController.h"
#import "ComposeTextView.h"
#import "StatusFunction.h"
#import "AccountTool.h"
#import "ComposeToolBar.h"
#import "QSP_ImageSelectView.h"
#import "ConFunc.h"

@interface ComposeViewController ()<UITextViewDelegate,ComposeToolBarDelegate,QSP_ImageSelectViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic)ComposeTextView *textView;
@property (weak, nonatomic)ComposeToolBar *toolBar;
@property (weak, nonatomic)QSP_ImageSelectView *qspView;

@end

@implementation ComposeViewController

#pragma mark - 控制器周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self settingUi];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationItem.rightBarButtonItem.enabled = ![ConFunc isBlankString:self.textView.text];
}
- (void)dealloc
{
    [Notification_DefaultCenter removeObserver:self];
}

#pragma mark - 触摸手势方法
- (void)leftBarButtonItemAction:(UIBarButtonItem *)sender
{
    QSPLog(@"left");
    
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)rightBarButtonItemAction:(UIBarButtonItem *)sender
{
    if (![ConFunc isBlankString:self.textView.text]) {
        QSPLog(@"right");
        
        [self.view endEditing:YES];
        
        NSMutableArray * dataArr = [NSMutableArray arrayWithCapacity:1];
        for (UIImage *image in self.qspView.images) {
            [dataArr addObject:image];
        }
        [StatusFunction sendStatusWithContent:self.textView.text pictures:dataArr successfulBlock:^(Status *status) {
            [self dismissViewControllerAnimated:YES completion:nil];
            [Notification_DefaultCenter postNotificationName:@"RefreshHomeData" object:nil];
        } failureBlock:^(NSError *error) {
            QSPLog(@"%@",error);
        }];
    }
}
- (void)composeTextViewChangeAction:(NSNotification *)sender
{
    QSPLog(@"%@",self.textView.text);
    
    self.navigationItem.rightBarButtonItem.enabled = ![ConFunc isBlankString:self.textView.text];
}
/*
 UIKeyboardAnimationCurveUserInfoKey = 7;  // 动画的执行节奏(速度)
 UIKeyboardAnimationDurationUserInfoKey = "0.25"; // 键盘弹出\隐藏动画所需要的时间
 UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {320, 216}}";
 UIKeyboardCenterBeginUserInfoKey = "NSPoint: {160, 588}";
 UIKeyboardCenterEndUserInfoKey = "NSPoint: {160, 372}";
 UIKeyboardFrameChangedByUserInteraction = 0;
 
 // 键盘弹出
 UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 480}, {320, 216}}";// 键盘刚出来那一刻的frame
 UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 264}, {320, 216}}"; //  键盘显示完毕后的frame
 
 // 键盘隐藏
 UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 264}, {320, 216}}";
 UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 480}, {320, 216}}";
 */
- (void)keyboardWillChangeFrame:(NSNotification *)sender
{
    NSDictionary *infoDic = sender.userInfo;
    CGRect beginRect = [infoDic[@"UIKeyboardFrameBeginUserInfoKey"] CGRectValue];
    CGRect endRect = [infoDic[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    NSTimeInterval time = [infoDic[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];
    UIViewAnimationCurve curve = [infoDic[@"UIKeyboardAnimationCurveUserInfoKey"] intValue];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:time];
    [UIView setAnimationCurve:curve];
    if (beginRect.origin.y > endRect.origin.y) {//弹出键盘
        self.toolBar.transform = CGAffineTransformMakeTranslation(0, -beginRect.size.height);
    }
    else//隐藏键盘
    {
        self.toolBar.transform = CGAffineTransformIdentity;
    }
    [UIView commitAnimations];
}
- (void)tapGestureRecognizerAction:(UITapGestureRecognizer *)tap
{
    [self.view endEditing:YES];
}

#pragma mark - 自定义方法
- (void)settingUi
{
    self.view.backgroundColor = [UIColor whiteColor];
    //设置导航栏
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItemAction:)];
    self.navigationItem.title = @"发微博";
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizerAction:)];
    [self.view addGestureRecognizer:tap];
    
    //设置控制器
    CGFloat textViewH = 100;
    CGRect rect = (CGRect){{SPACING,MainStatus_NavBar_Height + SPACING},{MainScreen_Width - 2*SPACING,textViewH}};
    ComposeTextView *textView = [[ComposeTextView alloc] initWithFrame:rect];
    textView.font = [UIFont systemFontOfSize:14];
    textView.placeholderColor = [UIColor grayColor];
    textView.placeholder = @"发现新鲜事……";
    textView.delegate = self;
    textView.returnKeyType = UIReturnKeyDone;
    textView.alwaysBounceVertical = YES;
    textView.layer.borderWidth = 1;
    textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:textView];
    self.textView = textView;
    [self.textView becomeFirstResponder];
    
    QSP_ImageSelectView *view = [[QSP_ImageSelectView alloc] init];
    view.frame = CGRectMake(SPACING, CGRectGetMaxY(self.textView.frame), MainScreen_Width - 2*SPACING, MainScreen_Width - 2*SPACING);
    view.qspDelegate = self;
    view.maxImagesCount = 9;
    [self.view addSubview:view];
    self.qspView = view;
    
    ComposeToolBar *toolBar = [[ComposeToolBar alloc] init];
    CGFloat toolBarH = 44;
    toolBar.frame = CGRectMake(0, MainScreen_Height - toolBarH, MainScreen_Width, toolBarH);
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
    self.toolBar = toolBar;
    
    [Notification_DefaultCenter addObserver:self selector:@selector(composeTextViewChangeAction:) name:UITextViewTextDidChangeNotification object:self.textView];
    [Notification_DefaultCenter addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark - <UITextViewDelegate>代理方法
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [textView resignFirstResponder];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}

#pragma mark - <ComposeToolBarDelegate>代理方法
- (void)composeToolBarDelegate:(ComposeToolBar *)toolBar clickedButtonType:(ComposeToolBarButtonType)type
{
    __weak typeof(self) weakSelf = self;
    switch (type) {
        case ComposeToolBarButtonTypeCamera:
        {
            UIImagePickerController *pickCtr = [[UIImagePickerController alloc] init];
            pickCtr.sourceType = UIImagePickerControllerSourceTypeCamera;
            pickCtr.delegate = weakSelf;
            [weakSelf presentViewController:pickCtr animated:YES completion:nil];
        }
            break;
        case ComposeToolBarButtonTypePicture:
        {
            UIImagePickerController *pickCtr = [[UIImagePickerController alloc] init];
            pickCtr.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            pickCtr.delegate = weakSelf;
            [weakSelf presentViewController:pickCtr animated:YES completion:nil];
        }
            
        default:
            break;
    }
}

#pragma mark - <QSP_ImageSelectViewDelegate>代理方法
- (void)imageSelectViewAfterAddPicture:(QSP_ImageSelectView *)view
{
    
}
- (void)imageSelectViewAfterChangePicture:(QSP_ImageSelectView *)view
{
    
}

#pragma mark - <UIImagePickerControllerDelegate>代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [self dismissViewControllerAnimated:YES completion:^{
        [self.textView becomeFirstResponder];
    }];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.qspView addImageButtonsWithImages:[NSArray arrayWithObject:image]];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{
        [self.textView becomeFirstResponder];
    }];
}

@end
