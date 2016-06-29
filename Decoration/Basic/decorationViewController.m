//
//  decorationViewController.m
//  wslDecoration
//
//  Created by 易工 on 15/12/21.
//  Copyright © 2015年 WSL. All rights reserved.
//

#import "decorationViewController.h"
#import "addPeopleViewController.h"
#import "joinDecorationViewController.h"
#import "shootingViewController.h"
#import "sendViewController.h"
#import "pictureCollectionViewCell.h"
#import "menuTableViewCell.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define LibPATHS [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]

@interface decorationViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    int _isAdding;
}
@property(nonatomic,strong) UIButton * addBtn;

@property(nonatomic,strong) UITableView * tableView;

@property(nonatomic,strong) UICollectionView * collectionView;

@property(nonatomic,strong) NSMutableArray * dataSource;


@end

@implementation decorationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.tabBarItem.badgeValue = nil;
    self.navigationItem.title = @"春江花月";
    [self setupUI];
    
}

#pragma mark --- Help Methods

- (void)setupUI
{
    [self.view  addSubview:self.collectionView];
    _addBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [_addBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(addBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _addBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -17, 0, 17);
    UIBarButtonItem * addBarItem = [[UIBarButtonItem alloc] initWithCustomView:_addBtn];
    self.navigationItem.rightBarButtonItems = @[addBarItem];
    
    [self setupMenuView];
    
    UIButton * shootBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 70, SCREEN_HEIGHT - 100, 50, 50)];
    [shootBtn setImage:[UIImage imageNamed:@"相机"] forState:UIControlStateNormal];
    [shootBtn addTarget:self action:@selector(shootBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shootBtn];
    
}

- (void)setupMenuView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 140 - 20, 64, 140, 150) style:UITableViewStylePlain];
    _tableView.tag = 10;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = NO;
    _tableView.scrollEnabled = NO;
    [_tableView registerNib:[UINib nibWithNibName:@"menuTableViewCell" bundle:nil] forCellReuseIdentifier:@"menuCellID"];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 140, 150)];
    imageView.image = [UIImage imageNamed:@"menu"];
    _tableView.backgroundView = imageView;
    //[self.view  addSubview:_tableView];
    
}

#pragma mark --- Events Handle

- (void)addBtnClicked:(id)sender
{
    _addBtn.layer.anchorPoint = CGPointMake(0.5, 0.5);
    
    if (!_isAdding) {
        
      
    
             [_addBtn setImage:[UIImage imageNamed:@"45X"] forState:UIControlStateNormal];
        
            [self.view addSubview:_tableView];
            _isAdding = 1;
        
    }else{

            [_addBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
            [_tableView removeFromSuperview];
            _isAdding = 0;
     }
    
}

- (void)shootBtnClick{
    
    sendViewController * sendVC = [[sendViewController alloc] init];
    [self.navigationController pushViewController:sendVC animated:NO];
    
}


#pragma mark --- UICollectionViewDataSource,UICollectionViewDelegate
//多少组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 9;
}
//每组有几个item
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 9;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    pictureCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"itemID" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"home-1"];
    return cell ;
    
}
//选中哪一个
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"indexPath %@",indexPath);
}
//组的头,脚视图创建
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
    UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headViewID" forIndexPath:indexPath];
    //headView.backgroundColor = [UIColor greenColor];
        
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    label.backgroundColor = [UIColor grayColor];
    [headView addSubview:label];
        
    UIButton * headBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 15, 50, 50)];
    [headBtn setImage:[UIImage imageNamed:@"home-2"] forState:UIControlStateNormal];
    headBtn.layer.cornerRadius = 25;
    headBtn.clipsToBounds = YES;
    [headView addSubview:headBtn];
    
    UILabel * nameLabel= [[UILabel alloc] initWithFrame:CGRectMake(80, 15, 100, 25)];
    nameLabel.text = @"没礼物";
    nameLabel.font = [UIFont systemFontOfSize:17.0f];
    [headView  addSubview:nameLabel];
    
    UILabel * timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 50, 100, 10)];
    timeLabel.text = @"晚上 18:38";
    timeLabel.font = [UIFont systemFontOfSize:14.0f];
    [headView addSubview:timeLabel];
    
    UIImageView * imageView =[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 40,17.5,15,15)];
    imageView.image = [UIImage imageNamed:@"+"];
    [headView addSubview:imageView];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 40 - 100, 15, 100, 20)];
    titleLabel.font = [UIFont systemFontOfSize:16.0f];
    titleLabel.text = @"拆改主体拆改";
    [headView addSubview:titleLabel];
        
        return headView;
    }
    else
    {

    UICollectionReusableView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footViewID" forIndexPath:indexPath];
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80,0, SCREEN_WIDTH - 80 - 20, 40)];
        titleLabel.text = @"衣柜等拆修";
        [footView addSubview:titleLabel];
        
        UIButton * commentBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 20 - 20, 10, 20, 20)];
        [commentBtn setImage:[UIImage imageNamed:@"评论2"] forState:UIControlStateNormal];
        [footView addSubview:commentBtn];
        
        self.automaticallyAdjustsScrollViewInsets = NO;
        UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(70, 40, SCREEN_WIDTH - 70 - 20, 175) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = NO;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
        [footView addSubview:tableView];
        return footView;
 
    }
    return nil;
}

//返回组头视图的高度,宽度
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(SCREEN_WIDTH,70);
    
}
//返回组脚视图的高度,宽度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH - 80 - 20,235);
}

#pragma mark -- UITableViewdataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 10) {
        
        return 3;
        
    }
    return 3;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag == 10) {
        menuTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"menuCellID" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        
        if (indexPath.row == 0) {
            cell.countL.layer.cornerRadius = 10;
            cell.clipsToBounds = YES;
            cell.countL.hidden = NO;
            cell.imgV.image = [UIImage imageNamed:@"参与装修"];
            cell.xianL.hidden = YES;
            cell.textL.text = @"参与装修";
        }
        if (indexPath.row == 1) {
            cell.imgV.image = [UIImage imageNamed:@"添加成员"];
            cell.textL.text = @"添加成员";
        }
        if (indexPath.row == 2) {
            cell.imgV.image = [UIImage imageNamed:@"标准拍摄"];
            cell.textL.text = @"标准拍摄";
        }
        
        //cell.imageView =
        return cell;
    }
    else{
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
        cell.contentView.backgroundColor = [UIColor colorWithRed:241/255.0f green:241/255.0f blue:241/255.0f alpha:1.0f];
        cell.textLabel.backgroundColor = [UIColor colorWithRed:241/255.0f green:241/255.0f blue:241/255.0f alpha:1.0f];
        cell.textLabel.text = @"你要的感觉：做的很不错，很快呀。亲，你们是什么公司装修的啊？";
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{     if(tableView.tag != 10){
    UIFont *tfont = [UIFont systemFontOfSize:14.0];
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    // ios 7
    CGSize sizeText = [@"你要的感觉：做的很不错，很快呀。亲，你们是什么公司装修的啊？" boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 70 - 20, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return sizeText.height+20;
}else{
    return 50;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 10) {
        return 0;
    }
    return 15;
}
- (UIView * )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView  * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 70 - 20, 15)];
    imageView.image = [UIImage imageNamed:@"评论背景"];
    return imageView;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_addBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [_tableView removeFromSuperview];
    _isAdding = 0;
    
    if (tableView.tag == 10) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        if (indexPath.row == 1) {
            addPeopleViewController * addVC = [[addPeopleViewController alloc] init];
            [self.navigationController pushViewController:addVC animated:NO];
        }else if (indexPath.row == 0){
            
            joinDecorationViewController * joinVC = [[joinDecorationViewController alloc] init];
            [self.navigationController pushViewController:joinVC animated:NO];
            
        }else if (indexPath.row == 2){
        
            shootingViewController * shootVC = [[shootingViewController alloc] init];
            [self.navigationController pushViewController:shootVC animated:NO];
            
        }
        
    }else
    {
        
        
    }
}
#pragma mark --- Getter

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
    self.automaticallyAdjustsScrollViewInsets = NO;
         UICollectionViewFlowLayout *  flowLayout = [[UICollectionViewFlowLayout alloc] init];
        //设置item的大小
        flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH - 92) / 3.0, (SCREEN_WIDTH - 92) / 3.0);
        flowLayout.minimumLineSpacing = 1;
        flowLayout.minimumInteritemSpacing = 1;
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 70,10,20);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49) collectionViewLayout:flowLayout];
         _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:@"pictureCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"itemID"];
        //collection头视图的注册
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headViewID"];
        //collection头视图的注册
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footViewID"];
    }
    return _collectionView;
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
