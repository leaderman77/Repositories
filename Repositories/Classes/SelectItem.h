//
//  SelectItem.h
//  Dental-iPad
//
//  Created by Sanch0 on 10/7/14.
//  Copyright (c) 2014 Finnet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseObject.h"
#import "MLPAutoCompletionObject.h"

@class SelectItem;
@class NSString;
@class NSNumber;

@protocol SelectItem <MLPAutoCompletionObject, NSCopying>

@optional
- (SelectItem *)toSelectItem;
@end

@interface SelectItem : BaseObject <SelectItem>

@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *descrip;

@property (nonatomic, strong) NSNumber <Ignore> *checked;

@property (nonatomic, strong) NSNumber *selected;

- (id)initWithId:(NSNumber *)objectId withName:(NSString *)name;

- (id)initWithId:(NSNumber *)objectId withName:(NSString *)name withCode:(NSString *)code;

+ (NSNumber *)indexOfSelectedItem:(SelectItem *)item withArray:(NSArray *)array;

+ (NSMutableArray *)arrayOfModelsWithPleaseSelectItem:(NSArray *)array;

+ (NSMutableArray *)arrayWithPleaseSelectItem:(NSArray *)array;

+ (SelectItem *)selectItemWithCode:(NSString *)code;

+ (SelectItem *)pleaseSelectItem;

+ (SelectItem *)selectItemWithCode:(NSString *)code fromArray:(NSArray *)array;

+ (NSString *)nameSelectItem:(SelectItem *)selectItem withViewMode:(BOOL)isViewMode;

+ (SelectItem *)selectItemWithName:(NSString *)name withCode:(NSString *)code;

@end
