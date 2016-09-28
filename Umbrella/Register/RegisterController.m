//
//  RegisterController.m
//  Umbrella
//
//  Created by huangrensheng on 16/9/28.
//  Copyright © 2016年 umbrella. All rights reserved.
//

#import "RegisterController.h"

@interface RegisterController ()

@property (weak, nonatomic) IBOutlet UITextField *nickName;

@property (weak, nonatomic) IBOutlet UIButton *sex_man;

@property (weak, nonatomic) IBOutlet UIButton *sex_woman;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;

@property (weak, nonatomic) IBOutlet UITextField *messageCode;

@property (weak, nonatomic) IBOutlet UITextField *pwd;

@property (weak, nonatomic) IBOutlet UITextField *surePwd;

@property (weak, nonatomic) IBOutlet UIButton *messageBtn;

@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@property (nonatomic, strong) NSString *sexString;

@property (nonatomic, strong) NSMutableDictionary *params;

@property (nonatomic, assign) NSInteger second;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册页面";
    self.params = [[NSMutableDictionary alloc] init];
    self.messageBtn.layer.cornerRadius = 4;
    self.registerBtn.layer.cornerRadius = 4;
    self.sex_man.selected = YES;
    self.sexString = @"男";
    [self setLeftArrow];
    // Do any additional setup after loading the view.
}


- (IBAction)sendMessageCode:(UIButton *)sender {
    if ([self.phoneNumber.text isEqualToString:@""]) {
        [self.view makeToast:@"请输入手机号码"];
        return;
    }
    if (![FormatChecker checkTelNumber:self.phoneNumber.text]) {
        [self.view makeToast:@"请输入正确的手机号吗"];
        return;
    }
    //type 1.注册 2.找回密码
    [[HttpManager sharedHttpManager] getWithUrl:@"/shop/member/getValidCode" Parames:@{@"mobile":self.phoneNumber.text,@"type":@1} success:^(id successData) {
        self.second = 60;
        self.messageBtn.enabled = NO;
        [self.messageBtn setBackgroundColor:RGBACOLOR(229, 229, 229, 1)];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(doTimer) userInfo:nil repeats:YES];
    } errorBlock:^(NSError *error) {
        
    }];
}

- (void)doTimer{
    self.second --;
    if (self.second == 0) {
        [self.timer invalidate];
        self.timer = nil;
        self.messageBtn.enabled = YES;
        [self.messageBtn setBackgroundColor:RGBACOLOR(239, 212, 10, 1)];
        [self.messageBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    }else{
        [self.messageBtn setTitle:[NSString stringWithFormat:@"%ld秒后重发",self.second] forState:UIControlStateNormal];
    }
}

- (IBAction)manClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.sex_woman.selected = NO;
    self.sexString = @"男";
    
}

- (IBAction)womanClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.sex_man.selected = NO;
    self.sexString = @"女";
    
}

- (IBAction)registerUser:(UIButton *)sender {
    if ([self.nickName.text isEqualToString:@""]) {
        [self.view makeToast:@"请输入昵称"];
        return;
    }
    [self.params setValue:self.nickName.text forKey:@"nickName"];
    if ([self.pwd.text isEqualToString:@""]) {
        [self.view makeToast:@"请输入密码"];
        return;
    }
    if ([self.surePwd.text isEqualToString:@""]) {
        [self.view makeToast:@"请输入确认密码"];
        return;
    }
    if (![self.pwd.text isEqualToString:self.surePwd.text]) {
        [self.view makeToast:@"两次输入密码不一致"];
        return;
    }
    [self.params setValue:self.pwd.text forKey:@"pwd"];
    if ([self.phoneNumber.text isEqualToString:@""]) {
        [self.view makeToast:@"请输入手机号码"];
        return;
    }
    [self.params setValue:self.phoneNumber.text forKey:@"mobile"];
    if ([self.messageCode.text isEqualToString:@""]) {
        [self.view makeToast:@"请输入验证码"];
        return;
    }
    [self.params setValue:self.messageCode.text forKey:@"validCode"];
    [self.params setValue:self.sexString forKey:@"gender"];
    
    [[HttpManager sharedHttpManager] postWithUrl:@"/shop/member/registMember" Parames:self.params success:^(id successData) {
        [self.view makeToast:successData[@"message"]];
        if ([successData[@"message"] isEqualToString:@"注册成功"]) {
            [self performSelector:@selector(doLeftAction) withObject:nil afterDelay:1.0f];
        }
    } errorBlock:^(NSError *error) {
        
    }];
}

- (void)doLeftAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
