//
//  reduceViewController.m
//  wslDecoration
//
//  Created by 易工 on 15/12/24.
//  Copyright © 2015年 WSL. All rights reserved.
//

#import "reduceViewController.h"
#import "reduceTableViewCell.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define LibPATHS [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define LibPATHS [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]
@interface reduceViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) UITableView * tableView;

@property(nonatomic,strong) NSMutableArray * dataSource;

@end

@implementation reduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark --- Help methods

- (void)setupUI{
    [self.view addSubview:self.tableView];
    UIButton * delelteBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
    [delelteBtn setTitle:@"删除(1)" forState:UIControlStateNormal];
    [delelteBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:delelteBtn];
}

#pragma mark --- Events Handel


#pragma mark --- UITableViewDataSource,UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    reduceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.selectBtn.layer.cornerRadius = 15;
    cell.selectBtn.layer.borderWidth = 0.5f;
    cell.selectBtn.layer.borderColor = [UIColor grayColor].CGColor;
    cell.clipsToBounds = YES;

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.5;
}

#pragma mark --- Getter

- (UITableView *)tableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = YES;
        [_tableView registerNib:[UINib nibWithNibName:@"reduceTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
    }
    return _tableView;
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
