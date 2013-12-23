//
//  CK101Client.m
//  iloveck101
//
//  Created by Chong Francis on 13年12月23日.
//  Copyright (c) 2013年 Ignition Soft. All rights reserved.
//

#import "CK101Client.h"

static NSString * const AFCK101ClientBaseURLString = @"http://ck101.com/";
static NSString * const AFCK101ClientUserAgent = @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.57 Safari/537.36'}";

@implementation CK101Client

+ (instancetype)sharedClient {
    static CK101Client* _sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[CK101Client alloc] initWithBaseURL:[NSURL URLWithString:AFCK101ClientBaseURLString]];
        [_sharedClient setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey]];
        [_sharedClient setResponseSerializer:[AFHTTPResponseSerializer serializer]];

        AFHTTPRequestSerializer* reqSerializer = [AFHTTPRequestSerializer serializer];
        [reqSerializer setValue:AFCK101ClientUserAgent forHTTPHeaderField:@"User-Agent"];
        [_sharedClient setRequestSerializer:reqSerializer];
    });
    return _sharedClient;
}

@end
