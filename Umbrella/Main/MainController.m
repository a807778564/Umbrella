//
//  MainController.m
//  Umbrella
//
//  Created by huangrensheng on 16/9/28.
//  Copyright © 2016年 umbrella. All rights reserved.
//

#import "MainController.h"
#import "UmbrellaView.h"
#import "UmbrellaCheckView.h"
#import "UmbrellaImageCheck.h"

@interface MainController ()

@property (weak, nonatomic) IBOutlet UIButton *neiBtn;

@property (weak, nonatomic) IBOutlet UIButton *waiBtn;

@property (weak, nonatomic) IBOutlet UmbrellaView *sanmian;

@property (weak, nonatomic) IBOutlet UIButton *danBtn;

@property (weak, nonatomic) IBOutlet UIButton *suangBtn;

@property (weak, nonatomic) IBOutlet UIButton *allBtn;

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@property (weak, nonatomic) IBOutlet UIView *lienView;

@property (nonatomic, strong) UmbrellaCheckView *checkView;

@property (nonatomic, strong) UIView *grayView;//阴影遮盖的View;

@property (nonatomic, strong) UmbrellaImageCheck *imageCkeck;

@property (nonatomic, strong) NSMutableArray *checkSan;

@property (nonatomic, strong) NSMutableArray *oldCkeck;

@property (nonatomic, strong) NSArray *showCateArray;
@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.oldCkeck = [[NSMutableArray alloc] init];
    
    CGFloat cor = (self.view.frame.size.width - 17*2 - 47*3);
    self.danBtn.layer.cornerRadius =cor/8;
    self.suangBtn.layer.cornerRadius = cor/8;
    self.allBtn.layer.cornerRadius = cor/8;
    self.submitBtn.layer.cornerRadius = cor/8;
    UITapGestureRecognizer *sanTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSanMian)];
    [self.sanmian addGestureRecognizer:sanTap];
    
    self.grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.grayView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.grayView];
    [self.view sendSubviewToBack:self.grayView];
    
    self.checkView = [[[NSBundle mainBundle] loadNibNamed:@"UmbrellaCheckView" owner:nil options:nil] firstObject];
    [self.view addSubview:self.checkView];
    [self.checkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_bottom);
        make.trailing.equalTo(self.view.mas_trailing).offset(-60);
        make.leading.equalTo(self.view.mas_leading).offset(60);
        make.height.equalTo(self.checkView.mas_width);
    }];
    [self.checkView didCheckNumberFinish:^(NSString *title, NSMutableArray *checkNumber) {
        [self checkSanFinish:title checkNumber:checkNumber];
    }];
    
    self.imageCkeck = [[[NSBundle mainBundle] loadNibNamed:@"UmbrellaImageCheck" owner:nil options:nil] firstObject];
    [self.view addSubview:self.imageCkeck];
    [self.imageCkeck mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
//        make.top.equalTo(self.view.mas_bottom);
        make.centerY.equalTo(self.view.mas_centerY);
        make.trailing.equalTo(self.view.mas_trailing).offset(-60);
        make.leading.equalTo(self.view.mas_leading).offset(60);
        make.height.equalTo(self.checkView.mas_width);
    }];
    
}

//选择伞面点击确定
- (void)checkSanFinish:(NSString *)title checkNumber:(NSMutableArray *)checkNumber{
    if (checkNumber.count > 0 && [title isEqualToString:@"确定"]) {
        [checkNumber sortUsingComparator:^NSComparisonResult(__strong id obj1,__strong id obj2){
            return [obj1 intValue] > [obj2 intValue];
        }];
        self.checkSan = checkNumber;
        BOOL isLianXu = NO;
        for (int i = 0 ; i<checkNumber.count-1 ; i++) {
            if ([checkNumber[i+1] integerValue] - [checkNumber[i] integerValue] == 1) {
                isLianXu = YES;
            }else{
                isLianXu = NO;
                break;
            }
        }
        if (checkNumber.count == 1) {
            isLianXu = YES;
        }
        self.grayView.backgroundColor = [UIColor clearColor];
        [self.view sendSubviewToBack:self.grayView];
        [UIView animateWithDuration:0.5 animations:^{
            [self.checkView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view.mas_bottom);
            }];
            [self.view layoutIfNeeded];
        }completion:^(BOOL finished) {
            if(isLianXu){
                [self showImageCheck];
                [self.oldCkeck addObjectsFromArray:checkNumber];
                [self.checkSan removeAllObjects];
            }else{
                [self.checkSan removeAllObjects];
                [self.view makeToast:@"请选择相邻的伞面!"];
            }
        }];
    }else{
        self.grayView.backgroundColor = [UIColor clearColor];
        [self.view sendSubviewToBack:self.grayView];
        [UIView animateWithDuration:0.5 animations:^{
            [self.checkView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view.mas_bottom);
            }];
            [self.view layoutIfNeeded];
        }];
    }
}

//点击伞面
- (void)clickSanMian{
    self.checkView.checkArray = self.checkSan;
    self.checkView.oldCheck = self.oldCkeck;
    [UIView animateWithDuration:0.5 animations:^{
        [self.checkView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_bottom).offset(-(self.sanmian.frame.size.height+self.sanmian.frame.origin.y));
        }];
        [self.view layoutIfNeeded];
    }completion:^(BOOL finished) {
        [self.view insertSubview:self.grayView atIndex:self.view.subviews.count-2];
        self.grayView.backgroundColor = RGBACOLOR(0, 0, 0, 0.2);
    }];
    
}

//显示 花纹选择
- (void)showImageCheck{
    if (!self.showCateArray) {
        [[HttpManager sharedHttpManager] getWithUrl:@"/shop/common/getImageType?" Parames:@{@"mobile":@"13361857030",@"typeId":@0} success:^(id successData) {
            NSArray *cateArray = successData[@"object"];
            self.showCateArray= cateArray;
            [self showAction:cateArray];
        } errorBlock:^(NSError *error) {
            
        }];
    }else{
        [self showAction:self.showCateArray];
    }
    
    
}

- (void)showAction:(NSArray *)cateArray{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"手机图库" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    for (int i = 0; i<cateArray.count; i++) {
        [alert addAction:[UIAlertAction actionWithTitle:cateArray[i][@"typeName"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"%@",cateArray[i][@"typeName"]);
        }]];
    }
    [self presentViewController:alert animated:YES completion:^{
        
    }];
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
