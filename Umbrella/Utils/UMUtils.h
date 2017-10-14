//
//  UMUtils.h
//  Umbrella
//
//  Created by huangrensheng on 16/10/25.
//  Copyright © 2016年 umbrella. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMUtils : NSObject
- (BOOL)equlArray:(NSMutableArray *)checkArray;

- (BOOL)isOther:(NSMutableArray *)check;//是否是包含 1 和 8 的特殊情况

- (BOOL)isConp:(NSString *)cout check:(NSMutableArray *)checkArray;//是否包含某个对象

- (NSInteger)diffCount:(NSMutableArray *)checkArray;//没有选择的面
@end
