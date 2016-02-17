//
//  BaseObject.h
//  Dental-iPad
//
//  Created by Sanch0 on 10/7/14.
//  Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import "JSONModel.h"

@interface BaseObject : JSONModel<NSCopying>

@property (nonatomic, strong) NSNumber *objectId;
@property (nonatomic,   copy) NSString *name;

+ (JSONKeyMapper*)keyMapperWithDic:(NSDictionary *)dictValues;

- (id)initWithObjectId:(NSNumber *)objectId withName:(NSString *)name;
@end
