//
//  CKThreadCell.m
//  iloveck101
//
//  Created by Chong Francis on 13年12月24日.
//  Copyright (c) 2013年 Ignition Soft. All rights reserved.
//

#import "CKThreadCell.h"
#import "CKThread.h"

@implementation CKThreadCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.textColor = [UIColor blackColor];
        self.textLabel.font = [UIFont systemFontOfSize:16.0f];
        self.textLabel.numberOfLines = 2;
        self.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    return self;
}

-(void) setThread:(CKThread*)thread
{
    self.textLabel.text = thread.title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
