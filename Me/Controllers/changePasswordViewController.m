//
//  changePasswordViewController.m
//  wslDecoration
//
//  Created by 易工 on 15/12/30.
//  Copyright © 2015年 WSL. All rights reserved.
//

#import "changePasswordViewController.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define LibPATHS [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]

@interface changePasswordViewController ()<UITextFieldDelegate>

@property(nonatomic,strong) UITextField * oldField;

@property(nonatomic,strong) UITextField * xinField;

@property(nonatomic,strong) UITextField * sureField;

@end

@implementation changePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改密码";
    [self setupUI];
}

#pragma mark --- Help methods

- (void)setupUI{
    
    UIButton * sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:sureBtn];
    
    
    _oldField = [[UITextField alloc] initWithFrame:CGRectMake(20, 80 , SCREEN_WIDTH - 40 , 50)];
    _oldField.placeholder = @"请输入旧密码";
    _oldField.borderStyle = UITextBorderStyleRoundedRect;
    _oldField.secureTextEntry = YES;
    _oldField.delegate = self;
    UILabel * oldLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 50)];
    oldLabel.text = @"旧密码";
    oldLabel.textAlignment = NSTextAlignmentCenter;
    _oldField.leftView = oldLabel;
    _oldField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_oldField];
    
    
    _xinField = [[UITextField alloc] initWithFrame:CGRectMake(20, 150 , SCREEN_WIDTH - 40 , 50)];
    _xinField.placeholder = @"请输入新密码";
    _xinField.borderStyle = UITextBorderStyleRoundedRect;
    _xinField.secureTextEntry = YES;
    _xinField.delegate = self;
    UILabel * xinLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 50)];
    xinLabel.text = @"新密码";
    xinLabel.textAlignment = NSTextAlignmentCenter;
    _xinField.leftView = xinLabel;
    _xinField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_xinField];
    
    _sureField = [[UITextField alloc] initWithFrame:CGRectMake(20, 205 , SCREEN_WIDTH - 40 , 50)];
    _sureField.placeholder = @"请输入确认密码";
   _sureField.borderStyle = UITextBorderStyleRoundedRect;
    _sureField.secureTextEntry = YES;
    _sureField.delegate = self;
    UILabel * sureLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 50)];
    sureLabel.text = @"  确认密码";
    sureLabel.textAlignment = NSTextAlignmentCenter;
    _sureField.leftView = sureLabel;
    _sureField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_sureField];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 260, 120, 30)];
    label.adjustsFontSizeToFitWidth = YES;
    label.text = @"可由6-16位字符组成";
    [self.view addSubview:label];
}

- (void)sureBtnClick{
    
    
    
}

//编辑时触发的回调函数
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if ([string isEqualToString:@"\n"])
    {
        return YES;
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
            if ([toBeString length] > 16 ) {
            textField.text = [toBeString substringToIndex:16];
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"温馨提示"                                                                             message:@"密码必须是由6-16位字符组成"                                                                       preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            }]];
            [self presentViewController: alertController animated: YES completion: nil];
        }
    return YES;
    
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
