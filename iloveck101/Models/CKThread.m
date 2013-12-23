//
//  CKThread.m
//  iloveck101
//
//  Created by Chong Francis on 13年12月23日.
//  Copyright (c) 2013年 Ignition Soft. All rights reserved.
//

#import "CKThread.h"
#import "CK101Client.h"
#import "CKThreadScraper.h"
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
                                       CKThreadScraper* scraper = [CKThreadScraper scraperWithURL:task.originalRequest.URL];
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
