//
//  shootingViewController.m
//  wslDecoration
//
//  Created by 易工 on 15/12/28.
//  Copyright © 2015年 WSL. All rights reserved.
//

#import "shootingViewController.h"
#import "pictureCollectionViewCell.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define LibPATHS [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]
@interface shootingViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong) UICollectionView * collectionView;

@property(nonatomic,strong) NSMutableArray * dataSOurce;

@end

@implementation shootingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark --- Help methods

- (void)setupUI{
    
    [self.view addSubview:self.collectionView];
    
}

#pragma mark --- Events Handel





#pragma mark --- Getter

- (UICollectionView *)collectionView{
    
    if (_collectionView == nil) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        UICollectionViewFlowLayout *  flowLayout = [[UICollectionViewFlowLayout alloc] init];
        //设置item的大小
        flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH - 2) / 3.0, (SCREEN_WIDTH - 2) / 3.0);
        flowLayout.minimumLineSpacing = 1;
        flowLayout.minimumInteritemSpacing = 1;
        //flowLayout.sectionInset = UIEdgeInsetsMake(10, 70,10,20);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 ) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerNib:[UINib nibWithNibName:@"pictureCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"itemID"];
//        //collection头视图的注册
//        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headViewID"];
//        //collection头视图的注册
//        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footViewID"];
    }
    return _collectionView;
}

#pragma mark --- UICollectionViewDataSource,UICollectionViewDelegate

//多少组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}
//每组有几个item
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 9;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    pictureCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"itemID" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"home-1"];
    
    return cell ;
    
}
//选中哪一个
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"indexPath %@",indexPath);
}
//组的头,脚视图创建
/*
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        return nil;
    }
    else
    {
        return nil;
        
    }
   
}
*/
//返回组头视图的高度,宽度
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(SCREEN_WIDTH,70);
    
}
//返回组脚视图的高度,宽度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH - 80 - 20,235);
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
