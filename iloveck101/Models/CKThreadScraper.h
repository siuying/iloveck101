//
//  CKThreadScraper.h
//  iloveck101
//
//  Created by Chong Francis on 13年12月24日.
//  Copyright (c) 2013年 Ignition Soft. All rights reserved.
//

#import "IGScraper.h"

/**
 Parse a ck101 page, and return list of threads.
 */
@interface CKThreadScraper : IGScraper

+(CKThreadScraper*) scraperWithURL:(NSURL*)url;

-(NSArray*) scrape:(NSString*)html;

@end
