//
//  CKThreadDetailScraper.m
//  iloveck101
//
//  Created by Chong Francis on 13年12月24日.
//  Copyright (c) 2013年 Ignition Soft. All rights reserved.
//

#import "CKThreadDetailScraper.h"
#import "IGHTMLQuery.h"
#import "CKThreadDetail.h"

@implementation CKThreadDetailScraper

+(CKThreadDetailScraper*) scraper {
    return [[self class] scraperWithBlock:^id(IGXMLNode *node) {
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
}

@end
