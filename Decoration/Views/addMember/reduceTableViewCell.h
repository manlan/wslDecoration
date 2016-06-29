//
//  reduceTableViewCell.h
//  wslDecoration
//
//  Created by 易工 on 15/12/24.
//  Copyright © 2015年 WSL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface reduceTableViewCell : UITableViewCell
{
   int  _isSelecting;
}
@property (weak, nonatomic) IBOutlet UIImageView *headIMgV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@end
