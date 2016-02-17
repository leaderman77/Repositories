//
// Created by Sanch0 on 11/5/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//


@implementation NSUserDefaults (Additions)

+ (id)objectForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (void)setObject:(id)object ForKey:(id)key {
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSMutableArray *)mutableArrayForKey:(id)key {
    NSArray *arrayForKey = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    NSMutableArray *resultArray = [[NSMutableArray alloc] initWithArray:arrayForKey ? arrayForKey : @[]];
    return resultArray;
}

+ (NSMutableDictionary *)mutableDictionaryForKey:(id)key {
    NSDictionary *dicForKey = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    NSMutableDictionary *resultDic = [[NSMutableDictionary alloc] initWithDictionary:dicForKey ? dicForKey : @{}];
    return resultDic;
}




@end