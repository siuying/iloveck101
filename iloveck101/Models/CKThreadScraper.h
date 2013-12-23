//
//  CKThreadScraper.h
//  iloveck101
//
//  Created by Chong Francis on 13年12月24日.
//  Copyright (c) 2013年 Ignition Soft. All rights reserved.
//

#import "IGScraper.h"

@interface CKThreadScraper : IGScraper

+(CKThreadScraper*) scraperWithURL:(NSURL*)url;

@end
