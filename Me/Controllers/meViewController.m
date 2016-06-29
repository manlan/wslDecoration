//
//  meViewController.m
//  wslDecoration
//
//  Created by 易工 on 15/12/8.
//  Copyright © 2015年 WSL. All rights reserved.
//

#import "meViewController.h"
#import "nameViewController.h"
#import "signatureViewController.h"
#import "collectionViewController.h"
#import "informationViewController.h"
#import "abounViewController.h"
#import "changePasswordViewController.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define LibPATHS [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]
@interface meViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,strong) UIImageView * imageView;
@property(nonatomic,strong) UITableView * tableView;

@property(nonatomic,strong) NSMutableArray * dataSource;

@end

@implementation meViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    
    self.view.backgroundColor =[UIColor colorWithRed:223/255.0f green:224/255.0f blue:225/255.0f alpha:1.0];
    self.navigationController.tabBarItem.badgeValue = nil;
    _dataSource =[[NSMutableArray alloc] initWithObjects:@"头像",@"名字",@"签名",@"收藏",@"消息",@"密码管理",@"关于", nil];
    
    [self.view addSubview:self.tableView];
}

#pragma mark --- UITableViewDataSource ,UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 2){
    return 1;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellID"];
    }
    if (indexPath.section == 0) {
        
         cell.textLabel.text = _dataSource[indexPath.row];
        if (indexPath.row == 0) {
            _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 10, 80, 80)];
            _imageView.image = [UIImage imageNamed:@"默认头像"];
            _imageView.layer.cornerRadius = 40;
            _imageView.clipsToBounds = YES;
            [cell.contentView addSubview:_imageView];
            
        }
        if (indexPath.row == 1) {
            cell.detailTextLabel.text = @"春江花月";
        }
        if (indexPath.row == 2) {
            cell.detailTextLabel.text = @"一路走来，有你陪伴一路走来，有你陪伴一路走来一路走来，有你陪伴一路走来，有你陪伴一路走来一路走来，";
        }
    }
    if (indexPath.section == 1) {
        cell.textLabel.text =  _dataSource[3+indexPath.row];
    }
    if (indexPath.section == 2) {
       cell.textLabel.text =  _dataSource[6];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0 ) {
        if (indexPath.row == 0) {
            [self changeHeadPicture];
        }
        if (indexPath.row == 1) {
            
            nameViewController * nameVC = [[nameViewController alloc] init];
            [self.navigationController pushViewController:nameVC animated:NO];
        }
        if (indexPath.row == 2) {
            signatureViewController *signatureVC = [[signatureViewController alloc] init];
            [self.navigationController pushViewController:signatureVC animated:NO];
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            collectionViewController * collectionVC = [[collectionViewController alloc] init];
            [self.navigationController pushViewController:collectionVC animated:NO];
        }
        if (indexPath.row == 1) {
            informationViewController * inforVC = [[informationViewController alloc] init];
            [self.navigationController pushViewController:inforVC animated:NO];
        }
        if (indexPath.row == 2) {
            changePasswordViewController * passwordVC = [[changePasswordViewController alloc] init];
            [self.navigationController pushViewController:passwordVC animated:NO];
        }
    }
    if(indexPath.section == 2){
        abounViewController * aboutVC = [[abounViewController alloc] init];
        [self.navigationController pushViewController:aboutVC animated:NO];
    }
    
}
//换头像
- (void)changeHeadPicture
{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil                                                                             message: nil                                                                       preferredStyle:UIAlertControllerStyleActionSheet];
    //添加Button
    [alertController addAction: [UIAlertAction actionWithTitle: @"拍照" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //处理点击拍照
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [self loadImagePickerWithSourceType:UIImagePickerControllerSourceTypeCamera];
        }else{
            [self showAlertWithMessage:@"相机无法使用"];
        }
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"从相册选取" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //处理点击从相册选取
        //相册库
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            [self loadImagePickerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        }else{
            [self showAlertWithMessage:@"无法获取相册库"];
        }
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController: alertController animated: YES completion: nil];
    
}
//调用相机和相册库资源
- (void)loadImagePickerWithSourceType:(UIImagePickerControllerSourceType)type{
    //UIImagePickerController 系统封装好的加载相机、相册库资源的类
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //加载不同的资源
    picker.sourceType =type;
    //是否允许picker对图片资源进行优化
    picker.allowsEditing = YES;
    picker.delegate = self;
    //软件中习惯通过present的方式，呈现相册库
    [self presentViewController:picker animated:YES completion:^{
    }];
}
- (void)showAlertWithMessage:(NSString *)message{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"温馨提示"                                                                             message:message                                                                       preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }]];
    [self presentViewController: alertController animated: YES completion: nil];
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0 && indexPath.row == 0){
        return 100;
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        return 55;
    }
    return 49;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.5;
}

#pragma mark - UIImagePickerControllerDelegate
//点击cancel按钮，调用此方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    NSLog(@"cancel!");
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}
//点击choose按钮的时候，触发此方法
//info 带有选中资源的信息
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //获取资源的类型(图片or视频)
   // NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    //kUTTypeImage 代表图片资源类型
   // if ([mediaType isEqualToString:]) {
        //直接拿到选中的图片,
        //手机拍出的照片大概在2M左右，拿到程序中对图片进行频繁处理之前，需要对图片进行转换，否则很容易内存超范围，程序被操作系统杀掉
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    _imageView.image = image;
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark --- Getter

- (UITableView *)tableView{
    
    if (_tableView == nil) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49) style:UITableViewStyleGrouped];
        _tableView.scrollEnabled = NO;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
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
