//
//  CKThreadDetailScraper.h
//  iloveck101
//
//  Created by Chong Francis on 13年12月24日.
//  Copyright (c) 2013年 Ignition Soft. All rights reserved.
//

#import "IGScraper.h"

@class CKThreadDetail;

/**
 Parse a ck101 thread, and return a CKThreadDetail object.
 */
@interface CKThreadDetailScraper : IGScraper

+(CKThreadDetailScraper*) scraper;

-(CKThreadDetail*) scrape:(NSString*)html;

@end
