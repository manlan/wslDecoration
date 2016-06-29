//
//  groupTableViewCell.h
//  wslDecoration
//
//  Created by 易工 on 15/12/25.
//  Copyright © 2015年 WSL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface groupTableViewCell : UITableViewCell <UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong) UICollectionView * collectionView;

@property(nonatomic,strong)  UILabel * groupNameLabel;

@property(nonatomic,strong) UILabel * newsCountLabel;
@property(nonatomic,strong) UILabel * alreadyLabel;
@property(nonatomic,strong) UIButton * joinBtn;
@property(nonatomic,strong) UIButton * refuseBtn;

@property(nonatomic,strong) NSMutableArray * dataSource;
@property(nonatomic,assign) int isOrNotNews;

- (void)reloadData;

@end
