//
//  CKThreadDetailSpec.m
//  iloveck101
//
//  Created by Chong Francis on 13年12月23日.
//  Copyright 2013年 Ignition Soft. All rights reserved.
//

#import "Kiwi.h"
#import "CKThreadDetail.h"

SPEC_BEGIN(CKThreadDetailSpec)

describe(@"CKThreadDetail", ^{
    it(@"should get thread detail", ^{
        __block BOOL loaded = NO;
        __block CKThreadDetail* theThreadDetail = nil;
        [CKThreadDetail getThreadDetailWithURL:@"http://ck101.com/thread-2890433-1-1.html" block:^(CKThreadDetail *threadDetail, NSError *error) {
            loaded = YES;
            theThreadDetail = threadDetail;
        }];
        [[expectFutureValue(theValue(loaded)) shouldEventually] beTrue];
        [[theValue([theThreadDetail isKindOfClass:[CKThreadDetail class]]) should] beTrue];
        [[[theThreadDetail title] shouldNot] beNil];
        [theThreadDetail.imageUrls each:^(NSString* url) {
            [[url shouldNot] beNil];
        }];
    });
});

SPEC_END
