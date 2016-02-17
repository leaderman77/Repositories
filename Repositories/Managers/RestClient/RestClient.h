//
//  RestClient.h
//
//  Created by Sancho on 1/9/13.
//  Copyright (c) 2013 FinnetLimited.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"
#import <CoreLocation/CoreLocation.h>

@protocol BaseProtocol;
@class AFHTTPRequestOperation;

typedef void (^ResponseCallback)(NSDictionary *response, NSError *error);

typedef enum {
    HTTP_GET,
    HTTP_POST,
    HTTP_PUT,
    HTTP_DELETE
} HTTPMethodType;

@protocol RestClientProtocol <NSObject>

@optional
- (void)requestStartedLog:(NSString *)path withParameters:(NSDictionary *)parameter;

- (void)requestStartedLog:(NSString *)path withMethodType:(HTTPMethodType)methodType withParameters:(NSDictionary *)parameters;

- (void)requestFinishedLog:(AFHTTPRequestOperation *)operation withReponseObject:(id)responseObject;

- (void)requestFailedLog:(NSError *)error;

- (void)showErrorMessage:(id)message;

- (void)verifyUserEmail:(NSString *)email password:(NSString *)password completionHandler:(void (^)(BOOL success, NSError *error))completionHandler;

- (AFHTTPRequestOperation *)operationWithPath:(NSString *)path withHTTPMethodType:(HTTPMethodType)httpMethod withParameters:(NSDictionary *)parameters callback:(void (^)(NSDictionary *responseDic, NSError *error))callback;
@end

@interface RestClient : AFHTTPClient <RestClientProtocol>

+ (RestClient *) sharedClient;

//+ (RestClient *) sharedClientWithLoaderView:(id<BaseProtocol>)loaderView;
+ (RestClient *) sharedFormClient;
+ (RestClient *) clientWithPreloaderView:(UIView *)view;

@property (nonatomic, assign) CLLocationCoordinate2D userLocation;
@property (nonatomic, assign) UIView * preloaderBgView;

@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, copy) NSString *refreshToken;

@property (nonatomic, assign) BOOL showErrors;


- (void)callMethodByPath:(NSString *)path withHTTPMethodType:(HTTPMethodType )httpMethodType withParameters:(NSDictionary *)parameters callback:(void (^)(NSDictionary *responseDic, NSError *error))callback;

- (void)uploadImage:(NSData *)imageData callback:(void (^)(NSDictionary *responseDic, NSError *error))callback;
- (void)uploadImageByPath:(NSString *)path  withData:(NSData *)imageData callback:(void (^)(NSDictionary *responseDic, NSError *error))callback;
- (void)uploadImageByPath:(NSString *)path  withData:(NSData *)imageData withIndexPath:(NSIndexPath*)indexPath callback:(void (^)(NSDictionary *responseDic, NSError *error, NSIndexPath *indexPath))callback;
- (void)downloadFileByURL:(NSURL *)url  callback:(void (^)(NSData *data, NSError *error))callback;

@end



