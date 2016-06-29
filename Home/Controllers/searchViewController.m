//
//  searchViewController.m
//  wslDecoration
//
//  Created by 易工 on 15/12/9.
//  Copyright © 2015年 WSL. All rights reserved.
//

#import "searchViewController.h"
#import "searchResultViewController.h"
#import "searchTableViewCell.h"
#import "homeTableViewCell.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define LibPATHS [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]

@interface searchViewController () <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property(nonatomic,strong) UITableView * tableView;

@property(nonatomic,strong) UITextField * TF;

@property(nonatomic,strong) NSMutableArray * dataSource;

@property(nonatomic,strong) NSMutableArray * searchDataSource;

@property (nonatomic,strong) NSMutableArray * dataSourceCopy;


@end

@implementation searchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerNotificaiton];
    [self setupUI];
}

-(void)setupUI
{
    self.view.backgroundColor = [UIColor blackColor];
    _dataSource = [[NSMutableArray alloc] init];
    _dataSourceCopy = [[NSMutableArray alloc] init];
    _searchDataSource = [[NSMutableArray alloc] init];
    
    
    [self getDataSource];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 50)];
    view.backgroundColor =[UIColor colorWithRed:224/255.0f green:224/255.0f blue:224/255.0f alpha:1.0];
    
    UIButton * cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60 + 10, 10, 40, 30)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [cancelBtn addTarget:self action:@selector(cancleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.TF becomeFirstResponder];
    [view  addSubview:self.TF];
    [view  addSubview:cancelBtn]      ;
    [self.view addSubview:view];
    [self.view addSubview:self.tableView];
}

#pragma mark --- Help Methods

- (void)registerNotificaiton
{
    //增加观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteNotifiEvent:) name:@"deleteSearchRecord" object:nil];
}

-(void)getDataSource
{
    [_dataSource removeAllObjects];
    
    //如果为空，就写入初值
    if ([[NSUserDefaults  standardUserDefaults] objectForKey:@"searchRecordCount"] == nil) {
        [[NSUserDefaults  standardUserDefaults]   setObject: @"0" forKey:@"searchRecordCount"];
    }
    NSString * countStr = [[NSUserDefaults  standardUserDefaults] objectForKey:@"searchRecordCount"];
    for (NSInteger i = [countStr integerValue] - 1 ; i >= 0; i--) {
        if (![[NSUserDefaults  standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%ld",i]]) {
            continue;
        }
        [_dataSource addObject:[[NSUserDefaults  standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%ld",i]]];
          [_dataSourceCopy addObject:[[NSUserDefaults  standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%ld",i]]];
    }
   
    [self.tableView reloadData];
}


#pragma mark --- Event Handle

- (void)deleteNotifiEvent:(NSNotification *)noti
{
    NSDictionary * dict = noti.userInfo;
    NSString * recored1 = dict[@"record"];
    
    NSString * countStr = [[NSUserDefaults  standardUserDefaults] objectForKey:@"searchRecordCount"];
    for (NSInteger i = [countStr integerValue] - 1 ; i >= 0; i--) {
        if (![[NSUserDefaults  standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%ld",i]]) {
            continue;
        }
       NSString * record2 = [[NSUserDefaults  standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%ld",i]];
        if ([recored1 isEqualToString:record2]) {
          [[NSUserDefaults standardUserDefaults] removeObjectForKey:[NSString stringWithFormat:@"%ld",i]];
            //同步到磁盘
            [[NSUserDefaults  standardUserDefaults]  synchronize];
            [self getDataSource];
            
            break;
        }
    }
    
}

-(void)cancleBtnClicked:(id)sender
{
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popToRootViewControllerAnimated:NO];
    
}

#pragma mark --- UITableViewDelegate,UITableViewDataSourc

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    searchTableViewCell * cell = [_tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    NSString * str = _dataSource[indexPath.row];
    cell.searchLabel.text = str;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
 
}
#pragma mark --- UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (![_TF.text isEqualToString:@""] && _TF.text != nil) {
        
        NSString * countStr = [[NSUserDefaults  standardUserDefaults] objectForKey:@"searchRecordCount"];
        //给每一条记录加编号，
      [[NSUserDefaults  standardUserDefaults]   setObject: _TF.text forKey:countStr];
        
        [[NSUserDefaults  standardUserDefaults]   setObject: [NSString stringWithFormat:@"%ld",([countStr integerValue]+ 1)]forKey:@"searchRecordCount"] ;
        
        //同步到磁盘
        [[NSUserDefaults  standardUserDefaults]  synchronize];
        
        
        searchResultViewController * searchResultVC = [[searchResultViewController alloc] init];
        [self.navigationController pushViewController:searchResultVC animated:NO];
        
    }
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    return YES;
}
//编辑过程中调用
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    [_dataSource removeAllObjects];
    
    
     NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    for (NSString * str in _dataSourceCopy) {
        //判断数据源中的字符串是否含有输入的字符串
        NSRange range1 = [str rangeOfString:toBeString];
        
        NSLog(@"%@",toBeString);
        if (range1.location != NSNotFound) {
            
            //如果包含就加到数组
            [_dataSource addObject:str];
        }
    }
    
      [_tableView reloadData];
       return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

#pragma mark --- Getter
-(UITableView *)tableView
{
    if (_tableView == nil) {
        self.automaticallyAdjustsScrollViewInsets =YES;
        _tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 70, SCREEN_WIDTH, SCREEN_HEIGHT - 70 )];
        
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerNib:[UINib nibWithNibName:@"searchTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
        [_tableView registerNib:[UINib nibWithNibName:@"homeTableViewCell" bundle:nil] forCellReuseIdentifier:@"homeCell"];
        _tableView.separatorStyle = NO;
        _tableView.dataSource = self;
        _tableView.delegate = self;
       
    }
    return _tableView;
}
-(UITextField *)TF
{
    if (_TF == nil) {
        _TF = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH - 20 - 60, 30)];
        _TF.backgroundColor = [UIColor whiteColor];
        _TF.borderStyle = UITextBorderStyleRoundedRect;
        _TF.returnKeyType = UIReturnKeySearch;
        _TF.delegate = self;
        _TF.placeholder = @"请输入搜索内容";
        UIImageView * leftV= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"搜索"]];
        leftV.frame = CGRectMake(10, 0, 25, 30);
        _TF.leftView = leftV;
        _TF.leftViewMode = UITextFieldViewModeAlways;
        _TF.keyboardAppearance = UIKeyboardAppearanceLight;
        
    }
    
    return _TF;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    //结束当前视图的所有编辑（收起键盘）
        [self.view endEditing:YES];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //移除观察者
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"deleteSearchRecord" object:nil];
    
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
