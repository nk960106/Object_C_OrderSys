//
//  ItemTableViewCell.m
//  OrderSys
//
//  Created by p16_newBlood on 2019/9/19.
//  Copyright © 2019年 p16_newBlood. All rights reserved.
//

#import "ItemTableViewCell.h"

@implementation ItemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.lbl_Price.textColor = [UIColor redColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
