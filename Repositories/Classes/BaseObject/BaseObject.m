//
//  BaseObject.m
//  Dental-iPad
//
//  Created by Sanch0 on 10/7/14.
//  Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import "BaseObject.h"

@implementation BaseObject

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

+ (NSMutableDictionary *)keyMapperDicValues:(NSDictionary *)valuesDic
{
    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                 @"id": @"objectId",
                                                                                 }];
    if(valuesDic) {
        [dict addEntriesFromDictionary:valuesDic];
    }
    return dict;
}

+ (JSONKeyMapper*)keyMapperWithDic:(NSDictionary *)dictValues {
    return [[JSONKeyMapper alloc] initWithDictionary:[self keyMapperDicValues:dictValues]];
}

+ (JSONKeyMapper*)keyMapper
{

	return [self keyMapperWithDic:nil];
}

- (instancetype)initWithObjectId:(NSNumber *)objectId withName:(NSString *)name
{
    self = [super init];
    if (self) {
        self.objectId = objectId;
        self.name = name;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    BaseObject *copy = [[[self class] allocWithZone:zone] init];

    if (copy != nil) {

    }

    return copy;
}


@end
