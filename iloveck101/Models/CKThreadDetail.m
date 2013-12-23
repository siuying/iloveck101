//
//  CKThreadDetails.m
//  iloveck101
//
//  Created by Chong Francis on 13年12月23日.
//  Copyright (c) 2013年 Ignition Soft. All rights reserved.
//

#import "CKThreadDetail.h"
#import "CK101Client.h"
#import "IGScraper.h"
#import "IGHTMLQuery.h"

@implementation CKThreadDetail

+(NSURLSessionDataTask*) getThreadDetailWithURL:(NSString*)url
                                          block:(void (^)(CKThreadDetail *threadDetail, NSError *error))block {
    return [[CK101Client sharedClient] GET:url
                                parameters:nil
                                   success:^(NSURLSessionDataTask *task, id responseObject) {
                                       NSData* data = responseObject;
                                       NSString* html = [NSString stringWithUTF8String:[data bytes]];
                                       IGScraper* scraper = [IGScraper scraperWithBlock:^id(IGXMLNode *node) {
                                           NSString* title = [[[node queryWithXPath:@"//title"] firstObject] text];
                                           NSArray* imagesUrl = [[[[node queryWithXPath:@"//div[@id='postlist']//img"] allObjects] select:^BOOL(IGXMLNode* image) {
                                               return image[@"src"] != nil;
                                           }] map:^id(IGXMLNode* image) {
                                               return image[@"src"];
                                           }];
                                           CKThreadDetail* detail = [[CKThreadDetail alloc] init];
                                           detail.title = title;
                                           detail.imageUrls = imagesUrl;
                                           return detail;
                                       }];
                                       
                                       CKThreadDetail* detail = [scraper scrape:html];
                                       if (detail) {
                                           detail.url = task.originalRequest.URL;
                                           if (block) {
                                               block(detail, nil);
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
