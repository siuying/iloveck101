//
//  CKThreadCell.h
//  iloveck101
//
//  Created by Chong Francis on 13年12月24日.
//  Copyright (c) 2013年 Ignition Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CKThread;

@interface CKThreadCell : UITableViewCell

@property (nonatomic, strong) CKThread* thread;

-(void) setThread:(CKThread*)thread;

@end
