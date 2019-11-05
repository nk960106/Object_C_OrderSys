//
//  ViewController.h
//  OrderSys
//
//  Created by p16_newBlood on 2019/9/19.
//  Copyright © 2019年 p16_newBlood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *TbView_ShopList;


@end

