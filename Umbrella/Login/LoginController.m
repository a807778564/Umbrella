//
//  ViewController.m
//  Umbrella
//
//  Created by huangrensheng on 16/9/28.
//  Copyright © 2016年 umbrella. All rights reserved.
//

#import "LoginController.h"
#import "RegisterController.h"
#import "MainController.h"

@interface LoginController ()

@property (weak, nonatomic) IBOutlet UITextField *userName;

@property (weak, nonatomic) IBOutlet UITextField *passWord;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录页面";
    self.loginBtn.layer.cornerRadius = 4.0f;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册>" size:CGSizeMake(50, 15) target:self action:@selector(gotToRegister)];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)sureLogin:(UIButton *)sender {
    if ([self.userName.text isEqualToString:@""]) {
        [self.view makeToast:@"请输入用户名"];
        return;
    }
    if ([self.passWord.text isEqualToString:@""]) {
        [self.view makeToast:@"请输入密码"];
        return;
    }
    [[HttpManager sharedHttpManager] postWithUrl:@"/shop/member/login" Parames:@{@"mobile":self.userName.text,@"pwd":self.passWord.text} success:^(id successData) {
        if ([successData[@"code"] integerValue]==1) {
            [self.view makeToast:@"登录成功"];
            [[NSUserDefaults standardUserDefaults] setValue:successData[@"object"][@"mobile"] forKey:@"mobile"];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            MainController *main = [storyboard instantiateViewControllerWithIdentifier:@"MainController"];
            [self.navigationController pushViewController:main animated:YES];
        }else{
            [self.view makeToast:successData[@"message"]];
        }
    } errorBlock:^(NSError *error) {
        
    }];
}

- (void)gotToRegister{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RegisterController *regist = [storyboard instantiateViewControllerWithIdentifier:@"RegisterController"];
    [self.navigationController pushViewController:regist animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
