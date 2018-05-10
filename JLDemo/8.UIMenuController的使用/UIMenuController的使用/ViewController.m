//
//  ViewController.m
//  UIMenuController的使用
//
//  Created by 杨建亮 on 2017/9/22.
//  Copyright © 2017年 yangjianliang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor redColor];
    
    UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo:)];
    longPressGr.minimumPressDuration = 0.5;
    [self.view addGestureRecognizer:longPressGr];
    
    
    UIButton* brn = [[UIButton alloc] initWithFrame:CGRectMake(100, 250, 100, 100)];
    brn.backgroundColor = [UIColor purpleColor];
    [brn addTarget:self action:@selector(clcik:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:brn];
}

-(void)longPressToDo:(UILongPressGestureRecognizer *)gesture
{
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        CGPoint point = [gesture locationInView:self.view];
        [self addMenuControllerWith:point];
    }
}
#pragma mark 菜单选项
-(void)addMenuControllerWith:(CGPoint)point
{
    [self becomeFirstResponder]; //MSCLeftTableViewCell默认是不能响应事件的，所以要让它成为第一响应者
    UIMenuController *menuVC = [UIMenuController sharedMenuController];
    [menuVC setTargetRect:CGRectMake(100, 100, 0, 0) inView:self.view]; //定位Menu
    [menuVC setMenuVisible:YES animated:YES]; //展示Menu
}
- (BOOL)canBecomeFirstResponder { //指定MSCLeftTableViewCell可以成为第一响应者 切忌不要把这个方法不小心写错了哟， 不要写成 becomeFirstResponder
    return YES;
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender { //指定该MSCLeftTableViewCell可以响应的方法
    //    NSLog(@"%@",NSStringFromSelector(action));
    if (action == @selector(copy:)) {
        return YES;
    }
    if (action == @selector(select:)) {
        return YES;
    }
    if (action == @selector(selectAll:)) {
        return YES;
    }
    return YES;
}
- (void)copy:(id)sender {
        UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    pasteBoard.string = @"66666";
    //    self.pasteBoard.string = self.text;
    //    NSLog(@"复制");
    //    self.pasteBoard.color = self.backgroundColor;
}

-(void)select:(id)sender {
    //    self.pasteBoard.string = self.text;
    //    self.text = @"";
}
- (void)selectAll:(id)sender {
    //    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    //    pasteBoard.string = self.text;
    //    self.textColor = [UIColor blueColor];
    //    NSLog(@"全选的数据%@", pasteBoard.string);
}


////复制
//-(void)doCopy:(id)sender{
//    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
//    //这其实就是一个剪切板  UIPasteboard
//    pboard.string = self.messageVo.body;
//    [MBProgressHUD showSuccess:@"复制成功"];
//
//}
////转发
//-(void)doForward:(id)sender{
//    DCSAddMessageViewController *add = [[DCSAddMessageViewController alloc]init];
//    add.checkIsForward = YES;
//    add.inMessageVo = self.messageVo;
//    [self.navigationController pushViewController:add animated:YES];
//}
////保存图片
//-(void)doSavePhoto:(id)sender{
//    NSURL *url = [NSURL URLWithString:self.messageVo.attachmentVo.attachUrl];
//    UIImageView *viw = [[UIImageView alloc]init];
//    [viw sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        if(!error) {
//            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
//        }
//    }];
//}

-(void)clcik:(UIButton*)sender
{
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    NSLog(@"%@",pasteBoard.string);
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
  
}



@end
