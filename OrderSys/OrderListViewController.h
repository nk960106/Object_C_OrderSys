//
//  OrderListViewController.h
//  OrderSys
//
//  Created by p16_newBlood on 2019/9/20.
//  Copyright © 2019年 p16_newBlood. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tbView_OrderList;
@property (weak, nonatomic) IBOutlet UILabel *lbl_PriceName;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Price;
@property (weak, nonatomic) IBOutlet UIButton *btn_CheckOut;

@end

NS_ASSUME_NONNULL_END
