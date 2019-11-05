//
//  ItemOrderViewController.m
//  OrderSys
//
//  Created by p16_newBlood on 2019/9/19.
//  Copyright © 2019年 p16_newBlood. All rights reserved.
//

#import "ItemOrderViewController.h"
#import "ItemViewController.h"
@interface ItemOrderViewController (){
    //int quan; 這裡也可以宣告int
}
//宣告全域變數
@property(nonatomic,copy) NSArray *sweetArray;//冰度
@property(nonatomic,copy) NSArray *iceArray;//糖度
@property(nonatomic,copy) NSDictionary *tmpDic;
@property(nonatomic,strong) NSMutableArray *MutArray;//儲存上次NSUserDefaults的資料
@property (nonatomic, assign ) int quan;
@property (nonatomic, assign ) int money;
@property (nonatomic, strong ) NSString *sugerLv;
@property (nonatomic, strong ) NSString *iceLv;
@end

@implementation ItemOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lbl_Price.textColor = [UIColor redColor];
    self.quan = 1;
    //取得字典裡面的值
    self.tmpDic = [self.parma valueForKey:@"Data"];
    //取得子字典裡面的值
    self.sweetArray = self.tmpDic[@"sugerLv"];
    self.iceArray = self.tmpDic[@"iceLv"];
    
    NSString *imageName = self.tmpDic[@"image"];
    self.img_Drink.image = [UIImage imageNamed:imageName];
    self.lbl_Drink.text = self.tmpDic[@"name"];
    self.lbl_Detail.text = self.tmpDic[@"info"];
    self.lbl_Price.text = [@"$" stringByAppendingString:self.tmpDic[@"price"]];
    self.lbl_Quantity.text = [NSString stringWithFormat:@"%d",self.quan ];
    
    //picker View
    self.pkView_SweetLevel.dataSource = self;
    self.pkView_SweetLevel.delegate = self;
    self.pkView_AmountOfIce.dataSource = self;
    self.pkView_AmountOfIce.delegate = self;
    
    //初始化 糖度 and 冰度
    self.sugerLv = self.sweetArray[0];
    self.iceLv = self.iceArray[0];
    //初始化 btn
    self.money = [self.tmpDic[@"price"] intValue];
    NSString *str = [@"加入購物車:" stringByAppendingString:[NSString stringWithFormat:@"%d",self.money]];
    [self.btn_Order setTitle:str forState:UIControlStateNormal];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == self.pkView_SweetLevel) {
        //第一組選項由0開始
        switch (component) {
            case 0:
                return [self.sweetArray count];
                break;
                
                //如果有一組以上的選項就在這裡以component的值來區分（以本程式碼為例default:永遠不可能被執行
            default:
                return 0;
                break;
        }
    }
    else {
        //第一組選項由0開始
        switch (component) {
            case 0:
                return [self.self.sweetArray count];
                break;
                
                //如果有一組以上的選項就在這裡以component的值來區分（以本程式碼為例default:永遠不可能被執行
            default:
                return 0;
                break;
        }
    }
   
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == self.pkView_SweetLevel) {
        switch (component) {
            case 0:
                return [self.sweetArray objectAtIndex:row];
                break;
                
                //如果有一組以上的選項就在這裡以component的值來區分（以本程式碼為例default:永遠不可能被執行）
            default:
                return @"Error";
                break;
        }
    }
    else {
        switch (component) {
            case 0:
                return [self.iceArray objectAtIndex:row];
                break;
                
                //如果有一組以上的選項就在這裡以component的值來區分（以本程式碼為例default:永遠不可能被執行）
            default:
                return @"Error";
                break;
        }
    }
}

//選擇UIPickView中的項目時會出發的內建函式
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView == self.pkView_SweetLevel) {
        NSLog(@"pickerView");
        NSLog(@"%@",[self.sweetArray objectAtIndex:row]);
        self.sugerLv = [self.sweetArray objectAtIndex:row];
    }
    else {
       self.iceLv = [self.iceArray objectAtIndex:row];
    }
}

- (IBAction)btn_FunDec:(id)sender {
    if(self.quan > 2){
        self.quan--;
       
    }else{
        self.quan = 1;
    }
    self.money = [self.tmpDic[@"price"] intValue] * self.quan;
    NSString *str = [@"加入購物車:" stringByAppendingString:[NSString stringWithFormat:@"%d",self.money]];
    [self.btn_Order setTitle:str forState:UIControlStateNormal];
    self.lbl_Quantity.text = [NSString stringWithFormat:@"%d",self.quan ];
}
- (IBAction)btn_FunInc:(id)sender {
    if(self.quan < INT_MAX){
        self.quan++;
    }
    else{
        self.quan = INT_MAX;
    }
    self.money = [self.tmpDic[@"price"] intValue] * self.quan;
    NSString *str = [@"加入購物車:" stringByAppendingString:[NSString stringWithFormat:@"%d",self.money]];
    [self.btn_Order setTitle:str forState:UIControlStateNormal];
    self.lbl_Quantity.text = [NSString stringWithFormat:@"%d",self.quan ];
}

- (IBAction)btn_Order:(id)sender {
    NSDictionary *OrderCar = @{ //@"shopName" : self.shopName,
                                @"name":self.tmpDic[@"name"],
                                @"price":self.tmpDic[@"price"],
                                @"total":[NSString stringWithFormat:@"%d",self.money],
                                @"quantity": [NSString stringWithFormat:@"%d",self.quan],
                                @"sugerLv":self.sugerLv,
                                @"iceLv":self.iceLv
                            };
    
    //儲存
    NSUserDefaults *userDefaults =[NSUserDefaults standardUserDefaults];
//    if([userDefaults objectForKey:@"OrderDetail"] == nil){ //第一次存
//        [userDefaults setObject:@[OrderCar] forKey:self.shopName];
//    }
//    else{
//        //讀取後加入資料在儲存
//        NSArray *temp = [[NSUserDefaults standardUserDefaults]objectForKey:self.shopName];
//        //初始化可變array
//        NSMutableArray *MutOrderArray=[NSMutableArray arrayWithArray:temp];
//
//        [MutOrderArray addObject:OrderCar];
//        [userDefaults setObject:MutOrderArray forKey:self.shopName];
//    }
    
   

     if([userDefaults objectForKey:self.shopName] == nil){
        [userDefaults setObject:@[OrderCar] forKey:self.shopName];
    }
    else{
        //讀取後加入資料在儲存
        NSArray *temp = [[NSUserDefaults standardUserDefaults]objectForKey:self.shopName];
        //初始化可變array
        NSMutableArray *MutOrderArray=[NSMutableArray arrayWithArray:temp];
        
        //針對重複項目加值數量
        NSMutableDictionary *MulOrderCar = [NSMutableDictionary dictionaryWithDictionary:OrderCar];
        int flag = 0;
        for (id object in MutOrderArray) {
            if([object[@"name"] isEqual:MulOrderCar[@"name"]] && [object[@"sugerLv"] isEqual:MulOrderCar[@"sugerLv"]] && [object[@"iceLv"] isEqual:MulOrderCar[@"iceLv"]]){
                flag = 1;
                int tmpQuantity = [[MulOrderCar valueForKey:@"quantity"]intValue];
                int oldQuantity = [object[@"quantity"] intValue];
                //刪除前一筆訂單
                [MutOrderArray removeObject:object];
                //數量相加
                tmpQuantity += oldQuantity;
                MulOrderCar[@"quantity"] = [NSString stringWithFormat:@"%d",tmpQuantity];
                MulOrderCar[@"total"] =[NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:tmpQuantity * [MulOrderCar[@"price"] doubleValue]]];
                [MutOrderArray addObject:MulOrderCar];
                [userDefaults setObject:MutOrderArray forKey:self.shopName];
            }
        }
        if(flag == 0){
            //沒重複品項
            [MutOrderArray addObject:OrderCar];
            [userDefaults setObject:MutOrderArray forKey:self.shopName];
        }
    }
    
    /*----------------Debug 用---------------*/
    //[[NSUserDefaults standardUserDefaults] synchronize];
    //讀取
//    NSUserDefaults *userDefaults =[NSUserDefaults standardUserDefaults];
//    NSArray *tmp = [userDefaults objectForKey:@"OrderDetail"];
//    NSLog(@"%@",tmp);
    //刪除
    //[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"OrderDetail"];
    
    [self showAlert];
}
// 顯示對話方塊
-(void) showAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"加入購物車" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        //可以指定回到特定頁面但要import
        for(UIViewController *VC in self.navigationController.viewControllers){
            if([VC isKindOfClass:[ItemViewController class]]){
                [self.navigationController popToViewController:VC animated:YES];
            }
        }
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
