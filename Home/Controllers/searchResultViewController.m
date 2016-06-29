//
//  searchResultViewController.m
//  wslDecoration
//
//  Created by 易工 on 15/12/9.
//  Copyright © 2015年 WSL. All rights reserved.
//

#import "searchResultViewController.h"
#import "homeTableViewCell.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define LibPATHS [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]

@interface searchResultViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView * tableView;

@end

@implementation searchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}
-(void)setupUI
{
    self.view.backgroundColor =[UIColor blackColor];
    [self.view addSubview:self.tableView];
    //self.navigationItem.backBarButtonItem.title = @"返回";
    
}

#pragma mark --- Event Handel


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
    CGSize sizeText = [@"有媒体曾报道，在我国贵州一处苗族聚居的贫瘠石山区，孩子们住在山上，有媒体曾报道，在我国贵州一处苗族聚居的贫瘠石山区，孩子们住在山上" boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 24, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return sizeText.height+405;
    
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



-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
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
