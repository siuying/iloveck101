//
//  CKThreadDetails.m
//  iloveck101
//
//  Created by Chong Francis on 13年12月23日.
//  Copyright (c) 2013年 Ignition Soft. All rights reserved.
//

#import "CKThreadDetail.h"
#import "CK101Client.h"
#import "CKThreadDetailScraper.h"

@implementation CKThreadDetail

+(NSURLSessionDataTask*) getThreadDetailWithURL:(NSString*)url
                                          block:(void (^)(CKThreadDetail *threadDetail, NSError *error))block {
    return [[CK101Client sharedClient] GET:url
                                parameters:nil
                                   success:^(NSURLSessionDataTask *task, id responseObject) {
                                       NSData* data = responseObject;
                                       NSString* html = [NSString stringWithUTF8String:[data bytes]];
                                       CKThreadDetailScraper* scraper = [CKThreadDetailScraper scraper];                                       
                                       CKThreadDetail* detail = [scraper scrape:html];
                                       if (detail) {
                                           detail.url = task.originalRequest.URL;
                                           if (block) {
                                               block(detail, nil);
                                           }
                                       } else {
                                           if (scraper.error) {
                                               block(nil, scraper.error);
                                           } else {
                                               block(nil, [NSError errorWithDomain:@"CKThreadDetail"
                                                                              code:1 userInfo:@{@"message": @"unknown parse error"}]);
                                           }
                                       }
                                   }
                                   failure:^(NSURLSessionDataTask *task, NSError *error) {
                                       if (block) {
                                           block(nil, error);
                                       }
                                   }];
}

@end
