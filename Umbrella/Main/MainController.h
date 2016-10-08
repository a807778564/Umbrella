//
//  MainController.h
//  Umbrella
//
//  Created by huangrensheng on 16/9/28.
//  Copyright © 2016年 umbrella. All rights reserved.
//

#import "BaseController.h"

typedef NS_ENUM(NSInteger){
    MainCheckCancel,//取消
    MainCheckDan,//单面
    MainCheckShuang,//双面
    MainCheckSubimt//提交
}MainCheckType;

typedef NS_ENUM(NSInteger){
    UmTypeNei,//内伞面
    UmTypeWai//外伞面
}UmType;

@interface MainController : BaseController

@end
