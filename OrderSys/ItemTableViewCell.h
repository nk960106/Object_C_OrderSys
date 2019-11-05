//
//  ItemTableViewCell.h
//  OrderSys
//
//  Created by p16_newBlood on 2019/9/19.
//  Copyright © 2019年 p16_newBlood. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ItemTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img_Drink;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Drink;
@property (weak, nonatomic) IBOutlet UITextView *txtView_Detail;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Price;

@end

NS_ASSUME_NONNULL_END
