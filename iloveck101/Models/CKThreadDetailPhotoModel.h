//
//  CKThreadDetailPhotoModel.h
//  iloveck101
//
//  Created by Chong Francis on 13年12月24日.
//  Copyright (c) 2013年 Ignition Soft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWPhotoBrowser.h"

@class CKThreadDetail;

@interface CKThreadDetailPhotoModel : NSObject <MWPhotoBrowserDelegate>

@property (nonatomic, strong) CKThreadDetail* thread;

-(id) initWithThreadDetail:(CKThreadDetail*) thread;

@end
