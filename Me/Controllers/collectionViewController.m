//
//  collectionViewController.m
//  wslDecoration
//
//  Created by 易工 on 15/12/19.
//  Copyright © 2015年 WSL. All rights reserved.
//

#import "collectionViewController.h"
#import "homeTableViewCell.h"
#import "searchViewController.h"
#import "personalViewController.h"
#import "AFNetworking.h"
#import "commentViewController.h"
#import "homeModel.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define LibPATHS [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]

@interface collectionViewController ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong) UITableView * tableView;


@property(nonatomic,strong) NSMutableArray * dataSource;
@end

@implementation collectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"收藏";
    [self getDataSource];
    [self setupUI];
}
#pragma mark --- Help Methods
-(void)setupUI
{
    self.view.backgroundColor =[UIColor colorWithRed:218/255.0f green:217/255.0f blue:218/255.0f alpha:1.0f];
    _dataSource = [[NSMutableArray alloc] init];
    [self.view addSubview:self.tableView];
}
- (void)registerNotificaiton
{
    //增加观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toPersonHomepageNotifiEvent:) name:@"toPersonHomepage" object:nil];
}

- (void)getDataSource{
    
    NSString *urlStr = @"http://192.168.0.163:8080/Decorate_a/message/listIndexMsg.do";
    NSDictionary *params = @{@"username": @"15267287490"};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        id jsonObj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSArray * dataArray = jsonObj[0][@"data"];
        for (NSDictionary * dict in dataArray) {
            
            NSDictionary * messageDict = dict[@"message"];
            NSDictionary * userDict = dict[@"simpleUser"];
            homeModel * model =[[homeModel alloc] init];
            model.collection_num = messageDict[@"collection_num"];
            model.comment_num = messageDict[@"comment_num"];
            model.praise_num = messageDict[@"praise_num"];
            model.summary = messageDict[@"summary"];
            model.img = [NSString stringWithFormat:@"http://192.168.0.163:8080/Decorate_a%@",messageDict[@"img"]];
            model.title = messageDict[@"title"];
            model.headImage = userDict[@"img"];
            model.nickname = userDict[@"nickname"];
            
            [_dataSource addObject:model];
            
        }
        NSLog(@" %ld", _dataSource.count );
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error %@",error);
        
    }];
    
    
}
#pragma mark --- Event Handel
-(void)searchBtnClicked:(id)sender
{
    searchViewController * searchVC = [[searchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:NO];
}
- (void)toPersonHomepageNotifiEvent:(NSNotification *)noti
{
    personalViewController * personVC = [[personalViewController alloc] init];
    self.navigationItem.title = @"返回";
    [self.navigationController pushViewController: personVC animated:NO];
}

#pragma mark --- UITableViewDelegate,UITableViewDataSourc
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    homeTableViewCell * cell = [_tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    cell.shareBtn.hidden = YES;
    [cell setLineSpacing:6.5f label:cell.detailLab];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIFont *tfont = [UIFont systemFontOfSize:16.0];
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    //// ios 7
    CGSize sizeText = [@"有媒体曾报道，在我国贵州一处苗族聚居的贫瘠石山区，孩子们住在山上，有媒体曾报道，在我国贵州一处苗族聚居的贫瘠石山区，孩子们住在山上，" boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 24, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return sizeText.height+405;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    commentViewController * commentVC = [[commentViewController alloc] init];
    [self.navigationController pushViewController:commentVC animated:NO];
    
}
#pragma mark --- Getter
-(UITableView *)tableView
{
    if (_tableView == nil) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        _tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        //        _tableView.backgroundColor = [UIColor colorWithRed:218/255.0f green:217/255.0f blue:218/255.0f alpha:1.0f];
        [_tableView registerNib:[UINib nibWithNibName:@"homeTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //移除观察者
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"toPersonHomepage" object:nil];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewWillAppear:(BOOL)animated
{    [super viewWillAppear:animated];
    [self registerNotificaiton];
    self.tabBarController.tabBar.hidden = YES;
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
