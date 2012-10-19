//
//  LivePlaylistController.m
//  WXYCapp
//
//  Created by Jake on 10/13/10.
//  Copyright 2010 WXYC. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "PlaylistController.h"
#import "Playcut.h"
#import "Talkset.h"
#import "Breakpoint.h"
#import "PlaylistMapping.h"
//@class PlaylistMapping;

NSString* const LPStatusChangedNotification = @"LPStatusChangedNotification";
//RKObjectManager* objectManager;

@interface PlaylistController() {
	PlaylistMapping* playlistMapping;
}

@end

@implementation PlaylistController

@synthesize playlist;
@synthesize state;
//@synthesize numNewEntries;


- (void)setState:(PlaylistControllerState)aStatus {
	if (state != aStatus) {
		state = aStatus;
		[[NSNotificationCenter defaultCenter] postNotificationName:LPStatusChangedNotification object:self];
	}
}

#pragma mark JSON Business

- (void)fetchPlaylist {
	[playlistMapping.objectManager loadObjectsAtResourcePath:@"/new%20schema.json" delegate:self];
}

- (void)updatePlaylist {
	[self fetchPlaylist];
}

#pragma mark RestKit business

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects {
	playlist = [[objects sortedArrayUsingComparator:^(id a, id b) {
		return [[a valueForKey:@"chronOrderID"] compare:[b valueForKey:@"chronOrderID"]];
	}] copy];
	
	[self setState:LP_DONE];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
	NSLog(@"Encountered an error: %@", error);
}


#pragma mark constructors

-(PlaylistController*)initWithBaseURL:(NSString*)url {
//	self = [super init];
	playlistMapping = [[PlaylistMapping alloc] init];

	return self;
}


@end
