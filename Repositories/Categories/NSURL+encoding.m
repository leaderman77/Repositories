//
//  NSURL+encoding.m
//  travede-iphone
//
//  Created by Mirzohidbek on 6/23/14.
//  Copyright (c) 2014 travede. All rights reserved.
//

#import "NSURL+encoding.h"

@implementation NSURL (encoding)

+ (NSURL *)URLWithString:(NSString *)URLString 
{
    NSURL *url = [[NSURL alloc] initWithString:[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if(url) {
        if(!url.scheme || !url.host) {
            return nil;
        }
    }
    return url;
}

@end
