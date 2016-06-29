//
//  homeTableViewCell.m
//  wslDecoration
//
//  Created by 易工 on 15/12/8.
//  Copyright © 2015年 WSL. All rights reserved.
//

#import "homeTableViewCell.h"

@implementation homeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)headBtn:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"toPersonHomepage" object:nil userInfo:nil];
    
    
 
}


- (void)setLineSpacing:(CGFloat)spacing label:(UILabel *)label
{
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:label.text];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:spacing];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [label.text length])];
    [label setAttributedText:attributedString];
    [label sizeToFit];
}
//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    NSLog(@"hah");
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        
//        [self setFrame];
//    }
//    
//    return self;
//}
//-(void)setFrame
//{
//    CGRect rect = self.detailLab.frame;
//    rect.size.width = SCREEN_WIDTH - 200;
//    self.detailLab.frame = rect;
//    
//    
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
