//
//  homeTableViewCell.h
//  wslDecoration
//
//  Created by 易工 on 15/12/8.
//  Copyright © 2015年 WSL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface homeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *headBtn;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UIButton *collectionBtn;
@property (weak, nonatomic) IBOutlet UILabel *collectionLabel;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIButton *zanBtn;

@property (weak, nonatomic) IBOutlet UILabel *zanLabel;

@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

- (void)setLineSpacing:(CGFloat)spacing label:(UILabel *)label;
@end
