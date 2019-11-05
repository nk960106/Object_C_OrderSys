//
//  OrderListTableViewCell.h
//  OrderSys
//
//  Created by p16_newBlood on 2019/9/20.
//  Copyright © 2019年 p16_newBlood. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbl_Drink;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Price;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Info;

@end

NS_ASSUME_NONNULL_END
