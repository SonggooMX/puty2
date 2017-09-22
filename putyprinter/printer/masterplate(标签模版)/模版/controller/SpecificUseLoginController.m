

//
//  SpecificUseLoginController.m
//  TianJinDL
//
//  Created by apple on 17/8/14.
//  Copyright © 2017年 troilamac. All rights reserved.
//

#import "SpecificUseLoginController.h"
#import "TagTemplateController.h"
#import "TianJinDLConfig.h"
#import "NetworkManager.h"
#import "MeLoginTool.h"
@interface SpecificUseLoginController ()<UITextFieldDelegate>
@property (nonatomic,weak) UIButton *selectedBtn;
@end

@implementation SpecificUseLoginController
{
    UITextField *namefield;
    UITextField *pwdfield;
    UIButton *loginbtn;
    UIButton *pwdbtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"专用模版";
    [self setNav];
    [self setMain];
}
-(void)setNav{
    //返回键
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [btn setImage:[UIImage imageNamed:@"back_button_white"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
}
-(void)setMain{
    UIView *leftview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 40)];
    namefield = [[UITextField alloc]initWithFrame:CGRectMake(30, 20, SCREEN_WIDTH-60, 40)];
    namefield.placeholder = @"用户名称／电话号码";
    namefield.layer.borderColor = [UIColor lightGrayColor].CGColor;
    namefield.layer.borderWidth = 0.5;
    namefield.layer.cornerRadius = 5;
    namefield.leftView = leftview;
    namefield.leftViewMode = UITextFieldViewModeAlways;
    namefield.returnKeyType = UIReturnKeyNext;
    namefield.delegate = self;
    namefield.tag = 0;
    namefield.text = [MeLoginTool getUserName];
    
    [namefield setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [self.view addSubview:namefield];
    pwdfield = [[UITextField alloc]initWithFrame:CGRectMake(30, 75, SCREEN_WIDTH-60, 40)];
    pwdfield.placeholder = @"登录密码";
    pwdfield.layer.borderColor = [UIColor lightGrayColor].CGColor;
    pwdfield.layer.borderWidth = 0.5;
    pwdfield.layer.cornerRadius = 5;
    pwdfield.returnKeyType = UIReturnKeyDone;
    pwdfield.delegate = self;
    pwdfield.tag =1;
    pwdfield.text = [MeLoginTool getPwd];
    pwdfield.secureTextEntry = YES;
    [pwdfield setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    UIView *leftview2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 40)];
    pwdfield.leftView = leftview2;
    pwdfield.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:pwdfield];
    //选择按钮
    loginbtn= [[UIButton alloc]initWithFrame:CGRectMake(30, 135, 15, 15)];
    [loginbtn setBackgroundImage:[UIImage imageNamed:@"nor_button"] forState:UIControlStateNormal];
    [loginbtn setBackgroundImage:[UIImage imageNamed:@"sel_button"] forState:UIControlStateSelected];
    [loginbtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:loginbtn];
    UILabel *loginlab = [[UILabel alloc]initWithFrame:CGRectMake(55, 135, 60, 15)];
    loginlab.text = @"自动登录";
    [loginlab setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:loginlab];
    [loginlab setFont:[UIFont systemFontOfSize:13]];
    
     pwdbtn= [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2+40, 135, 15, 15)];
    [pwdbtn setBackgroundImage:[UIImage imageNamed:@"nor_button"] forState:UIControlStateNormal];
    [pwdbtn setBackgroundImage:[UIImage imageNamed:@"sel_button"] forState:UIControlStateSelected];
    [self.view addSubview:pwdbtn];
    UILabel *pwdlab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2+65, 135, 60, 15)];
    pwdlab.text = @"记住密码";
    pwdbtn.selected = YES;
    self.selectedBtn = pwdbtn;
    [pwdbtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [pwdlab setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:pwdlab];
    [pwdlab setFont:[UIFont systemFontOfSize:13]];
    //登录
    UIButton *login = [[UIButton alloc]initWithFrame:CGRectMake(30, 170, SCREEN_WIDTH-60, 40)];
    [login setTitle:@"登录" forState:UIControlStateNormal];
    [login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [login setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:login];
    login.layer.cornerRadius = 5;
    [login addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark -- Click
-(void)back{
   [self.navigationController popViewControllerAnimated:YES];
}
-(void)login{
 //登录
    if (namefield.text.length ==0) {
        //[self.view makeToast:@"请输入用户名" duration:1.0 position:CSToastPositionCenter ];
        return;
    }
    if (pwdfield.text.length ==0) {
        //[self.view makeToast:@"请输入登录密码" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    [[NetworkManager sharedInstance] HttpRequestWithType:@"GET" withURLString:[NSString stringWithFormat:@"http://119.23.125.153:8000/puty/api.ashx?action=login&uid=%@&pwd=%@",namefield.text,pwdfield.text] withParaments:nil progress:nil withCompleteBlock:^(NSError *error, id data) {
        NSLog(@"登陆返回的信息= %@",data);
        MessageModel *msg = [[MessageModel alloc]initWithDictionary:data error:nil];
        if ([msg.error integerValue]== 0) {
            msg.username = namefield.text;
            msg.password = pwdfield.text;
            if (self.selectedBtn == loginbtn) {
                msg.autoLogin = YES;
            }
            if (self.selectedBtn == pwdbtn) {
                msg.autoLogin = NO;
            }
            [MeLoginTool saveLoginInfo:msg];
            NSDictionary *dic =@{@"uid":namefield.text,@"checkcode":msg.msg};
            NSNotification *notification = [NSNotification notificationWithName:@"info" object:nil userInfo:dic];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            [self.navigationController popViewControllerAnimated:YES];
           
        }else{
            //[self.view makeToast:msg.msg duration:1.0 position:CSToastPositionCenter];
        }

    }];

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == 0) {
        [pwdfield becomeFirstResponder];
    }
    if (textField.tag ==1) {
        [pwdfield resignFirstResponder];
    }
    return YES;
}
-(void)buttonClick:(UIButton *)button{
    if (self.selectedBtn!=button) {
        self.selectedBtn.selected = NO;
        self.selectedBtn = button;
    }
    self.selectedBtn.selected = YES;
}
@end
