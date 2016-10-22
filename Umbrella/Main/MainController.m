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
#import "UmPhotoCutController.h"
#import "UmTransImageView.h"

@interface MainController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *neiBtn;//内按钮

@property (weak, nonatomic) IBOutlet UIButton *waiBtn;//外按钮

@property (weak, nonatomic) IBOutlet UmbrellaView *sanmian;//伞面

@property (weak, nonatomic) IBOutlet UIButton *danBtn;//单面

@property (weak, nonatomic) IBOutlet UIButton *suangBtn;//双面

@property (weak, nonatomic) IBOutlet UIButton *allBtn;//取消

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;//提交

@property (weak, nonatomic) IBOutlet UIView *lienView;//分割线

@property (nonatomic, strong) UmbrellaCheckView *checkView;//伞面选择的按钮

@property (nonatomic, strong) UIView *grayView;//阴影遮盖的View;

@property (nonatomic, strong) UmbrellaImageCheck *imageCkeck;//图片选择的view

@property (nonatomic, strong) NSMutableArray *checkSan;//选择的伞面数组

@property (nonatomic, strong) NSArray *showCateArray;//显示的图片分类

@property (nonatomic, strong) NSMutableDictionary *checkSanMian;//单层伞面的图片集合

@property (nonatomic, strong) NSMutableDictionary *checkSanWai;//外伞面的图片图片集合

@property (nonatomic, strong) NSMutableDictionary *checkSanNei;//内伞面的图片图片集合

@property (nonatomic, assign) MainCheckType checkType;

@property (nonatomic, assign) UmType umType;

@property (nonatomic, strong) UIImage *danImage;//单面的图片

@property (nonatomic, strong) UIImage *suangWaiImage;//双层外图片

@property (nonatomic, strong) UIImage *suangNeiImage;//双层内图片

@property (nonatomic, strong) UIImage *nilImage;//空白的伞面图

@property (nonatomic, strong) NSMutableArray *orgImage;//原图

@property (nonatomic, assign) BOOL isHostPhoto;//是否本地的图库

@property (nonatomic, strong) UmTransImageView *imageff;

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"伞面制作";
    [self setLeftArrow];
    self.checkSanMian = [[NSMutableDictionary alloc] init];
    self.checkSanWai = [[NSMutableDictionary alloc] init];
    self.checkSanNei = [[NSMutableDictionary alloc] init];
    self.orgImage = [[NSMutableArray alloc] init];
    self.checkType = MainCheckDan;//默认单层
    self.umType = UmTypeNei;//默认内层
    
    self.imageff = [[UmTransImageView alloc] init];
    self.imageff.backgroundColor = RGBACOLOR(235, 235, 235, 1);
    
    [self.view addSubview:self.imageff];
    [self.imageff mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_bottom);
        make.centerX.equalTo(self.view.mas_centerX);
//        if (self.view.frame.size.width < 414) {
//            make.width.offset(255);
//        }else{
        make.trailing.equalTo(self.view.mas_trailing).offset(-60);
        make.leading.equalTo(self.view.mas_leading).offset(60);
//        }
        make.height.equalTo(self.imageff.mas_width);
//        make.width.equalTo(self.sanmian.mas_width).multipliedBy(0.5);
//        make.height.equalTo(self.sanmian.mas_height).multipliedBy(0.5);
    }];
    
    CGFloat cor = (self.view.frame.size.width - 17*2 - 47*3);
    self.danBtn.layer.cornerRadius =cor/8;
    self.suangBtn.layer.cornerRadius = cor/8;
    self.allBtn.layer.cornerRadius = cor/8;
    self.submitBtn.layer.cornerRadius = cor/8;
    UITapGestureRecognizer *sanTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSanMian)];
    [self.sanmian addGestureRecognizer:sanTap];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(grayViewOnClick)];
    self.grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.grayView.backgroundColor = [UIColor clearColor];
    [self.grayView addGestureRecognizer:tap];
    [self.view addSubview:self.grayView];
    [self.view sendSubviewToBack:self.grayView];
    
    self.checkView = [[[NSBundle mainBundle] loadNibNamed:@"UmbrellaCheckView" owner:nil options:nil] firstObject];
    [self.view addSubview:self.checkView];
    [self.checkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_bottom);
        if (self.view.frame.size.width < 414) {
            make.width.offset(255);
        }else{
            make.trailing.equalTo(self.view.mas_trailing).offset(-60);
            make.leading.equalTo(self.view.mas_leading).offset(60);
        }
        make.height.equalTo(self.checkView.mas_width);
    }];
    [self.checkView didCheckNumberFinish:^(NSString *title, NSMutableArray *checkNumber) {
        [self checkSanFinish:title checkNumber:checkNumber];
    }];
    
    self.imageCkeck = [[[NSBundle mainBundle] loadNibNamed:@"UmbrellaImageCheck" owner:nil options:nil] firstObject];
    [self.imageCkeck didChoseImage:^(UIImage *image) {
        [self goToCutPhoto:image];
    }];
    [self.view addSubview:self.imageCkeck];
    [self.imageCkeck mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_bottom);
//        make.centerY.equalTo(self.view.mas_centerY);
        make.trailing.equalTo(self.view.mas_trailing).offset(-40);
        make.leading.equalTo(self.view.mas_leading).offset(40);
        make.height.equalTo(self.checkView.mas_width);
    }];
    [self performSelector:@selector(getNilImageWith) withObject:nil afterDelay:0.1f];
}

- (void)getNilImageWith{
    self.nilImage = [self convertViewToImage:self.sanmian];
//    self.testShow.image = self.nilImage;
}

- (void)grayViewOnClick{
    [self.checkSan removeAllObjects];
    [UIView animateWithDuration:0.5 animations:^{
        [self.imageCkeck mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_bottom);
        }];
        [self.view layoutIfNeeded];
    }completion:^(BOOL finished) {
        [self.view sendSubviewToBack:self.grayView];
        self.grayView.backgroundColor = [UIColor clearColor];
    }];
    [UIView animateWithDuration:0.5 animations:^{
        [self.checkView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_bottom);
        }];
        [self.view layoutIfNeeded];
    }completion:^(BOOL finished) {
        [self.view sendSubviewToBack:self.grayView];
        self.grayView.backgroundColor = [UIColor clearColor];
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
            }else{
                [self.checkSan removeAllObjects];
                [self.view makeToast:@"请选择相邻的伞面!"];
            }
        }];
        if (checkNumber.count == 3) {
//            [self.imageff mas_remakeConstraints:^(MASConstraintMaker *make) {
//                
//            }];
//            [self.imageff mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(self.view.mas_bottom);
//                make.centerX.equalTo(self.view.mas_centerX);
//                make.width.equalTo(self.sanmian.mas_width);
//                make.height.equalTo(self.sanmian.mas_height);
//            }];
        }else{
//            [self.imageff mas_remakeConstraints:^(MASConstraintMaker *make) {
//                
//            }];
//            [self.imageff mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(self.view.mas_bottom);
//                make.centerX.equalTo(self.view.mas_centerX);
//                make.width.equalTo(self.sanmian.mas_width).multipliedBy(0.5);
//                make.height.equalTo(self.sanmian.mas_height).multipliedBy(0.5);
//            }];
        }
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
//    self.checkView.oldCheck = self.oldCkeck;
    [UIView animateWithDuration:0.5 animations:^{
        [self.checkView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_bottom).offset(-(self.sanmian.frame.size.height+self.sanmian.frame.origin.y));
        }];
        [self.view layoutIfNeeded];
    }completion:^(BOOL finished) {
        [self.view insertSubview:self.grayView atIndex:self.view.subviews.count-3];
        self.grayView.backgroundColor = RGBACOLOR(0, 0, 0, 0.2);
    }];
    
}

//显示 花纹选择
- (void)showImageCheck{
    if (!self.showCateArray) {
        [[HttpManager sharedHttpManager] getWithUrl:@"/shop/common/getImageType?" Parames:@{@"mobile":[[NSUserDefaults standardUserDefaults] valueForKey:@"mobile"],@"typeId":@0} success:^(id successData) {
            NSArray *cateArray = successData[@"object"];
            self.showCateArray= cateArray;
            [self showAction:self.showCateArray];
        } errorBlock:^(NSError *error) {
            
        }];
    }else{
        [self showAction:self.showCateArray];
    }
}

- (void)showAction:(NSArray *)cateArray{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"手机图库" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.isHostPhoto = YES;
        [self showHostImage];
    }]];
    for (int i = 0; i<cateArray.count; i++) {
        [alert addAction:[UIAlertAction actionWithTitle:cateArray[i][@"typeName"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.isHostPhoto = NO;
            [self showImageCheckView:cateArray[i][@"typeCategoryId"]];
        }]];
    }
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

//现实图片view
- (void)showImageCheckView:(NSString *)cageId{
    self.imageCkeck.cageteId = cageId;
    [UIView animateWithDuration:0.5 animations:^{
        [self.imageCkeck mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_bottom).offset(-(self.sanmian.frame.size.height+self.sanmian.frame.origin.y));
        }];
        [self.view layoutIfNeeded];
    }completion:^(BOOL finished) {
        [self.view insertSubview:self.grayView atIndex:self.view.subviews.count-3];
        self.grayView.backgroundColor = RGBACOLOR(0, 0, 0, 0.2);
    }];
}

- (void)showHostImage{
    // 跳转到相机或相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerController animated:YES completion:^{}];
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    userImageView.image = image;
    
//    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
//    UIImage *compressedImage = [UIImage imageWithData:imageData];
    [self goToCutPhoto:image];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.checkSan removeAllObjects];
}


- (void)goToCutPhoto:(UIImage *)image{
    UmPhotoCutController *um = [[UmPhotoCutController alloc] init];
    um.hostImage = image;
    UINavigationController *umNa = [[UINavigationController alloc] initWithRootViewController:um];
    [self presentViewController:umNa animated:YES completion:^{
        
    }];
    [um didCutImageFinish:^(UIImage *cutImage) {
        if (self.checkSan.count <= 3) {
            if (self.checkSan.count == 1) {
                cutImage = [cutImage imageAtRect:CGRectMake(0, 0,(int)(self.sanmian.frame.size.height*(45*3.14/180/2)),self.sanmian.frame.size.height/2)];
            }else if(self.checkSan.count == 2){
                double width = (self.sanmian.frame.size.width/2) * (self.sanmian.frame.size.width/2) + (self.sanmian.frame.size.width/2) * (self.sanmian.frame.size.width/2);
                cutImage = [cutImage imageAtRect:CGRectMake(0, 0, sqrt(width), sqrt(width))];
            }else if(self.checkSan.count == 3){
                double width = self.sanmian.frame.size.width/2*cos(45*M_PI/180) + self.sanmian.frame.size.width/2;
                cutImage = [cutImage imageAtRect:CGRectMake(0, 0, width, width)];
            }else{
                cutImage = [cutImage imageAtRect:CGRectMake(0, 0, self.sanmian.frame.size.width, self.sanmian.frame.size.height)];
            }
        }

//        bool isCut = YES;
//        if (self.checkSan.count > 3) {
//            isCut = NO;
//        }
        
        float angle = (360-([self.checkSan[0] integerValue]-1)*45-180);
        if (self.checkSan.count ==2 || self.checkSan.count == 3) {
            angle = 180-45*[self.checkSan[0] integerValue];
        }else if(self.checkSan.count ==4){
            angle = 135-45*[self.checkSan[0] integerValue];
        }else if(self.checkSan.count >4){
            angle = (8 - self.checkSan.count)*45;
        }
        
        cutImage = [cutImage rotateImageWithAngle:cutImage Angle:angle IsExpand:YES checkCount:self.checkSan.count checkone:[self.checkSan[0]  integerValue]];
        UIImage *newi = [self roteAndScall:cutImage checkSanCount:self.checkSan.count startNumber:[self.checkSan[0] integerValue]];
        
//        bool isUserTanView = false;
//        if (self.checkSan.count < 4) {
//            if (self.checkSan.count==2 || self.checkSan.count == 3) {
//                if ([self.checkSan[0] integerValue]==2 || [self.checkSan[0] integerValue]==4 || [self.checkSan[0] integerValue]==6) {
//                    isUserTanView = YES;
//                }
//            }
//            if (self.checkSan.count == 1) {
//                isUserTanView = YES;
//            }
//        }

        if (self.isHostPhoto) {
            if (![self.orgImage containsObject:cutImage]) {
                [self.orgImage addObject:cutImage];
            }
        }
        if (self.checkType == MainCheckDan) {
//            UIImage *newImage = cutImage;
            for (NSNumber *check in self.checkSan) {
//                if (isUserTanView) {
//                    newImage = [self roteAndScall:cutImage checkSanCount:self.checkSan.count number:[check integerValue]];
//                }
                [self.checkSanMian setObject:newi forKey:check];
            }
            [self.sanmian setCheckImages:self.checkSanMian];
            
            self.danImage = [self convertViewToImage:self.sanmian];

        }else if(self.checkType == MainCheckShuang){
            if (self.umType == UmTypeWai) {
                for (NSNumber *check in self.checkSan) {
                    [self.checkSanWai setObject:cutImage forKey:check];
                }
                [self.sanmian setCheckImages:self.checkSanWai];
                self.suangWaiImage = [self convertViewToImage:self.sanmian];

            }else{
                for (NSNumber *check in self.checkSan) {
                    [self.checkSanNei setObject:cutImage forKey:check];
                }
                [self.sanmian setCheckImages:self.checkSanNei];
                self.suangNeiImage = [self convertViewToImage:self.sanmian];
            }
        }
        
        [self.checkSan removeAllObjects];
        self.grayView.backgroundColor = [UIColor clearColor];
        [self.view sendSubviewToBack:self.grayView];
        [UIView animateWithDuration:0.5 animations:^{
            [self.imageCkeck mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view.mas_bottom);
            }];
            [self.view layoutIfNeeded];
        }];
    }];
}

- (UIImage *)roteAndScall:(UIImage *)image checkSanCount:(NSInteger)count startNumber:(NSInteger)number{
//    if (self.checkSan.count < 6) {
        self.imageff.sanMianCount = self.checkSan.count;
        self.imageff.startSan = [self.checkSan[0] integerValue];
        self.imageff.image= image;
        image = [self convertViewToImage:self.imageff];
//    }
//    else if(self.checkSan.count==2 || self.checkSan.count==3){
//        if (self.checkSan.count == 3) {
//            self.imageff.treeStartInde = [self.checkSan[0] integerValue];
//        }
//        self.imageff.sanMianCount = self.checkSan.count;
//        self.imageff.startSan = number;
//        self.imageff.image= image;
//        image = [self convertViewToImage:self.imageff];
//    }
    return image;
}

- (IBAction)someBtnOnclick:(UIButton *)sender {
    if (sender.tag == 1) {
        if (self.checkType == MainCheckDan && self.checkSanMian.allKeys.count>0) {
            [self.view makeToast:@"单面只能选择一面!"];
            return;
        }
        [self.sanmian setCheckImages:self.checkSanNei];
        self.umType = UmTypeNei;
        self.neiBtn.backgroundColor = RGBACOLOR(239, 215, 66, 1);
        self.waiBtn.backgroundColor = [UIColor whiteColor];
        NSLog(@"内");
    }else if(sender.tag == 2){
        if (self.checkType == MainCheckDan && self.checkSanMian.allKeys.count>0) {
            [self.view makeToast:@"单面只能选择一面!"];
            return;
        }
        [self.sanmian setCheckImages:self.checkSanWai];
        self.umType = UmTypeWai;
        self.waiBtn.backgroundColor = RGBACOLOR(239, 215, 66, 1);
        self.neiBtn.backgroundColor = [UIColor whiteColor];
        NSLog(@"外");
    }else if(sender.tag == 3){
        self.checkType =  MainCheckDan;
        [self.sanmian setCheckImages:self.checkSanMian];
        self.danBtn.backgroundColor = RGBACOLOR(251, 145, 50, 1);
        self.allBtn.backgroundColor = RGBACOLOR(239, 215, 66, 1);
        self.suangBtn.backgroundColor = RGBACOLOR(239, 215, 66, 1);
        self.submitBtn.backgroundColor = RGBACOLOR(239, 215, 66, 1);
        NSLog(@"单层");
    }else if(sender.tag == 4){
        self.checkType =  MainCheckShuang;
        if (self.umType == UmTypeWai) {
            [self.sanmian setCheckImages:self.checkSanWai];
        }else{
            [self.sanmian setCheckImages:self.checkSanNei];
        }
        for (int i = 1; i<9; i++) {
            [self.checkSanNei setValue:[UIImage imageNamed:@"default"] forKey:[NSString stringWithFormat:@"%d",i]];
            [self.checkSanWai setValue:[UIImage imageNamed:@"default"] forKey:[NSString stringWithFormat:@"%d",i]];
        }
        [self.sanmian setCheckImages:self.checkSanWai];
        self.suangNeiImage = [self convertViewToImage:self.sanmian];
        self.suangWaiImage = [self convertViewToImage:self.sanmian];
        self.suangBtn.backgroundColor = RGBACOLOR(251, 145, 50, 1);
        self.allBtn.backgroundColor = RGBACOLOR(239, 215, 66, 1);
        self.danBtn.backgroundColor = RGBACOLOR(239, 215, 66, 1);
        self.submitBtn.backgroundColor = RGBACOLOR(239, 215, 66, 1);
        NSLog(@"双层");
    }else if(sender.tag == 5){
        if (self.checkType == MainCheckDan) {
            [self.checkSanMian removeAllObjects];
            [self.sanmian setCheckImages:self.checkSanMian];
        }else if(self.checkType == MainCheckShuang){
            if (self.umType == UmTypeWai) {
                [self.checkSanWai removeAllObjects];
                [self.sanmian setCheckImages:self.checkSanWai];
            }else{
                [self.checkSanNei removeAllObjects];
                [self.sanmian setCheckImages:self.checkSanNei];
            }
        }
        self.allBtn.backgroundColor = RGBACOLOR(251, 145, 50, 1);
        self.danBtn.backgroundColor = RGBACOLOR(239, 215, 66, 1);
        self.suangBtn.backgroundColor = RGBACOLOR(239, 215, 66, 1);
        self.submitBtn.backgroundColor = RGBACOLOR(239, 215, 66, 1);
        NSLog(@"取消");
    }else if(sender.tag == 6){
        self.submitBtn.backgroundColor = RGBACOLOR(251, 145, 50, 1);
        self.allBtn.backgroundColor = RGBACOLOR(239, 215, 66, 1);
        self.suangBtn.backgroundColor = RGBACOLOR(239, 215, 66, 1);
        self.danBtn.backgroundColor = RGBACOLOR(239, 215, 66, 1);
        if (self.checkType == MainCheckDan) {
            if (self.umType == UmTypeNei) {
                [self submitImage:self.danImage outImage:self.nilImage type:1 orgImage:self.orgImage];
            }else{
                [self submitImage:self.nilImage outImage:self.danImage type:1 orgImage:self.orgImage];
            }
        }else if(self.checkType == MainCheckShuang){
            [self submitImage:self.suangNeiImage outImage:self.suangWaiImage type:2 orgImage:self.orgImage];
        }
        NSLog(@"提交");
    }
}

/***
 * @prama innerImage  内面效果图
 * @prama outImage    外面效果图
 * @prama sanType     单双层 1单层  2双层
 * @prama orgImage    相机原图
 **/
- (void)submitImage:(UIImage *)innerImage outImage:(UIImage *)outImage type:(NSInteger)sanType orgImage:(NSMutableArray *)orgImage{

    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"mobile"] forKey:@"mobile"];
    [param setValue:@(sanType) forKey:@"layer"];
    [[HttpManager sharedHttpManager] postImageWithUrl:@"/shop/common/submitOrder" Parames:param innerImage:innerImage outImage:outImage orgImages:orgImage success:^(id successData) {
        [self.view makeToast:successData[@"message"]];
    } errorBlock:^(NSError *error) {
        
    }];
}

//uiview 转换成 uiimage
-(UIImage*)convertViewToImage:(UIView*)v{
    CGSize s = v.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
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
