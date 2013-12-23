//
//  CKThreadDetailPhotoModel.m
//  iloveck101
//
//  Created by Chong Francis on 13年12月24日.
//  Copyright (c) 2013年 Ignition Soft. All rights reserved.
//

#import "CKThreadDetailPhotoModel.h"
#import "CKThreadDetail.h"

@interface CKThreadDetailPhotoModel()
@property (nonatomic, strong) NSArray* photos;
@end

@implementation CKThreadDetailPhotoModel

-(id) initWithThreadDetail:(CKThreadDetail*) thread {
    self = [super init];
    if (self) {
        self.thread = thread;
        self.photos = [thread.imageUrls map:^id(NSString* url) {
            return [MWPhoto photoWithURL:[NSURL URLWithString:url]];
        }];
    }
    return self;
}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count)
        return [self.photos objectAtIndex:index];
    return nil;
}

@end
