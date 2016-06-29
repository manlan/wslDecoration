//
//  addPersonTableViewCell.h
//  wslDecoration
//
//  Created by 易工 on 15/12/23.
//  Copyright © 2015年 WSL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addPersonTableViewCell : UITableViewCell
{
    int _isSelecting;
}
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UIImageView *headImgV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;



@end
