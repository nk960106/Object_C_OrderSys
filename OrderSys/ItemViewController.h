//
//  ItemViewController.h
//  OrderSys
//
//  Created by p16_newBlood on 2019/9/19.
//  Copyright © 2019年 p16_newBlood. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ItemViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tbView_DrinkList;

@property (nonatomic ,strong) NSDictionary *parma;
@property (nonatomic ,strong) NSString *shopName;
@end

NS_ASSUME_NONNULL_END
