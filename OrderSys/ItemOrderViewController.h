//
//  ItemOrderViewController.h
//  OrderSys
//
//  Created by p16_newBlood on 2019/9/19.
//  Copyright © 2019年 p16_newBlood. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ItemOrderViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *img_Drink;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Drink;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Detail;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Price;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Quantity;

@property (weak, nonatomic) IBOutlet UIPickerView *pkView_SweetLevel;
@property (weak, nonatomic) IBOutlet UIPickerView *pkView_AmountOfIce;
@property (weak, nonatomic) IBOutlet UIButton *btn_Order;
@property (weak, nonatomic) IBOutlet UIButton *btn_Decrease;
@property (weak, nonatomic) IBOutlet UIButton *btn_Increase;

@property (nonatomic ,strong) NSDictionary *parma;
@property (nonatomic ,strong) NSString *shopName;
@end

NS_ASSUME_NONNULL_END
