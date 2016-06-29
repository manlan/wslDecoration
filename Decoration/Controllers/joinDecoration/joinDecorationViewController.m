//
//  joinDecorationViewController.m
//  wslDecoration
//
//  Created by 易工 on 15/12/25.
//  Copyright © 2015年 WSL. All rights reserved.
//

#import "joinDecorationViewController.h"
#import "agreeViewController.h"
#import "addViewController.h"
#import "groupTableViewCell.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define LibPATHS [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]
@interface joinDecorationViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView * tableView;

@end

@implementation joinDecorationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark --- Help methods

- (void)setupUI{
    
   UIButton * addBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [addBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    addBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -17, 0, 17);
    UIBarButtonItem * addBarItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
    self.navigationItem.rightBarButtonItem = addBarItem;
    
    [self.view  addSubview:self.tableView];
    
}

#pragma mark --- Events Handel

- (void)addBtnClick{
    
    addViewController * addVC = [[addViewController alloc] init];
    [self.navigationController pushViewController:addVC animated:NO];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    groupTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    [cell reloadData];
    if (indexPath.row == 0) {
        cell.groupNameLabel.text = @"有新的装修邀请";
    }

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.5;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if(indexPath.row == 0){
        agreeViewController * agreeVC = [[agreeViewController alloc] init];
        [self.navigationController pushViewController:agreeVC animated:NO];
    }
    
}

#pragma mark --- Getter

- (UITableView *)tableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[groupTableViewCell class] forCellReuseIdentifier:@"cellID"];
        
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
