//
//  MyTabBarController.m
//  wslProject
//
//  Created by qianfeng on 15/10/14.
//  Copyright (c) 2015年 WSL. All rights reserved.
//

#import "MyTabBarController.h"
#import "homeViewController.h"
#import "decorationViewController.h"
#import "meViewController.h"
#import "wslNavigationController.h"

@interface MyTabBarController ()

@end

@implementation MyTabBarController

-(instancetype)init
{
    if (self = [super init]) {
       
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.translucent = YES;
    
    
    NSArray * titles = @[@"首页",@"装修",@"我"];
    NSArray * imageNames = @[@"home", @"decoration", @"me"];
    
    NSArray * vcClasses = @[[homeViewController class], [decorationViewController class], [meViewController class]];
    
    NSMutableArray * vcs = [NSMutableArray array];
    for (NSInteger i = 0; i < 3; i++) {
        
        UIViewController * vc = [[vcClasses[i] alloc] init];
        
        vc.title = titles[i];
        
        wslNavigationController * nvc = [[wslNavigationController alloc] initWithRootViewController:vc];
        
        UIImage * tabImg = [[UIImage imageNamed:[NSString stringWithFormat:@"%@A", imageNames[i]]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        
        UIImage * selectedTabImg = [[UIImage imageNamed:[NSString stringWithFormat:@"%@B", imageNames[i]]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
         nvc.tabBarItem =  [[UITabBarItem alloc] initWithTitle:nil image:tabImg  selectedImage:selectedTabImg];
        
        if (i == 1) {
            nvc.tabBarItem.badgeValue = @"8";
        }
        if (i == 2) {
            nvc.tabBarItem.badgeValue = @"";
        }

        
//        [nvc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]} forState:UIControlStateNormal];
//        
//        [nvc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} forState:UIControlStateSelected];
        
    nvc.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
        
        [vcs addObject:nvc];
    }
    
    self.viewControllers = vcs;
}
- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize

{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return reSizeImage;
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
