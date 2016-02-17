//
// Created by Sanch0 on 4/8/15.
// Copyright (c) 2015 Finnet Limited. All rights reserved.
//

#import "NSNumber+Addition.h"


@implementation NSNumber (Addition)

- (BOOL)valueExist {
    return self && ![self isEqual:[NSNull null]];
}


- (BOOL)valueExistAndTrue {
    return self.valueExist && self.boolValue;
}

- (BOOL)valueExistAndFalse {
    return self.valueExist && !self.boolValue;
}

@end