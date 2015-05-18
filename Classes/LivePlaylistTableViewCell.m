//
//  LivePlaylistTableViewCell.m
//  WXYCapp
//
//  Created by Jake Bromberg on 3/6/12.
//  Copyright (c) 2012 WXYC. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "LivePlaylistTableViewCell.h"
#import "NSObject+KVOBlocks.h"
#import "CALayer+ShadowLayer.h"

@interface LivePlaylistTableViewCell ()

@property (nonatomic, strong) CALayer *shadowLayer;

@end


@interface LivePlaylistTableViewCell ()

@end


@implementation LivePlaylistTableViewCell

+ (float)height
{
	return 44.0f;
}

- (void)awakeFromNib
{
	[super awakeFromNib];
	
	self.clipsToBounds = NO;
	self.layer.masksToBounds = NO;

    self.containerView.layer.borderColor = [UIColor colorWithWhite:.70f alpha:1.f].CGColor;
    self.containerView.layer.borderWidth = 1.f;
    self.containerView.layer.cornerRadius = 5.f;
    self.containerView.layer.masksToBounds = YES;
	
	self.shadowLayer = [CALayer shadowLayerWithFrame:self.bounds];
    [self.contentView.layer insertSublayer:self.shadowLayer atIndex:0];

    __weak __typeof(self) welf = self;
    [self observeKeyPath:@keypath(self.containerView.layer, frame) changeBlock:^(NSDictionary *change) {
        welf.shadowLayer.shadowPath = CGPathCreateWithRoundedRect(welf.containerView.frame, 5.f, 5.f, &CGAffineTransformIdentity);
	}];
}

- (id)copyWithZone:(NSZone *)zone
{
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
    NSArray *nibContents = [nib instantiateWithOwner:nil options:nil];
    LivePlaylistTableViewCell *copy = [nibContents firstObject];
    
    copy.entity = self.entity;
    
    return copy;
}

@end
