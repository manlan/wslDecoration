//
//  groupTableViewCell.m
//  wslDecoration
//
//  Created by 易工 on 15/12/25.
//  Copyright © 2015年 WSL. All rights reserved.
//

#import "groupTableViewCell.h"
#import "pictureCollectionViewCell.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define LibPATHS [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]
@implementation groupTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self customCell];
        
    }
    return self;
}

- (void)customCell{
    
    self.collectionView = [self createGroupHeadImage:CGSizeMake((60 - 1) / 2.0f, (60 - 1) / 2.0f)];
    UILabel * groupNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 10, SCREEN_WIDTH - 100 - 90 , 50)];
    groupNameLabel.numberOfLines = 2;
    self.groupNameLabel = groupNameLabel;
    
    UILabel * newsCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
    newsCountLabel.center = CGPointMake(80, 10);
    newsCountLabel.layer.cornerRadius = 9;
    newsCountLabel.clipsToBounds = YES;
    newsCountLabel.backgroundColor = [UIColor redColor];
    newsCountLabel.textAlignment = NSTextAlignmentCenter;
    newsCountLabel.font = [UIFont systemFontOfSize:14];
    newsCountLabel.textColor = [UIColor whiteColor];
    self.newsCountLabel = newsCountLabel;
    
    [self addPart];
    
    [self.contentView addSubview:self.groupNameLabel];
    [self.contentView addSubview:self.collectionView];
    [self.contentView addSubview:self.newsCountLabel];
    
}

- (void)reloadData{
    
    if (_isOrNotNews == 1) {
        
//        self.alreadyLabel.hidden = NO;
//        self.joinBtn.hidden = NO;
//        self.refuseBtn.hidden = NO;
        
    }
    
    self.groupNameLabel.text = @"天使和魔鬼只在一念之间";
     self.newsCountLabel.text = @"13";
    
}

- (void)addPart{
    
    UILabel * alreadyLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 100, 15, 80, 40)];
    alreadyLabel.hidden = YES;
    alreadyLabel.textAlignment = NSTextAlignmentCenter;
    self.alreadyLabel = alreadyLabel;
    
    UIButton * joinBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 50/2.0, 20, 20)];
    joinBtn.hidden = YES;
    [joinBtn setImage:[UIImage imageNamed:@"dui"] forState:UIControlStateNormal];
    [joinBtn addTarget:self action:@selector(joinBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    self.joinBtn = joinBtn;
    
    UIButton * refuseBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 40, 50/2.0, 20, 20)];
    refuseBtn.hidden = YES;
    [refuseBtn setImage:[UIImage imageNamed:@"X"] forState:UIControlStateNormal];
    [refuseBtn addTarget:self action:@selector(refuseBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.refuseBtn = refuseBtn;
    
    [self.contentView addSubview:alreadyLabel];
    [self.contentView addSubview:joinBtn];
    [self.contentView addSubview:refuseBtn];
    
    
}

#pragma mark --- Events Handel

- (void)joinBtnClicked{
    
    self.joinBtn.hidden = YES;
    self.refuseBtn.hidden = YES;
    self.alreadyLabel.text = @"已经加入";
    
}

- (void)refuseBtnClick{
    
    self.joinBtn.hidden = YES;
    self.refuseBtn.hidden = YES;
    self.alreadyLabel.text = @"已经拒绝";
    
}


- (UICollectionView *)createGroupHeadImage:(CGSize)itemSize{
    
    UICollectionViewFlowLayout *  flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //设置item的大小
    flowLayout.itemSize = itemSize;
    flowLayout.minimumLineSpacing = 1;
    flowLayout.minimumInteritemSpacing = 1;
    
    UICollectionView *  collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(20, 5, 60, 60) collectionViewLayout:flowLayout];
    collectionView.scrollEnabled = NO;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerNib:[UINib nibWithNibName:@"pictureCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"itemID"];
    collectionView.backgroundColor = [UIColor grayColor];
    return collectionView;
}
#pragma mark --- UICollectionViewDataSource,UICollectionViewDelegate
//多少组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//每组有几个item
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 9;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    pictureCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"itemID" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"home-2"];
    return cell ;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
