//
//  personalViewController.m
//  wslDecoration
//
//  Created by 易工 on 15/12/14.
//  Copyright © 2015年 WSL. All rights reserved.
//

#import "personalViewController.h"
#import "homeTableViewCell.h"
#import "UMSocial.h"


#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define LibPATHS [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]

@interface personalViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation personalViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
  
}

#pragma mark --- Help Methods
- (void)setupUI{
    UIButton * shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25 , 25)];
    [shareBtn addTarget:self action:@selector(sharebtnClicked) forControlEvents: UIControlEventTouchUpInside];
    [shareBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    shareBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];
    
    UIView * view =[[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 180)];
    view.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:241.0f/255.0f blue:242.0f/255.0f alpha:1.0f];
    [self.view addSubview:view];
    
    _headImageView = [[UIImageView alloc]
                      initWithImage:[UIImage imageNamed:@"home-2"]];
    _headImageView.frame = CGRectMake(100, 100,80,80);
    
    _headImageView.center = CGPointMake(SCREEN_WIDTH/2, 60);
    [view addSubview:_headImageView];
    
    _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 105, SCREEN_WIDTH, 40)];
    _userNameLabel.textAlignment  = NSTextAlignmentCenter;
    _userNameLabel.font = [UIFont boldSystemFontOfSize:22];
    _userNameLabel.text = @"且行且珍惜iOS";
    [view addSubview:_userNameLabel];
    
    UILabel * shuxianLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1, 20)];
    shuxianLabel.center = CGPointMake(SCREEN_WIDTH / 2, 160);
    shuxianLabel.backgroundColor =[UIColor blackColor];
    [view addSubview:shuxianLabel];
    
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 60 - 40, 150, 40 , 20)];
    label.text = @"文章";
    [view addSubview:label];
    
    
    _articleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 60,150 , 50, 20)];
    _articleLabel.text = @"300";
    _articleLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:_articleLabel];
    
    UILabel * liulanLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 + 10,150, 40, 20)];
    liulanLabel.textAlignment = NSTextAlignmentRight;
    liulanLabel.text = @"浏览";
    [view addSubview:liulanLabel];
    
    _browseLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 + 10 + 50, 150, 50, 20)];
    _browseLabel.text = @"13万";
    [view addSubview:_browseLabel];
    
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    
    [_tableView registerNib:[UINib nibWithNibName:@"homeTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableHeaderView = view;
    [self.view  addSubview:_tableView];
    
}

#pragma mark --- Events Handle

- (void)sharebtnClicked{
    //__weak personalViewController * weakSelf = self;
    [UMSocialSnsService presentSnsIconSheetView :self appKey:@"507fcab25270157b37000010" shareText:@"杭州易工科技有限公司欢迎您http://www.yg-technology.com" shareImage:[UIImage imageNamed:@"默认头像"] shareToSnsNames:@[ UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone,UMShareToSina] delegate:nil];
    
}

#pragma mark --- UITableViewDelegate,UITableViewDataSourc
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    homeTableViewCell * cell = [_tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
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

- (void)viewWillAppear:(BOOL)animated{
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
