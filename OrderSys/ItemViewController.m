//
//  ItemViewController.m
//  OrderSys
//
//  Created by p16_newBlood on 2019/9/19.
//  Copyright © 2019年 p16_newBlood. All rights reserved.
//

#import "ItemViewController.h"
#import "ItemTableViewCell.h"
#import "ItemOrderViewController.h"
#import "OrderListViewController.h"
@interface ItemViewController ()
@property(nonatomic,copy) NSArray *tableViewArray;//宣告全域變數
@end

@implementation ItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"%@",self.parma);
    //做右上角的購物車
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"cart"] style:UIBarButtonItemStylePlain target:self action:@selector(navigationBarEvent:)];
    
    self.tbView_DrinkList.delegate = self;
    self.tbView_DrinkList.dataSource = self;
    self.tableViewArray = [self.parma valueForKey:@"Data"];
}

//控制TableView元件 寫入資料
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //放入圖片
    ItemTableViewCell *cell = [[NSBundle mainBundle] loadNibNamed:@"ItemTableViewCell" owner:self options:nil][0];
    cell.lbl_Drink.text = self.tableViewArray[indexPath.row][@"name"];
    cell.txtView_Detail.text = self.tableViewArray[indexPath.row][@"info"];
    cell.lbl_Price.text = [@"$" stringByAppendingString:self.tableViewArray[indexPath.row][@"price"]];
    NSString *imageName = self.tableViewArray[indexPath.row][@"image"];
    cell.img_Drink.image = [UIImage imageNamed:imageName];
    return cell;
}

//設定TableView 中有幾個分區（群組）
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//設定每個分區有幾行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableViewArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
//TableViewCell點擊事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //indexPath.row 點擊的位置
    //可指定哪一個Session的哪個row點擊後需做什麼事
    //    NSString *message = self.tableViewArray[indexPath.row][@"click"];

    //傳送參數
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ItemOrderViewController *ItemOrderView =[storyboard instantiateViewControllerWithIdentifier:@"ItemOrder"];
    ItemOrderView.parma = @{@"Data":self.tableViewArray[indexPath.row]};
    ItemOrderView.shopName = self.shopName;
    [self.navigationController pushViewController:ItemOrderView animated:YES];
}

//購物車觸發事件
-(void)navigationBarEvent:(id)sender{
    [self performSegueWithIdentifier:@"ToOrderList" sender:self];
}


@end
