//
//  CKThread.m
//  iloveck101
//
//  Created by Chong Francis on 13年12月23日.
//  Copyright (c) 2013年 Ignition Soft. All rights reserved.
//

#import "CKThread.h"
#import "CK101Client.h"
#import "IGScraper.h"
#import "IGHTMLQuery.h"

@implementation CKThread

-(NSString*) description {
    return [NSString stringWithFormat:@"<CKThread title=%@ url=%@>", self.title, self.url];
}

-(BOOL) isEqual:(id)object {
    if ([object class] == [self class]) {
        CKThread* anotherThread = object;
        return [anotherThread.url isEqual:self.url];
    }
    return [super isEqual:object];
}

-(NSUInteger) hash {
    return self.url.hash;
}

+(NSURLSessionDataTask*) listThreadWithURL:(NSString*)url
                                     block:(void (^)(NSArray *posts, NSError *error))block {
    return [[CK101Client sharedClient] GET:url
                                parameters:nil
                                   success:^(NSURLSessionDataTask *task, id responseObject) {
                                       NSData* data = responseObject;
                                       NSString* html = [NSString stringWithUTF8String:[data bytes]];
                                       IGScraper* scraper = [IGScraper scraperWithBlock:^id(IGXMLNode *node) {
                                           NSArray* links = [[node queryWithXPath:@"//a"] allObjects];
                                           NSArray* threads = [[links select:^BOOL(IGXMLNode* link) {
                                               NSString* href = link[@"href"];
                                               NSString* title = link[@"title"];
                                               return href && title && title.length > 0 && [href isMatch:RX(@"thread-(\\d+)")];
                                           }] map:^id(IGXMLNode* link) {
                                               CKThread* thread = [[CKThread alloc] init];
                                               thread.url = [NSURL URLWithString:link[@"href"] relativeToURL:task.originalRequest.URL];
                                               thread.title = link[@"title"];
                                               return thread;
                                           }];
                                           NSArray* uniqueThreads = [[NSOrderedSet orderedSetWithArray:threads] array];
                                           return uniqueThreads;
                                       }];

                                       NSArray* threadLinks = [scraper scrape:html];
                                       if (block) {
                                           block(threadLinks, nil);
                                       }
                                   }
                                   failure:^(NSURLSessionDataTask *task, NSError *error) {
                                       if (block) {
                                           block(@[], error);
                                       }
                                   }];
}

@end
