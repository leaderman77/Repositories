//
//  RestClient.m
//
//  Created by Sancho on 1/9/13.
//  Copyright (c) 2013 FinnetLimited.com. All rights reserved.
//

#import "AFJSONRequestOperation.h"
//#import "CustomNavigationController.h"
#import "AppDelegate.h"
#import "AFHTTPRequestOperation.h"
//#import "Utils.h"

static RestClient *_sharedClient = nil;
static dispatch_once_t onceToken;


#define WRONG_API_VERSION_CODE 7
#define ACCESS_DENIED_CODE 403
#define SERVER_ERROR_RESPONSE @"SERVER_ERROR_RESPONSE "


static NSString *const kBaseURLString = @"http://10.10.0.225:8080/services/pms/";

@interface RestClient () {

    //void (^_successBlock)(AFHTTPRequestOperation *, id);
    //void (^_failureBlock)(AFHTTPRequestOperation *, id);

}

//@property (nonatomic, copy) void(^successBlock)(AFHTTPRequestOperation *, id);

- (void)callMethodByPath:(NSString *)path withHTTPMethodType:(HTTPMethodType)httpMethodType withParameters:(NSDictionary *)parameters callback:(void (^)(NSDictionary *responseObject, NSError *error))callback;

- (AFHTTPRequestOperation *)operationWithPath:(NSString *)path withHTTPMethodType:(HTTPMethodType)httpMethod withParameters:(NSDictionary *)parameters callback:(void (^)(NSDictionary *responseDic, NSError *error))callback;

- (NSArray *)getErrors:(NSDictionary *)responseDic;

- (void)populateHeader;

- (void)clearHeader;


@end

@implementation RestClient

- (void)dealloc {
    self.preloaderBgView = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

+ (RestClient *)sharedClient {
    dispatch_once(&onceToken, ^{
        _sharedClient = [[RestClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    });
    [_sharedClient setParameterEncoding:AFJSONParameterEncoding];
    _sharedClient.preloaderBgView = nil;
    return _sharedClient;
}

+ (RestClient *)sharedFormClient {
    RestClient *client = [self sharedClient];
    [client setParameterEncoding:AFFormURLParameterEncoding];
    return client;
}


+ (RestClient *)clientWithPreloaderView:(UIView *)view {
    dispatch_once(&onceToken, ^{
        NSURL *url = [[NSUserDefaults standardUserDefaults] objectForKey:@"baseURL"];
        _sharedClient = [[RestClient alloc] initWithBaseURL:url ? url : [NSURL URLWithString:BASE_URL]];
    });
//    if (_sharedClient.preloaderBgView && [_sharedClient.preloaderBgView isKindOfClass:[UIView class]]) [_sharedClient.preloaderBgView showPreloader:NO];
    _sharedClient.preloaderBgView = view;
    return _sharedClient;
}


- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }

    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setParameterEncoding:AFJSONParameterEncoding];
    [self setDefaultHeaderValues];
//    
//    [self setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        if (status == AFNetworkReachabilityStatusReachableViaWiFi || status == AFNetworkReachabilityStatusReachableViaWWAN)
//            DLog(@"network is ONLINE");
//        else if (status == AFNetworkReachabilityStatusNotReachable)
//            DLog(@"network is OFFLINE");
//        else
//            DLog(@"network is UNKNOWN");
//        
//    }];
    self.showErrors = YES;

//    if ([[SettingsManager sharedManager] isUserInfoSaved]) {
//        
//    }
    return self;
}

- (void)setDefaultHeaderValues {
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    [self setDefaultHeader:@"Content-Type" value:@"application/json"];

}

- (NSArray *)getErrors:(NSDictionary *)responseDic {
    NSArray *errors = nil;
//    id error = NULL_TO_NIL(responseDic[FIELD_ERROR]) ? responseDic[FIELD_ERROR] : responseDic[FIELD_ERRORS];
//    if (NULL_TO_NIL(error)) {
//        errors = ([error isKindOfClass:([NSArray class])]) ? error : [NSArray arrayWithObject:error];
//    } else {
//        errors = [NSArray array];
//    }
    return errors;
}

- (void)clearHeader {
    [self.defaultHeaders removeObjectForKey:@"Authorization"];
    [self.defaultHeaders removeObjectForKey:@"api_version"];
}

- (void)populateHeader {
    [self clearHeader];
//    if ([[SettingsManager sharedManager] accessToken] && self.parameterEncoding != AFFormURLParameterEncoding) {
////        self.defaultHeaders[@"Authorization"] = [@"Bearer" stringByAppendingFormat:@" %@", @"1bbd13f1-53d0-4b01-81b4-a294243ec4b9"];
//        self.defaultHeaders[@"Authorization"] = [@"Bearer" stringByAppendingFormat:@" %@", [[SettingsManager sharedManager] accessToken]];
//    }
    self.defaultHeaders[@"api_version"] = @"1.0";
}

#pragma mark - LOGGING REQUEST

- (void)requestStartedLog:(NSString *)path withParameters:(NSDictionary *)parameters {
    NSURL *url = [[NSURL alloc] initWithString:path relativeToURL:self.baseURL];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    DLog(@"Request started: %@. URL : %@; Headers : %@; Body:%@", [NSDate date], [url absoluteString], self.defaultHeaders, jsonStr);
}

- (void)requestStartedLog:(NSString *)path withMethodType:(HTTPMethodType)methodType withParameters:(NSDictionary *)parameters {
    NSURL *url = [[NSURL alloc] initWithString:path relativeToURL:self.baseURL];
    if (methodType == HTTP_PUT || methodType == HTTP_POST) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

        DLog(@"Request started: %@. URL : %@; Headers : %@; Body:%@", [NSDate date], [url absoluteString], self.defaultHeaders, jsonStr);

    } else {
        DLog(@"Request started: %@. URL : %@; Headers : %@; URL-parameters:%@", [NSDate date], [url absoluteString], self.defaultHeaders, parameters);
    }

}
- (void)showErrorMessage:(id)message {
    NSString *messageStr = TRANSLATE(@"Error with calling method");
    if ([message isKindOfClass:[NSString class]]) {
        messageStr = message;
    } else if ([message isKindOfClass:[NSDictionary class]]) {
        messageStr = message[@"message"];
    }
    ALERT(TRANSLATE(messageStr));
}
- (void)requestFinishedLog:(AFHTTPRequestOperation *)operation withReponseObject:(id)responseObject {
//    DLog(@"Request finished: %@. StatusCode:%ld; URL : %@; Response : %@", [NSDate date], (long) operation.response.statusCode, [operation.request.URL absoluteString], operation.responseString);
    DLog(@"Request finished: %@. StatusCode:%ld; URL : %@; Response Headers: %@; \n Response : %@", [NSDate date], (long) operation.response.statusCode,
            [operation.request.URL absoluteString], [operation.response allHeaderFields], operation.responseString);
    if (responseObject) {
        DLog(@"RESPONSE OBJECT : %@", responseObject);
    }
}
- (void)requestFailedLog:(NSError *)error {
    DLog(@"Request failed: %@. ErrorInfo:%@", [NSDate date], error.userInfo);
}
- (void)callMethodByPath:(NSString *)path withParameters:(NSDictionary *)parameters callback:(void (^)(NSDictionary *responseObject, NSError *error))callback {
    [self callMethodByPath:path withHTTPMethodType:HTTP_POST withParameters:parameters callback:callback];
}

- (void)callMethodByPath:(NSString *)path withHTTPMethodType:(HTTPMethodType)httpMethodType withParameters:(NSDictionary *)parameters callback:(void (^)(NSDictionary *responseDic, NSError *error))callback {
//    if (self.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
//        [Utils showErrorWithMessage:@"Please check internet connection!"];
//        if (callback) {
//            callback([NSMutableArray array], [NSError errorWithDomain:@"Host is unreachable" code:-100 userInfo:nil]);
//        }
//        self.preloaderBgView = nil;
//        return;
//    }
    __weak RestClient *selfRef = self;
    void (^successBlock)(AFHTTPRequestOperation *, id) = ^(AFHTTPRequestOperation *operation, id responseObject) {
        //if (_preloaderBgView) [_preloaderBgView showPreloader:NO];
        [selfRef requestFinishedLog:operation withReponseObject:responseObject];
        NSError *error = nil;
        NSDictionary *responseDic = nil;
        if (responseObject) {
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                responseDic = [NSDictionary dictionaryWithObject:responseObject forKey:@"result"];
            } else {
                responseDic = responseObject;
                NSArray *errors = [selfRef getErrors:responseDic];
                if (errors && errors.count > 0) {
                    NSDictionary *userInfoDic = [[NSDictionary alloc] initWithObjectsAndKeys:errors, FIELD_ERRORS, operation, HTTP_REQUEST, nil];
                    error = [NSError errorWithDomain:SERVER_ERROR_RESPONSE code:-1 userInfo:userInfoDic];

#warning NEED TO CLARIFY SHOW IT ALLWAYS OR NOT?
                    if (self.showErrors) {
//                        [Utils showErrors:errors withTitle:TRANSLATE(@"Error")];
                    }
                }
//                else if ([responseDic[@"status"] integerValue] == 0)
//                {
//        NSDictionary *dataDic = NULL_TO_NIL(responseDic[@"data"]);
//        NSInteger code =[[dataDic objectForKey:@"code"] integerValue];
//        if (code == WRONG_API_VERSION_CODE) { //WRONG API VERSION
//                        error = [NSError errorWithDomain:SERVER_ERROR_RESPONSE code:WRONG_API_VERSION_CODE userInfo:nil];
//        } else if (code == ACCESS_DENIED_CODE) {
//        error =[NSError errorWithDomain:SERVER_ERROR_RESPONSE code:ACCESS_DENIED_CODE userInfo:nil];
//                    }
//                }
            }
        }

        /*[selfRef postRefreshOAuthTokenCallback:^(NSDictionary *response, NSError *error) {
            [selfRef callMethodByPath:path withHTTPMethodType:httpMethodType withParameters:parameters callback:callback];
        }];


*/
        
        
        self.showErrors = YES;
        if (callback) {
            callback(responseObject, error);
        }
        [operation clearData];
    };

    void (^failureBlock)(AFHTTPRequestOperation *, id) = ^(AFHTTPRequestOperation *operation, NSError *error) {
        [selfRef requestFailedLog:error];
        if (operation.response.allHeaderFields[@"vid"]) {
//            [Utils saveHeaderValue:operation.response.allHeaderFields[@"vid"] forKey:@"vid"];
        }

        NSMutableDictionary *userInfoDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:(error.userInfo) ? error.userInfo : [NSDictionary dictionary], @"userInfo",
                                                                                               operation, HTTP_REQUEST, nil];

        id responseObject = nil;
        if ([operation isKindOfClass:[AFJSONRequestOperation class]]) {
            AFJSONRequestOperation *jsonOper = (AFJSONRequestOperation *) operation;
            responseObject = jsonOper.responseJSON;
            if (responseObject) {
                if ([responseObject[FIELD_ERROR] isEqualToString:@"invalid_token"]) {
//                    [[RestClient sharedFormClient] postRefreshOAuthTokenCallback:^(NSDictionary *response, NSError *error) {
//                        if (!error) {
//                            [selfRef callMethodByPath:path withHTTPMethodType:httpMethodType withParameters:parameters callback:callback];
//                        } else {
//                            ALERT(TRANSLATE(@"Error, please try again later."));
//                            NSArray *errors = [selfRef getErrors:responseObject];
//                            if (errors.count > 0) {
//                                [userInfoDic setObject:errors forKey:FIELD_ERRORS];
//#warning NEED TO CLARIFY SHOW IT ALLWAYS OR NOT?
//                                if (self.showErrors) {
//                                    //                        [Utils showErrors:errors withTitle:TRANSLATE(@"Error")];
//                                }
//                            }
//                            NSError *_error = [[NSError alloc] initWithDomain:error.domain code:error.code userInfo:userInfoDic];
//                            if (callback) {
//                                callback(nil, _error);
//                            }
//                        }
//                    }];
                } else {
                    NSArray *errors = [selfRef getErrors:responseObject];
                    if (errors.count > 0) {
                        [userInfoDic setObject:errors forKey:FIELD_ERRORS];
#warning NEED TO CLARIFY SHOW IT ALLWAYS OR NOT?
                        if (self.showErrors) {
                            //                        [Utils showErrors:errors withTitle:TRANSLATE(@"Error")];
                        }
                    }
                    NSError *_error = [[NSError alloc] initWithDomain:error.domain code:error.code userInfo:userInfoDic];
                    if (callback) {
                        callback(nil, _error);
                    }


                }


            } else {
                NSError *_error = [[NSError alloc] initWithDomain:error.domain code:error.code userInfo:userInfoDic];
                if (callback) {
                    callback(nil, _error);
                }
            }

        }

        self.showErrors = YES;

        /*    NSError *_error = [[NSError alloc] initWithDomain:error.domain code:error.code userInfo:userInfoDic];
            if (callback)
                callback(nil, _error);*/
        [operation clearData];
    };
    [self populateHeader];
    NSDictionary *paramsDic = (parameters) ? parameters : [NSDictionary dictionary];
    [self requestStartedLog:path withMethodType:httpMethodType withParameters:paramsDic];
    switch (httpMethodType) {
        case HTTP_GET:
            [self getPath:path parameters:paramsDic success:successBlock failure:failureBlock];
            break;
        case HTTP_PUT:
            [self putPath:path parameters:paramsDic success:successBlock failure:failureBlock];
            break;
        case HTTP_POST:
            [self postPath:path parameters:paramsDic success:successBlock failure:failureBlock];
            break;
        case HTTP_DELETE:
            [self deletePath:path parameters:paramsDic success:successBlock failure:failureBlock];
            break;
        default:
            break;
    }
}

- (AFHTTPRequestOperation *)operationWithPath:(NSString *)path withHTTPMethodType:(HTTPMethodType)httpMethod withParameters:(NSDictionary *)parameters callback:(void (^)(NSDictionary *, NSError *))callback {
    [self populateHeader];
    __block RestClient *selfRef = self;


    void (^successBlock)(AFHTTPRequestOperation *, id) = ^(AFHTTPRequestOperation *operation, id responseObject) {
        //if (_preloaderBgView) [_preloaderBgView showPreloader:NO];
        [selfRef requestFinishedLog:operation withReponseObject:responseObject];
        NSError *error = nil;
        if (responseObject) {
            NSArray *errors = [selfRef getErrors:responseObject];
            if (errors.count > 0) {
                NSDictionary *userInfoDic = [[NSDictionary alloc] initWithObjectsAndKeys:errors, FIELD_ERRORS, operation, HTTP_REQUEST, nil];
                error = [NSError errorWithDomain:@"Server Error" code:-1 userInfo:userInfoDic];
            }
        }
        if (callback) {
            callback(responseObject, error);
        }
    };

    void (^failureBlock)(AFHTTPRequestOperation *, id) = ^(AFHTTPRequestOperation *operation, NSError *error) {
        [selfRef requestFailedLog:error];

        NSMutableDictionary *userInfoDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:(error.userInfo) ? error.userInfo : [NSDictionary dictionary], @"userInfo",
                                                                                               operation, HTTP_REQUEST, nil];

        id responseObject = nil;
        if ([operation isKindOfClass:[AFJSONRequestOperation class]]) {
            AFJSONRequestOperation *jsonOper = (AFJSONRequestOperation *) operation;
            responseObject = jsonOper.responseJSON;
            if (responseObject) {
                NSArray *errors = [selfRef getErrors:responseObject];
                if (errors.count > 0) {
                    [userInfoDic setObject:errors forKey:FIELD_ERRORS];
                }

            }

        }
        NSError *_error = [[NSError alloc] initWithDomain:error.domain code:error.code userInfo:userInfoDic];
        if (callback) {
            callback(nil, _error);
        }
    };
    NSDictionary *paramsDic = (parameters) ? parameters : [NSDictionary dictionary];

    [self requestStartedLog:path withParameters:paramsDic];
    NSString *methodName = nil;
    switch (httpMethod) {
        case HTTP_GET:
            methodName = @"GET";
            break;
        case HTTP_PUT:
            methodName = @"PUT";
            break;
        case HTTP_POST:
            methodName = @"POST";
            break;
        default:
            break;
    }

    NSURLRequest *request = [self requestWithMethod:methodName path:path parameters:parameters];
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:successBlock failure:failureBlock];
    return operation;
}

- (void)batchOperations:(NSArray *)operations withPreloader:(UIView *)preloaderView completionBlock:(void (^)(NSArray *operations))completionBlock {
    [self enqueueBatchOfHTTPRequestOperations:operations progressBlock:^(NSUInteger numberOfFinishedOperations, NSUInteger totalNumberOfOperations) {
        DLog(@"Request Finished : %lu of %lu", (unsigned long) numberOfFinishedOperations, (unsigned long) totalNumberOfOperations);
}                         completionBlock:completionBlock];
}

#pragma mark - Client methods

- (void)uploadImage:(NSData *)imageData callback:(void (^)(NSDictionary *responseDic, NSError *error))callback {
    NSString *path = @"";
    //	[self setDefaultHeader:@"sig" value:[@"SEKRET" MD5]];
    [self requestStartedLog:path withParameters:nil];

    NSURLRequest *request = [self multipartFormRequestWithMethod:@"POST" path:path parameters:nil constructingBodyWithBlock:^(id <AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"file" fileName:@"" mimeType:@"image/png"];
    }];
    AFJSONRequestOperation *operation = [[AFJSONRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self requestFinishedLog:operation withReponseObject:responseObject];
        NSError *error = nil;
        NSArray *responseArray = nil;
        if (responseObject) {
            if ([responseObject valueForKeyPath:FIELD_ERRORS]) {
                //				NSNumber * errorCode = [[responseObject valueForKeyPath:FIELD_ERROR] firstObject];
                NSDictionary *errorDic = [[responseObject valueForKeyPath:FIELD_ERRORS] firstObject];
                NSNumber *errorCode = errorDic[@"code"];
                error = [NSError errorWithDomain:API_DOMAIN_ERROR code:errorCode ? [errorCode intValue] : 0 userInfo:errorDic];
            } else {
                responseArray = [responseObject valueForKeyPath:FIELD_RESPONSE];
            }
        }
        if (callback) {
            callback(responseObject, error);
        }
    }                                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self requestFailedLog:error];
        if (callback) {
            callback(nil, error);
        }

    }];
    [operation start];
}

- (void)uploadImageByPath:(NSString *)path withData:(NSData *)imageData withIndexPath:(NSIndexPath *)indexPath callback:(void (^)(NSDictionary *responseDic, NSError *error, NSIndexPath *indexPath))callback {
    [self requestStartedLog:path withParameters:@{}];

    NSMutableURLRequest *request = [self multipartFormRequestWithMethod:@"POST" path:path parameters:nil constructingBodyWithBlock:^(id <AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"file" fileName:[NSString stringWithFormat:@"%@.jpeg", [NSDate date]] mimeType:@"image/jpeg"];
    }];

//    if ([[SettingsManager sharedManager] accessToken]) {
//        //        self.defaultHeaders[@"Authorization"] = [@"Bearer" stringByAppendingFormat:@" %@", @"1bbd13f1-53d0-4b01-81b4-a294243ec4b9"];
//        [request setValue:[@"Bearer" stringByAppendingFormat:@" %@", [[SettingsManager sharedManager] accessToken]] forHTTPHeaderField:@"Authorization"];
//    }
    AFJSONRequestOperation *operation = [[AFJSONRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self requestFinishedLog:operation withReponseObject:responseObject];
        NSError *error = nil;
        NSArray *responseArray = nil;
        if (responseObject) {
            if ([responseObject valueForKeyPath:FIELD_ERRORS]) {
                //				NSNumber * errorCode = [[responseObject valueForKeyPath:FIELD_ERROR] firstObject];
                NSDictionary *errorDic = [[responseObject valueForKeyPath:FIELD_ERRORS] firstObject];
                NSNumber *errorCode = errorDic[@"code"];
                error = [NSError errorWithDomain:API_DOMAIN_ERROR code:errorCode ? [errorCode intValue] : 0 userInfo:errorDic];
            } else {
                responseArray = [responseObject valueForKeyPath:FIELD_RESPONSE];
            }
        }
        if (callback) {
            callback(responseObject, error, indexPath);
        }
        }                                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self requestFailedLog:error];
        if (callback) {
            callback(nil, error, indexPath);
        }

    }];
    [operation start];
}

- (void)uploadImageByPath:(NSString *)path withData:(NSData *)imageData callback:(void (^)(NSDictionary *responseDic, NSError *error))callback {
    //	[self setDefaultHeader:@"sig" value:[@"SEKRET" MD5]];
    [self requestStartedLog:path withParameters:@{}];

    NSMutableURLRequest *request = [self multipartFormRequestWithMethod:@"POST" path:path parameters:nil constructingBodyWithBlock:^(id <AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"file" fileName:[NSString stringWithFormat:@"%@.jpeg", [NSDate date]] mimeType:@"image/jpeg"];
    }];

//    if ([[SettingsManager sharedManager] accessToken]) {
////        self.defaultHeaders[@"Authorization"] = [@"Bearer" stringByAppendingFormat:@" %@", @"1bbd13f1-53d0-4b01-81b4-a294243ec4b9"];
//        [request setValue:[@"Bearer" stringByAppendingFormat:@" %@", [[SettingsManager sharedManager] accessToken]] forHTTPHeaderField:@"Authorization"];
//    }
    AFJSONRequestOperation *operation = [[AFJSONRequestOperation alloc] initWithRequest:request];
   
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self requestFinishedLog:operation withReponseObject:responseObject];
        NSError *error = nil;
        NSArray *responseArray = nil;
        if (responseObject) {
            if ([responseObject valueForKeyPath:FIELD_ERRORS]) {
                //				NSNumber * errorCode = [[responseObject valueForKeyPath:FIELD_ERROR] firstObject];
                NSDictionary *errorDic = [[responseObject valueForKeyPath:FIELD_ERRORS] firstObject];
                NSNumber *errorCode = errorDic[@"code"];
                error = [NSError errorWithDomain:API_DOMAIN_ERROR code:errorCode ? [errorCode intValue] : 0 userInfo:errorDic];
            } else {
                responseArray = [responseObject valueForKeyPath:FIELD_RESPONSE];
            }
        }
        if (callback) {
            callback(responseObject, error);
        }
        }                                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self requestFailedLog:error];
        if (callback) {
            callback(nil, error);
        }

    }];
    [operation start];
}

- (void)downloadFileByURL:(NSURL *)url  callback:(void (^)(NSData *data, NSError *error))callback {
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"filename"];
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:path append:NO];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Successfully downloaded file to %@", path);
        if(callback) {
            callback([NSData dataWithContentsOfFile:path], nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(callback) {
            callback(nil, error);
        }
    }];
    [operation start];
}
- (void)verifyUserEmail:(NSString *)email password:(NSString *)password completionHandler:(void (^)(BOOL success, NSError *error))completionHandler {
    NSURL *url = [NSURL URLWithString:@"http://prev.gio.uz/signUp"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCredential:[NSURLCredential credentialWithUser:[@"domain" stringByAppendingString:email]
                                                        password:password persistence:NSURLCredentialPersistenceForSession]];
    
//    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completionHandler) {
            completionHandler(TRUE, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completionHandler) {
            completionHandler(FALSE, error);
        }
    }];
    
    [operation start];
}
/*DLog(@"%@ ", results);
 */

@end
