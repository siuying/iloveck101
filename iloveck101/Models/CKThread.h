//
//  CKThread.h
//  iloveck101
//
//  Created by Chong Francis on 13年12月23日.
//  Copyright (c) 2013年 Ignition Soft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CKThread : NSObject

@property (nonatomic, copy) NSString* title;
@property (nonatomic, strong) NSURL* url;

/**
 List threads in a ck101 URL
 */
+(NSURLSessionDataTask*) listThreadWithURL:(NSString*)url
                                     block:(void (^)(NSArray *threads, NSError *error))block;

@end
