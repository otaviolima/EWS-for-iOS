//
//  ViewController.m
//  EWS-For-iOS
//
//  Created by wangxk on 16/8/18.
//  Copyright © 2016年 wangxk. All rights reserved.
//

#import "ViewController.h"
#import "EWSManager.h"
#import "EWSItemContentModel.h"

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController{
    UITextField *_eAddressTf;
    UITextField *_ePasswordTf;
    UITextField *_eDescription;
    UITextField *_eServerAddress;
    UIButton *_eConfirmBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.5 alpha:1.0];
    
    [self initUI];
    
}

-(void)initUI{
    _eAddressTf = [[UITextField alloc] initWithFrame:CGRectMake(20, 80, ScreenWidth-40, 30)];
    _eAddressTf.placeholder = @"邮箱（必填）";
    _eAddressTf.delegate = self;
    
    [self.view addSubview:_eAddressTf];
    
    _ePasswordTf = [[UITextField alloc] initWithFrame:CGRectMake(20, 130, ScreenWidth-40, 30)];
    _ePasswordTf.placeholder = @"密码（必填）";
    _ePasswordTf.delegate = self;
    
    [self.view addSubview:_ePasswordTf];
    
    _eDescription = [[UITextField alloc] initWithFrame:CGRectMake(20, 180, ScreenWidth-40, 30)];
    _eDescription.placeholder = @"描述（选填）";
    _eDescription.delegate = self;
    
    [self.view addSubview:_eDescription];
    
    _eServerAddress = [[UITextField alloc] initWithFrame:CGRectMake(20, 230, ScreenWidth-40, 30)];
    _eServerAddress.placeholder = @"邮箱服务器地址（选填）";
    _eServerAddress.delegate = self;
    
    [self.view addSubview:_eServerAddress];
    
    _eConfirmBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _eConfirmBtn.frame = CGRectMake(20, 280, ScreenWidth-40, 30);
    [_eConfirmBtn addTarget:self action:@selector(confirmBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [_eConfirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    
    [self.view addSubview:_eConfirmBtn];
}

-(void)confirmBtnClicked{
    [[EWSManager sharedEwsManager] setEmailBoxInfoEmailAddress:_eAddressTf.text password:_ePasswordTf.text description:_eDescription.text mailServerAddress:_eServerAddress.text domain:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [[EWSManager sharedEwsManager] getAllItemContent:^(NSArray *allItemArray, NSError *error) {
            if (error) {
                NSLog(@"error:%@",error);
            }
            else{
                EWSItemContentModel *itemContentInfo = allItemArray[0];
                NSLog(@"---content:%@-%@-%@-%@---",itemContentInfo.itemSubject,itemContentInfo.itemContentHtmlString,itemContentInfo.dateTimeSentStr,itemContentInfo.size);
            }
        }];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
