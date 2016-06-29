//
//  homeViewController.m
//  wslDecoration
//
//  Created by 易工 on 15/12/8.
//  Copyright © 2015年 WSL. All rights reserved.
//

#import "homeViewController.h"
#import "homeTableViewCell.h"
#import "searchViewController.h"
#import "personalViewController.h"
#import "AFNetworking.h"
#import "commentViewController.h"
#import "homeModel.h"

#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define LibPATHS [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]

@interface homeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView * tableView;

@property(nonatomic,strong) UIButton * searchBtn;

@property(nonatomic,strong) NSMutableArray * dataSource;

@end

@implementation homeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor colorWithRed:218/255.0f green:217/255.0f blue:218/255.0f alpha:1.0f];
//    [self getDataSource];
    [self setupUI];
  
  
}
#pragma mark --- Help Methods
-(void)setupUI
{    _dataSource = [[NSMutableArray alloc] init];
    [self.view addSubview:self.tableView];
}
- (void)registerNotificaiton
{
    //增加观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toPersonHomepageNotifiEvent:) name:@"toPersonHomepage" object:nil];
}

- (void)getDataSource{
    
    NSString *urlStr = @"";
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
            model.collection_num = [NSString stringWithFormat:@"%@",messageDict[@"collection_num"]];
            model.comment_num = [NSString stringWithFormat:@"%@",messageDict[@"comment_num"]];
            model.praise_num = [NSString stringWithFormat:@"%@",messageDict[@"praise_num"]];
            model.summary = messageDict[@"summary"];
            model.img = messageDict[@"img"];
            model.title = messageDict[@"title"];
            model.headImage = userDict[@"img"];
            model.nickname = userDict[@"nickname"];
            
            [_dataSource addObject:model];
            
        }
        [_tableView reloadData];
        
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
    //调整行距
    [cell setLineSpacing:6.5f label:cell.detailLab];
    
    /*
    homeModel * model =_dataSource[indexPath.row];
    cell.titleLab.text = model.title;
    cell.userNameLabel.text = model.nickname;
    cell.detailLab.text = model.summary;
    cell.collectionLabel.text = model.collection_num;
    cell.commentLabel.text = model.comment_num;
    cell.zanLabel.text = model.praise_num;
    cell.headBtn.layer.cornerRadius = 30;
    cell.headBtn.clipsToBounds = YES;
    
    [cell.headBtn sd_setImageWithURL:[NSURL URLWithString:model.headImage] forState:UIControlStateNormal];
    [cell.picImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@""]];
     */
    
    cell.titleLab.text = @"门窗装修需要注意哪些问题";
    cell.userNameLabel.text =  @"且行且珍惜ios";
    cell.detailLab.text =  @"有媒体曾报道，在我国贵州一处苗族聚居的贫瘠石山区，孩子们住在山上，有媒体曾报道，在我国贵州一处苗族聚居的贫瘠石山区，孩子们住在山上,,,,,";
    cell.collectionLabel.text =  @"888";
    cell.commentLabel.text =  @"666";
    cell.zanLabel.text =  @"999";
    cell.headBtn.layer.cornerRadius = 30;
    cell.headBtn.clipsToBounds = YES;
    
    [cell.headBtn setImage:[UIImage imageNamed:@"home-2"] forState:UIControlStateNormal];
    cell.picImageView.image = [UIImage imageNamed:@"home-1"];
    //cell.timeLabel.text = @"";
    return cell;
}
- (void)loadImageFromNetwork{
    
}
/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIFont *tfont = [UIFont systemFontOfSize:16.0];
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    //// ios 7
    if (_dataSource.count != 0) {
        homeModel * model = _dataSource[indexPath.row];
        CGSize sizeText = [model.summary boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 24, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    }
    
    CGSize sizeText = [@"有媒体曾报道，在我国贵州一处苗族聚居的贫瘠石山区，孩子们住在山上，有媒体曾报道，在我国贵州一处苗族聚居的贫瘠石山区，孩子们住在山上,,,,," boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 24, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return sizeText.height+405;
    
}
 */
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
        _tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49)];
        /**
         *  ios之后的新特性，需结合XIB用
         */
        _tableView.estimatedRowHeight = 44;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        [_tableView registerNib:[UINib nibWithNibName:@"homeTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableHeaderView = self.searchBtn;
    }
    return _tableView;
}
-(UIButton *)searchBtn
{
    if (_searchBtn == nil) {
        _searchBtn =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , 44)];
//        _searchBtn.layer.cornerRadius = 5;
//        _searchBtn.clipsToBounds = YES;
        [_searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
//        [_searchBtn setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        [_searchBtn  addTarget:self action:@selector(searchBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchBtn;
}

-(void)viewDidDisappear:(BOOL)animated
{
    //移除观察者
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"toPersonHomepage" object:nil];
}
- (void)viewWillAppear:(BOOL)animated
{    [super viewWillAppear:animated];
    self.navigationItem.title = @"首页";
     [self registerNotificaiton];
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
