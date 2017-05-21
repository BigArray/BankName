//
//  ViewController.m
//  BankName
//
//  Created by 张振飞 on 2017/5/21.
//  Copyright © 2017年 zzf. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong)UITextField *cardNumField;
@property (nonatomic, strong)UIButton *button;
@property (nonatomic, strong)UILabel *nameLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createView];
}

- (void)createView{
    _cardNumField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 220, 50)];
    _cardNumField.center = CGPointMake(self.view.center.x, 100);
    _cardNumField.placeholder = @"请输入卡号";
    _cardNumField.borderStyle = UITextBorderStyleLine;
    [self.view addSubview:_cardNumField];
    
    _button = [UIButton buttonWithType:UIButtonTypeSystem];
    _button.frame = CGRectMake(0, 0, 100, 40);
    _button.center = CGPointMake(self.view.center.x, 180);
    [_button setTitle:@"确定" forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(confirmBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    _nameLabel.center = CGPointMake(self.view.center.x, 280);
    _nameLabel.textAlignment = 1;
    [self.view addSubview:_nameLabel];
}

- (void)confirmBtn{
    _nameLabel.text = [self returnBankName:_cardNumField.text];
}

- (NSString *)returnBankName:(NSString*) idCard{
    
    if(idCard==nil || idCard.length<16 || idCard.length>19){
        
        return @"卡号不合法";
        
    }
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"bank" ofType:@"plist"];
    NSDictionary* resultDic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSArray *bankBin = resultDic.allKeys;
    
    //6位Bin号
    NSString* cardbin_6 = [idCard substringWithRange:NSMakeRange(0, 6)];
    //8位Bin号
    NSString* cardbin_8 = [idCard substringWithRange:NSMakeRange(0, 8)];
    
    if ([bankBin containsObject:cardbin_6]) {
        return [resultDic objectForKey:cardbin_6];
    }else if ([bankBin containsObject:cardbin_8]){
        return [resultDic objectForKey:cardbin_8];
    }else{
        return @"plist文件中不存在请自行添加对应卡种";
    }
    return @"";
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
