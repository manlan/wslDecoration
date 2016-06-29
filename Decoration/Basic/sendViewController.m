//
//  sendViewController.m
//  wslDecoration
//
//  Created by 易工 on 15/12/31.
//  Copyright © 2015年 WSL. All rights reserved.
//

#import "sendViewController.h"
#import "pictureCollectionViewCell.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define LibPATHS [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]

@interface sendViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UITextViewDelegate>

@property(nonatomic,strong) UICollectionView * collectionView;

@property(nonatomic,strong) UITextView * textView;

@property(nonatomic,strong) NSMutableArray * dataSOurce;
@end

@implementation sendViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark --- Help methods

- (void)setupUI{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    [self.view addSubview:self.collectionView];

}
#pragma mark --- Events Handel

- (void)cancel{
    
    [self.navigationController popViewControllerAnimated:NO];
    
}

- (void)send{
    
    
}

#pragma mark --- Events Handel



#pragma mark --- UICollectionViewDataSource,UICollectionViewDelegate

//多少组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//每组有几个item
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
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
 - (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
 
 if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
      UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headViewID" forIndexPath:indexPath];
     [headView addSubview:self.textView];
     return headView;
 }
 else
 {
     UICollectionReusableView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footViewID" forIndexPath:indexPath];
     UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH - 20, 0.5)];
     label1.backgroundColor = [UIColor grayColor];
     UILabel * label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH - 20, 0.5)];
     label2.backgroundColor = [UIColor grayColor];
     [footView addSubview:label1];
     [footView addSubview:label2];
     return footView;
 
 }
 
 }

//返回组头视图的高度,宽度
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{

    return CGSizeMake(SCREEN_WIDTH - 20, 130);
    
}
//返回组脚视图的高度,宽度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH - 20,80);
}

#pragma mark --- UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView{
    
    UILabel * label = (UILabel *)[self.view viewWithTag:13];
    [label removeFromSuperview];
}


#pragma mark --- Getter

- (UICollectionView *)collectionView{
    
    if (_collectionView == nil) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        UICollectionViewFlowLayout *  flowLayout = [[UICollectionViewFlowLayout alloc] init];
        //设置item的大小
        flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH - 4 - 20) / 3.0, (SCREEN_WIDTH - 4 - 20) / 3.0);
        flowLayout.minimumLineSpacing = 2;
        flowLayout.minimumInteritemSpacing = 2;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 ) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerNib:[UINib nibWithNibName:@"pictureCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"itemID"];
                //collection头视图的注册
                [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headViewID"];
                //collection脚视图的注册
                [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footViewID"];
    }
    return _collectionView;
}

- (UITextView *)textView{
    
    
    if (_textView == nil) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 20, 120)];
        _textView.delegate = self;
        _textView.font = [UIFont systemFontOfSize:16];
        _textView.returnKeyType = UIReturnKeyDone;
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 120, 20)];
        label.text = @"这一刻的想法...";
        label.tag = 13;
        label.textColor = [UIColor grayColor];
        [_textView addSubview:label];
    }
    
    return _textView;
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
