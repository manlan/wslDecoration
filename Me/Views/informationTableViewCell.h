//
//  informationTableViewCell.h
//  wslDecoration
//
//  Created by 易工 on 15/12/19.
//  Copyright © 2015年 WSL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface informationTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *headBtn;
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *informationLabel;



@end
