//
//  UMUtils.m
//  Umbrella
//
//  Created by huangrensheng on 16/10/25.
//  Copyright © 2016年 umbrella. All rights reserved.
//

#import "UMUtils.h"

@implementation UMUtils

- (BOOL)equlArray:(NSMutableArray *)checkArray{
    //创建俩新的数组
    NSMutableArray *oldArr = [NSMutableArray arrayWithArray:checkArray];
    
    bool bol = false;
    for (int i = 0; i<[self getAllCanChoseArray].count; i++) {
        NSMutableArray *newArr = [NSMutableArray arrayWithArray:[self getAllCanChoseArray][i]];
//        newArr = [self getAllCanChoseArray][i];
        //对数组1排序。
        [oldArr sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 integerValue] > [obj2 integerValue];
        }];
        
        //对数组2排序。
        [newArr sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 integerValue] > [obj2 integerValue];
        }];
        
        if (newArr.count == oldArr.count) {
            bol = true;
            for (int16_t i = 0; i < oldArr.count; i++) {
                
                id c1 = [oldArr objectAtIndex:i];
                id newc = [newArr objectAtIndex:i];
                
                if (![newc isEqualToString:c1]) {
                    bol = false;
                    break;
                }
            }
        }
        if (bol) {
            NSLog(@"相邻 可用！");
            break;
        }   
        else {   
            NSLog(@"不相邻 不可用！");
        }
    }
    return bol;
}

-(NSMutableArray *)getAllCanChoseArray{
    NSMutableArray *canArr = [NSMutableArray arrayWithObjects:@[@"8",@"1"],@[@"8",@"1",@"7"],@[@"8",@"1",@"2"],@[@"6",@"7",@"8",@"1"],@[@"7",@"8",@"1",@"2"],@[@"8",@"1",@"2",@"3"],@[@"8",@"1",@"2",@"3",@"4"],@[@"8",@"1",@"2",@"3",@"7"],@[@"8",@"7",@"1",@"2",@"6"],@[@"8",@"1",@"7",@"6",@"5"],@[@"8",@"1",@"2",@"3",@"4",@"5"],@[@"8",@"1",@"2",@"3",@"4",@"7"],@[@"8",@"1",@"2",@"3",@"7",@"6"],@[@"8",@"1",@"2",@"7",@"6",@"5"],@[@"8",@"1",@"7",@"6",@"5",@"4"],nil];//,@[@"8",@"1",@"2",@"3",@"4",@"5",@"6"],@[@"8",@"1",@"2",@"3",@"4",@"5",@"7"],@[@"8",@"1",@"2",@"3",@"4",@"7",@"6"],@[@"8",@"1",@"2",@"3",@"7",@"5",@"6"],@[@"8",@"1",@"2",@"7",@"4",@"5",@"6"],@[@"8",@"1",@"7",@"3",@"4",@"5",@"6"],
    return canArr;
}

//把两个数组都转换成nsset然后比较两个set是否是另一个的子集
- (BOOL)isOther:(NSMutableArray *)check{
    NSArray *array1 = check;
    NSArray *array2 = [NSArray arrayWithObjects:@"1",@"8",nil];
    NSSet *set1 = [NSSet setWithArray:array1];
    NSSet *set2 = [NSSet setWithArray:array2];
    if ([set2 isSubsetOfSet:set1]) {
        return YES;
    }else {
        return NO;
    }
}

- (BOOL)isConp:(NSString *)cout check:(NSMutableArray *)checkArray{
    if ([checkArray containsObject:cout]) {
        return YES;
    }else{
        return NO;
    }
}

- (NSInteger)diffCount:(NSMutableArray *)checkArray{
    //把数据源拿出来创建临时的数组，不要直接使用数据源
    NSArray *answer = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8", nil];//答案数组
    NSArray *select = checkArray;    //用户选的选项
    NSArray *unselectTure = @[];
    if ([answer isEqualToArray:select]) {
        //一样就是对的
        
    }else {
        //不一样就是错的
        //拿出来answer 和 select 中一样的
        NSArray *selectTure = [answer filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF in %@", select]];
        NSLog(@"用户选择对的 -> %@", selectTure);
        
        NSArray *selectWrong = [select filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"NOT (SELF in %@)", answer]];
        NSLog(@"用户选择是错的 -> %@", selectWrong);
        
        unselectTure = [answer filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"NOT (SELF in %@)", selectTure]];
        NSLog(@"用户没选择的正确答案 -> %@", unselectTure);  
        
    }
    return [unselectTure[0] integerValue];
}
@end
