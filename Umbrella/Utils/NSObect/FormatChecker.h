//
//  FormatChecker.h
//  HomeDo
//
//  Created by huangrensheng on 15/12/10.
//  Copyright © 2015年 Lynn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FormatChecker : NSObject

+(BOOL)checkUserName:(NSString *)userName;

+(BOOL)checkTelNumber:(NSString *)tel;

//电话号码与手机号码同时验证
+(BOOL)checkTelNumberAndPhone:(NSString *)tel;

+(BOOL)checkQQ:(NSString *)qq;

+(BOOL)checkEmail:(NSString *)email;

//验证银行卡号 16位或者19位
+(BOOL)checkBnakNumber:(NSString *)bankNumber;

/**身份证认证**/
+(BOOL)checkIdentifer:(NSString *)string;

+(BOOL)checkPrice:(NSString *)price;

+(BOOL)checkPostNum:(NSString *)string;

@end
