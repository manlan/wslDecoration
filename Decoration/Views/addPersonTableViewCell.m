//
//  addPersonTableViewCell.m
//  wslDecoration
//
//  Created by 易工 on 15/12/23.
//  Copyright © 2015年 WSL. All rights reserved.
//

#import "addPersonTableViewCell.h"

@implementation addPersonTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)selectBtnClick:(id)sender {
    
    UIButton * btn = (UIButton *)sender;
    if (!_isSelecting) {
        btn.backgroundColor = [UIColor colorWithRed:117/255.0f green:202/255.0f blue:57/255.0f alpha:1.0f];
        _isSelecting = 1;
    }else
    {
       btn.backgroundColor = [UIColor whiteColor];
        _isSelecting = 0;
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
