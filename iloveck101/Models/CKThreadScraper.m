//
//  CKThreadScraper.m
//  iloveck101
//
//  Created by Chong Francis on 13年12月24日.
//  Copyright (c) 2013年 Ignition Soft. All rights reserved.
//

#import "CKThreadScraper.h"
#import "IGHTMLQuery.h"
#import "CKThread.h"

@implementation CKThreadScraper

+(CKThreadScraper*) scraperWithURL:(NSURL*)url {
    return [[self class] scraperWithBlock:^id(IGXMLNode *node) {
        NSArray* links = [[node queryWithXPath:@"//a"] allObjects];
        NSArray* threads = [[links select:^BOOL(IGXMLNode* link) {
            NSString* href = link[@"href"];
            NSString* title = link[@"title"];
            return href && title && title.length > 0 && [href isMatch:RX(@"thread-(\\d+)")];
        }] map:^id(IGXMLNode* link) {
            CKThread* thread = [[CKThread alloc] init];
            thread.url = [NSURL URLWithString:link[@"href"] relativeToURL:url];
            thread.title = link[@"title"];
            return thread;
        }];
        NSArray* uniqueThreads = [[NSOrderedSet orderedSetWithArray:threads] array];
        return uniqueThreads;
    }];
}

-(NSArray*) scrape:(NSString*)html {
    return [super scrape:html];
}

@end
