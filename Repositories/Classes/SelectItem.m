//
//  SelectItem.m
//  Dental-iPad
//
//  Created by Sanch0 on 10/7/14.
//  Copyright (c) 2014 Finnet Limited. All rights reserved.
//

@implementation SelectItem

+ (JSONKeyMapper *)keyMapper {
    return [self keyMapperWithDic:@{@"description" : @"descrip"}];
}

+ (NSNumber *)indexOfSelectedItem:(SelectItem *)item withArray:(NSArray *)array {
    if (!item || array.count == 0) {
        return nil;
    }
    __block NSNumber *index = nil;
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (item.objectId) {
            if ([obj respondsToSelector:@selector(objectId)] && [[obj objectId] isEqualToNumber:item.objectId]) {
                index = @(idx);
                *stop = YES;
            }
        } else if (item.code.length > 0) {
            if ([obj respondsToSelector:@selector(code)] && [[(SelectItem *) obj code] isEqualToString:item.code]) {
                index = @(idx);
                *stop = YES;
            }
        }

    }];
    return index;
}

- (id)initWithId:(NSNumber *)objectId withName:(NSString *)name {
    self = [super init];
    if (self) {
        self.objectId = objectId;
        self.name = name;
    }

    return self;
}

- (BOOL)isEqual:(SelectItem *)object {
    if (![object isKindOfClass:[SelectItem class]]) {
        return NO;
    }
    if (self == object) {
        return YES;
    }

    return (object.objectId && [self.objectId isEqualToNumber:object.objectId]) || (object.code && [self.code isEqualToString:object.code]);
}

- (id)initWithId:(NSNumber *)objectId withName:(NSString *)name withCode:(NSString *)code {
    self = [super init];
    if (self) {
        self.objectId = objectId;
        self.name = name;
        self.code = code;
    }

    return self;
}


- (NSString *)autocompleteString {
    return self.name;
}

- (id)copyWithZone:(NSZone *)zone {
    SelectItem *copy = [[[self class] allocWithZone:zone] init];

    if (copy != nil) {
        copy.objectId = self.objectId;
        copy.name = self.name;
        copy.code = self.code;
        copy.descrip = self.descrip;
    }

    return copy;
}

+ (SelectItem *)selectItemWithCode:(NSString *)code {
    return [[SelectItem alloc] initWithId:nil withName:nil withCode:code];
}


+ (NSString *)nameSelectItem:(SelectItem *)selectItem withViewMode:(BOOL)isViewMode {

    return isViewMode && selectItem.name.trim.length == 0 ? TRANSLATE(@"N/A") : selectItem.name;
}

+ (NSMutableArray *)arrayWithPleaseSelectItem:(NSArray *)array {
    NSMutableArray *items = [[NSMutableArray alloc] init];
    [items addObject:[SelectItem pleaseSelectItem]];
    if (array) {
        [items addObjectsFromArray:array];
    }
    return items;
}


+ (NSMutableArray *)arrayOfModelsWithPleaseSelectItem:(NSArray *)array {
    NSMutableArray *models = [SelectItem arrayOfModelsFromDictionaries:array];
    [models insertObject:[SelectItem pleaseSelectItem] atIndex:0];
    return models;
}

+ (SelectItem *)pleaseSelectItem {
    return [[SelectItem alloc] initWithId:nil withName:TRANSLATE(@"Please, select")];
}

+ (SelectItem *)selectItemWithCode:(NSString *)code fromArray:(NSArray *)array {
    __block SelectItem *item = nil;
    if (code.length == 0 || array.count == 0) {
        return item;
    }
    [array enumerateObjectsUsingBlock:^(SelectItem *obj, NSUInteger idx, BOOL *stop) {
        if (obj.code.length > 0 && [obj.code isEqualToString:code]) {
            item = obj;
            *stop = YES;
        }
    }];
    return item;

}

- (SelectItem *)toSelectItem {
    return self;
}

+ (SelectItem *)selectItemWithName:(NSString *)name withCode:(NSString *)code {
    return [[SelectItem alloc] initWithId:nil withName:name withCode:code];
}


@end
