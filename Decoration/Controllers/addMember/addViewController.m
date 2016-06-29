//
//  addViewController.m
//  wslDecoration
//
//  Created by 易工 on 15/12/24.
//  Copyright © 2015年 WSL. All rights reserved.
//

#import "addViewController.h"
#import "addPersonTableViewCell.h"
#import "userTableViewCell.h"
#import "phoneNumberTableViewCell.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define LibPATHS [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]

@interface addViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong) UITextField * field;

@property(nonatomic,strong) UITableView * tableView;

@property(nonatomic,strong) NSMutableArray * dataSource;

@end

@implementation addViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"添加装修小伙伴";
    _dataSource = [[NSMutableArray alloc] init];
    [self setupUI];
 }
#pragma mark --- Help Methods

- (void)setupUI
{
    
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelBtnClicked)];
    UIButton * saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [saveBtn setTitle:@"确定" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    [saveBtn addTarget:self action:@selector(saveBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view  addSubview:self.tableView];
    
    
}

#pragma mark --- Events Handel

- (void)cancelBtnClicked{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)saveBtnClicked{
    [self.navigationController popViewControllerAnimated:NO];
    
}
- (void)addPeopleClick{
    
    
}

#pragma mark --- UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1){
        addPersonTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELLID" forIndexPath:indexPath];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.selectBtn.layer.cornerRadius = 8;
        cell.selectBtn.layer.borderWidth = 0.5f;
        cell.selectBtn.layer.borderColor = [UIColor grayColor].CGColor;
        cell.clipsToBounds = YES;
        return cell;
    }
    else
    {
        if (indexPath.row == 0 || indexPath.row == 1) {
            
            phoneNumberTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"numberCELLID" forIndexPath:indexPath];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }
        userTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"userCELLID" forIndexPath:indexPath];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.headImgV.layer.cornerRadius = 15;
        
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 60;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 30;
    }
    return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, 70)];
        view.backgroundColor =[UIColor whiteColor];
        _field = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 10 - 100, 40)];
        _field.tag =11;
        _field.keyboardType = UIKeyboardTypePhonePad;
        _field.delegate = self;
        _field.placeholder = @"在此输入手机号码";
        _field.borderStyle =  UITextBorderStyleRoundedRect;
        
        UIButton * addBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 20 - 60, 10, 60, 40)];
        addBtn.backgroundColor = [UIColor colorWithRed:206/255.0f green:206/255.0f blue:206/255.0f alpha:1.0f];
        addBtn.tag = 12;
        [addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        addBtn.layer.cornerRadius = 5;
        addBtn.clipsToBounds = YES;
        [addBtn setTitle:@"添加" forState:UIControlStateNormal];
        [addBtn  addTarget:self action:@selector(addPeopleClick) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:_field];
        [view addSubview:addBtn];
        return view;
        
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        view.backgroundColor = [UIColor colorWithRed:241/255.0f green:241/255.0f blue:241/255.0f alpha:1.0f];
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 100, 30)];
        [button setImage:[UIImage imageNamed:@"五角星"] forState:UIControlStateNormal];
        [button setTitle:@"最近" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.imageEdgeInsets = UIEdgeInsetsMake(3, 5, 3,60);
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [view  addSubview:button];
        return view;
    }
    return nil;
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [self.view  endEditing:YES];
}

#pragma mark --- UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if ([string isEqualToString:@"\n"])
    {
        return YES;
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    UITextField * field = (UITextField *)[self.view viewWithTag:11];
    if (field == textField)
    {
        if ([toBeString length] > 11) {
            textField.text = [toBeString substringToIndex:11];
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"温馨提示"                                                                             message:@"输入的手机号码位数过多"                                                                       preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            }]];
            [self presentViewController: alertController animated: YES completion: nil];
        }
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    UIButton * addBtn = (UIButton *)[self.view viewWithTag:12];
    addBtn.backgroundColor = [UIColor colorWithRed:117/255.0f green:202/255.0f blue:57/255.0f alpha:1.0f];
    [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}

#pragma mark --- Getter

- (UITableView *)tableView{
    
    if (_tableView == nil) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerNib:[UINib nibWithNibName:@"addPersonTableViewCell" bundle:nil] forCellReuseIdentifier:@"CELLID"];
        [_tableView registerNib:[UINib nibWithNibName:@"userTableViewCell" bundle:nil] forCellReuseIdentifier:@"userCELLID"];
        
        [_tableView registerNib:[UINib nibWithNibName:@"phoneNumberTableViewCell" bundle:nil] forCellReuseIdentifier:@"numberCELLID"];
        
    }
    return _tableView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
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
