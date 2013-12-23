//
//  CKThreadSpec.m
//  iloveck101
//
//  Created by Chong Francis on 13年12月23日.
//  Copyright 2013年 Ignition Soft. All rights reserved.
//

#import "Kiwi.h"
#import "CKThread.h"

SPEC_BEGIN(CKThreadSpec)

describe(@"CKThread", ^{
    it(@"should get list of threads, each with title and URL", ^{
        __block BOOL loaded = NO;
        __block NSArray* theThreads = nil;
        [CKThread listThreadWithURL:@"/" block:^(NSArray *threads, NSError *error) {
            theThreads = threads;
            loaded = YES;
        }];
        [[expectFutureValue(theValue(loaded)) shouldEventually] beTrue];
        [[theValue([theThreads isKindOfClass:[NSArray class]]) should] beTrue];
        [theThreads each:^(CKThread* thread) {
            [[thread.title shouldNot] beNil];
            [[thread.url shouldNot] beNil];
        }];
    });
});

SPEC_END
