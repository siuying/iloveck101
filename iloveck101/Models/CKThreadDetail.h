//
//  CKThreadDetails.h
//  iloveck101
//
//  Created by Chong Francis on 13年12月23日.
//  Copyright (c) 2013年 Ignition Soft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CKThreadDetail : NSObject

@property (nonatomic, copy) NSString* title;
@property (nonatomic, strong) NSURL* url;
@property (nonatomic, strong) NSArray* imageUrls;

/**
 Get a thread detail in a ck101 thread URL
 */
+(NSURLSessionDataTask*) getThreadDetailWithURL:(NSString*)url
                                          block:(void (^)(CKThreadDetail *threadDetail, NSError *error))block;

@end
