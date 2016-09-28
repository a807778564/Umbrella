//
//  FormatChecker.m
//  HomeDo
//
//  Created by huangrensheng on 15/12/10.
//  Copyright © 2015年 Lynn. All rights reserved.
//  正则表达式

#import "FormatChecker.h"

@implementation FormatChecker

+ (BOOL)checkUserName:(NSString *)userName{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[_\u4E00-\u9FA5A-Za-z][_\u4E00-\u9FA5A-Za-z0-9_]+$" options:0 error:nil];
    NSTextCheckingResult *r = [regex firstMatchInString:userName options:0 range:NSMakeRange(0, userName.length)];
    return r != nil;
}

+(BOOL)checkTelNumber:(NSString *)tel
{
    if ([tel isEqualToString:@""] || !tel) {
        return NO;
    }
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^1[3|5|7|8|9]\\d{9}$" options:0 error:nil];
    NSTextCheckingResult *r = [regex firstMatchInString:tel options:0 range:NSMakeRange(0, tel.length)];
    return r != nil;
}

//电话号码与手机号码同时验证
+(BOOL)checkTelNumberAndPhone:(NSString *)tel
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^((1[3|5|7|8|9]\\d{9})|(0\\d{2,3}-\\d{7,8}))$" options:0 error:nil];
    NSTextCheckingResult *r = [regex firstMatchInString:tel options:0 range:NSMakeRange(0, tel.length)];
    return r != nil;
}

+(BOOL)checkQQ:(NSString *)qq
{
    if(nil == qq)
    {
        return NO ;
    }
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[0-9]" options:0 error:nil];
    NSTextCheckingResult *r = [regex firstMatchInString:qq options:0 range:NSMakeRange(0, qq.length)];
    return r != nil;
}

+(BOOL)checkEmail:(NSString *)email
{
    // [A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}  //^\\w+@\\w+\\.[a-zA-Z]+(\\.[a-zA-Z]+)?$
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}" options:0 error:nil];
    NSTextCheckingResult *r = [regex firstMatchInString:email options:0 range:NSMakeRange(0, email.length)];
    return r != nil;
}

+(BOOL)checkBnakNumber:(NSString *)bankNumber{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[0-9]*$" options:0 error:nil];
    NSTextCheckingResult *r = [regex firstMatchInString:bankNumber options:0 range:NSMakeRange(0, bankNumber.length)];
    return r != nil;
}

+(BOOL)checkIdentifer:(NSString *)string{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^\\d{15}$)|(^\\d{17}([0-9]|X)$" options:0 error:nil];
    NSTextCheckingResult *r = [regex firstMatchInString:string options:0 range:NSMakeRange(0, string.length)];
    return r != nil;
}

+(BOOL)checkPostNum:(NSString *)string{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^\\d{6}$" options:0 error:nil];
    NSTextCheckingResult *r = [regex firstMatchInString:string options:0 range:NSMakeRange(0, string.length)];
    return r != nil;
}

+(BOOL)checkPrice:(NSString *)price{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^\\d+(\\.\\d+)?$" options:0 error:nil];
    NSTextCheckingResult *r = [regex firstMatchInString:price options:0 range:NSMakeRange(0, price.length)];
    return r != nil;
}
@end
