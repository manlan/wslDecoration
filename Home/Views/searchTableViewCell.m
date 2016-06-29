//
//  searchTableViewCell.m
//  wslDecoration
//
//  Created by 易工 on 15/12/9.
//  Copyright © 2015年 WSL. All rights reserved.
//

#import "searchTableViewCell.h"

@implementation searchTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (IBAction)deleteBtn:(id)sender {
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:self.searchLabel.text,@"record", nil];
[[NSNotificationCenter defaultCenter] postNotificationName:@"deleteSearchRecord" object:nil userInfo:dict];
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
