//
//  OrderListViewController.m
//  OrderSys
//
//  Created by p16_newBlood on 2019/9/20.
//  Copyright © 2019年 p16_newBlood. All rights reserved.
//

#import "OrderListViewController.h"
#import "OrderListTableViewCell.h"
@interface OrderListViewController ()
//宣告全域變數
@property(nonatomic,copy) NSArray *tableViewArray;
@property(nonatomic,copy) NSArray *teaViewArray;//茶湯會
@property(nonatomic,copy) NSArray *kbkViewArray;//可不可熟成

@property(nonatomic,strong) NSMutableArray *MutArray;//儲存上次NSUserDefaults的資料
@property(nonatomic,strong)NSUserDefaults *userDefaults;
@property(nonatomic,assign) int sum;
@end

@implementation OrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //刪除資料
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"茶湯會"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"可不可熟成紅茶"];
    //右上角垃圾桶
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(navigationBarEvent:)] ;
    
    self.tbView_OrderList.delegate = self;
    self.tbView_OrderList.dataSource = self;
    
    //讀取
    self.userDefaults = [NSUserDefaults standardUserDefaults];//可不可熟成紅茶 茶湯會
    self.teaViewArray = [[NSArray alloc] initWithArray:[self.userDefaults objectForKey:@"茶湯會"]];
    self.kbkViewArray = [[NSArray alloc] initWithArray:[self.userDefaults objectForKey:@"可不可熟成紅茶"]];
    self.MutArray = [[NSMutableArray alloc] initWithObjects:self.teaViewArray,self.kbkViewArray, nil];
    
    //初始化
    self.lbl_PriceName.text = @"總計 : ";
    [self.btn_CheckOut setTitle:@"結帳" forState:UIControlStateNormal];
    self.lbl_Price.text = @"0";
    self.btn_CheckOut.backgroundColor = [UIColor redColor];
    [self.btn_CheckOut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}

//控制TableView元件 寫入資料
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //放入圖片
    OrderListTableViewCell *cell = [[NSBundle mainBundle] loadNibNamed:@"OrderListTableViewCell" owner:self options:nil][0];
    cell.lbl_Drink.text = [[self.MutArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row][@"name"];
    cell.lbl_Price.text =[NSString stringWithFormat:@"X%@($%@)",[[self.MutArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row][@"quantity"],[[self.MutArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row][@"total"]];
    cell.lbl_Info.text = [NSString stringWithFormat:@"-%@,%@",[[self.MutArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row][@"sugerLv"],[[self.MutArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row][@"iceLv"]];
    self.sum += [[[self.MutArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row][@"total"] intValue];
    self.lbl_Price.text = [NSString stringWithFormat:@"%d",self.sum];
    return cell;
}
//設定分類開頭標題 new
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"茶湯會";
            break;
            
        case 1:
            return @"可不可熟成紅茶";
            break;
            
        default:
            return @"";
            break;
    }
}


//設定TableView 中有幾個分區（群組）
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
    return self.MutArray.count;
}

//設定每個分區有幾行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.tableViewArray.count;
    return [[self.MutArray objectAtIndex:section]count];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

//TableViewCell點擊事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    //indexPath.row 點擊的位置
//    //可指定哪一個Session的哪個row點擊後需做什麼事
//    //    NSString *message = self.tableViewArray[indexPath.row][@"click"];
//
//    //傳送參數
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//    ItemOrderViewController *ItemOrderView =[storyboard instantiateViewControllerWithIdentifier:@"ItemOrder"];
//    ItemOrderView.parma = @{@"Data":self.tableViewArray[indexPath.row]};
//    [self.navigationController pushViewController:ItemOrderView animated:YES];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    self.sum = 0;
    if(self.MutArray != nil){
        //刪除
        NSMutableArray *temp = [NSMutableArray arrayWithArray:self.MutArray[indexPath.section]];
        [temp removeObjectAtIndex:indexPath.row];
        [self.MutArray replaceObjectAtIndex:indexPath.section withObject:temp];
        
        //存入刪除後的資料
        switch (indexPath.section) {
            case 0:
                [self.userDefaults setObject:temp forKey:@"茶湯會"];
                break;
            case 1:
                [self.userDefaults setObject:temp forKey:@"可不可熟成紅茶"];
                break;
            default:
                break;
        }
        
        // 之後更新view
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tbView_OrderList reloadData];
    }
}

//垃圾桶觸發事件
-(void)navigationBarEvent:(id)sender{
    self.sum = 0;
    [self showAlert:@"Tips" andMsg:@"是否將購物車清空"];
    self.lbl_Price.text = @"0";
}
- (IBAction)btn_FunCheckOut:(id)sender {
    if(self.sum != 0){
        [self showAlert:@"訂單送出" andMsg:[NSString stringWithFormat:@"總計 : %d",self.sum]];
    }
    else{
        [self showEmptyAlert:@"訂單錯誤" andMsg:[NSString stringWithFormat:@"請加入品項"]];
    }
    
    
}
//顯示對話方塊
-(void) showAlert:(NSString *)Title andMsg:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:Title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil ]];
    //確認要做的事情
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"茶湯會"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"可不可熟成紅茶"];
        self.MutArray = @[@[],@[]];
        self.sum = 0;
        [self.tbView_OrderList reloadData];
//        [self.order  ] ;
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

//顯示對話方塊
-(void) showEmptyAlert:(NSString *)Title andMsg:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:Title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil ]];
  
    [self presentViewController:alert animated:YES completion:nil];
}

@end
