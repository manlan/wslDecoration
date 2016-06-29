//
//  signatureViewController.m
//  wslDecoration
//
//  Created by 易工 on 15/12/17.
//  Copyright © 2015年 WSL. All rights reserved.
//

#import "signatureViewController.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define LibPATHS [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]
@interface signatureViewController ()

@end

@implementation signatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"签名";
    [self setupUI];

}
- (void)setupUI
{
    self.view.backgroundColor = [UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:245.0f/255.0f alpha:1.0f];
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelBtnClicked)];
    UIButton * saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    [saveBtn addTarget:self action:@selector(saveBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    UITextView * TV = [[UITextView alloc] initWithFrame:CGRectMake(0,80, SCREEN_WIDTH, 100)];
    TV.text = @"春江花月";
    TV.font = [UIFont systemFontOfSize:20];
    TV.scrollEnabled = NO;
    [TV becomeFirstResponder];
    TV.backgroundColor = [UIColor whiteColor];
    [self.view  addSubview:TV];
    
}

- (void)cancelBtnClicked
{
    [self.navigationController popViewControllerAnimated:NO];
    
}
- (void)saveBtnClicked
{
    [self.navigationController popViewControllerAnimated:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
