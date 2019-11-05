//
//  ViewController.m
//  OrderSys
//
//  Created by p16_newBlood on 2019/9/19.
//  Copyright © 2019年 p16_newBlood. All rights reserved.
//

#import "ViewController.h"
#import "ShopTableViewCell.h"
#import "ItemViewController.h"
@interface ViewController ()
@property(nonatomic,copy) NSArray *tableViewArray;//宣告全域變數
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"LinnerList.json" ofType:nil];
    NSError *error = nil;
    NSData *JSONData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:&error];
    NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:&error];
//    NSLog(@"%@",dic);
    
    self.TbView_ShopList.delegate = self;
    self.TbView_ShopList.dataSource = self;
    self.tableViewArray = [dic valueForKey:@"StoreList"] ;
    
    //Ad test
    
}
//控制TableView元件 寫入資料
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //放入圖片
    ShopTableViewCell *cell = [[NSBundle mainBundle] loadNibNamed:@"ShopTableViewCell" owner:self options:nil][0];
    cell.lbl_Shop.text = self.tableViewArray[indexPath.row][@"name"];
    NSString *imageName = self.tableViewArray[indexPath.row][@"imageName"];
    cell.Img_Shop.image = [UIImage imageNamed:imageName];
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
    return 80;
}
//TableViewCell點擊事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //indexPath.row 點擊的位置
    //可指定哪一個Session的哪個row點擊後需做什麼事
//    NSString *message = self.tableViewArray[indexPath.row][@"click"];

    //傳送參數
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ItemViewController *ItemView =[storyboard instantiateViewControllerWithIdentifier:@"ItemView"];
    ItemView.parma = @{@"Data":self.tableViewArray[indexPath.row][@"drinkList"]};
    ItemView.shopName = self.tableViewArray[indexPath.row][@"name"];
    [self.navigationController pushViewController:ItemView animated:YES];
}

@end
