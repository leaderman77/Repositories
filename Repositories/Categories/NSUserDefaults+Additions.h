//
// Created by Sanch0 on 11/5/14.
// Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (Additions)

+ (id)objectForKey:(id)key;
+ (void)setObject:(id)object ForKey:(id)key;

+ (NSMutableArray *)mutableArrayForKey:(id)key;

+ (NSMutableDictionary *)mutableDictionaryForKey:(id)key;

@end