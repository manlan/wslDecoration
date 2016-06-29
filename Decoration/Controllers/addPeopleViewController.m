//
//  addPeopleViewController.m
//  wslDecoration
//
//  Created by 易工 on 15/12/23.
//  Copyright © 2015年 WSL. All rights reserved.
//

#import "addPeopleViewController.h"
#import "decorationNameViewController.h"
#import "UMSocial.h"

#import "addTableViewCell.h"
#import "addViewController.h"
#import "reduceViewController.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define LibPATHS [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]

@interface addPeopleViewController ()<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong) UITableView * tableView;

@property(nonatomic,strong) NSMutableArray * dataSource;

@end

@implementation addPeopleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];

}

#pragma mark --- Help Methods

- (void)setupUI{
 
    [self.view  addSubview:self.tableView];
    
}


#pragma mark --- Events Handel

- (void)addBtnClick
{
    addViewController * addVC = [[addViewController alloc] init];
    [self.navigationController pushViewController:addVC animated:NO];
    
}

- (void)reduceBtnClick
{
    reduceViewController * reduseVC = [[reduceViewController alloc] init];
    [self.navigationController pushViewController:reduseVC animated:NO];
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
    
    if(indexPath.section == 0){
        
        addTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"addCellID" forIndexPath:indexPath];
        return cell;
        
    }else
    {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellID"];
        }
        if (indexPath.row == 0) {
            cell.detailTextLabel.text = @"春江花月";
            cell.detailTextLabel.backgroundColor = [UIColor blackColor];
            cell.textLabel.text = @"装修名称";
             cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (indexPath.row == 1) {
            cell.detailTextLabel.text = @"易工2015";
            cell.textLabel.text = @"参考标准";
            
        }
        if (indexPath.row == 2) {
            cell.textLabel.text = @"邀请";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{    if(indexPath.section == 0){
    return 65;}
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 60;
    }
    return 76;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 20;
    }
    return 0.1;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if(section == 0){
      
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, 60)];
        
        UIButton * addBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 30, 30)];
        [addBtn setImage:[UIImage imageNamed:@"加"] forState:UIControlStateNormal];
        addBtn.center = CGPointMake(SCREEN_WIDTH / 4, 30);
        [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [view  addSubview:addBtn];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 0.5, 40)];
        label.backgroundColor = [UIColor blackColor];
        label.center = CGPointMake(SCREEN_WIDTH / 2, 30);
        [view addSubview:label];
        
        UIButton * reduceBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 30, 30)];
        [reduceBtn setImage:[UIImage imageNamed:@"减"] forState:UIControlStateNormal];
        reduceBtn.center = CGPointMake(SCREEN_WIDTH / 4 * 3, 30);
        [reduceBtn addTarget:self action:@selector(reduceBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:reduceBtn];
        
        return view;
        
    }else {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 76)];
        UIButton * deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 14, SCREEN_WIDTH - 40, 48)];
        deleteBtn.layer.cornerRadius = 5;
        deleteBtn.clipsToBounds = YES;
        deleteBtn.backgroundColor = [UIColor colorWithRed:223/255.0f green:84/255.0f blue:84 / 255.0f alpha:1.0f];
        [deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [deleteBtn setTitle:@"删除并退出" forState:UIControlStateNormal];
        [view addSubview:deleteBtn];
        
        return view;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section == 1) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
        view.backgroundColor = [UIColor colorWithRed:224/255.0f green:224/255.0f blue:224/255.0f alpha:1.0f];
        return view;
    }
       return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            decorationNameViewController * decorationNameVC = [[decorationNameViewController alloc] init];
            [self.navigationController pushViewController:decorationNameVC animated:NO];
            
        }else if (indexPath.row == 2){
            
            [UMSocialSnsService presentSnsIconSheetView :self appKey:@"507fcab25270157b37000010" shareText:@"杭州易工科技有限公司欢迎您http://www.yg-technology.com" shareImage:[UIImage imageNamed:@"默认头像"] shareToSnsNames:@[ UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToEmail,UMShareToSms,UMShareToLine] delegate:nil];
        }
    }
    
}

#pragma mark --- Getter

- (UITableView *)tableView{
    
    if (_tableView == nil) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = YES;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerNib:[UINib nibWithNibName:@"addTableViewCell" bundle:nil] forCellReuseIdentifier:@"addCellID"];
    }
    return _tableView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
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
