//
//  LivePlaylistController.m
//  WXYCapp
//
//  Created by Jake on 10/13/10.
//  Copyright 2010 WXYC. All rights reserved.
//

#import <RestKit/RestKit.h>
#import <CoreData/CoreData.h>
#import "PlaylistController.h"
#import "Playcut.h"
#import "Talkset.h"
#import "Breakpoint.h"
#import "PlaylistMapping.h"
#import "NSString+Additions.h"

NSString* const LPStatusChangedNotification = @"LPStatusChangedNotification";

@interface PlaylistController()

@property (nonatomic, strong) PlaylistMapping* playlistMapping;
@property (nonatomic, readonly) NSDictionary *parameters;
@property (nonatomic, readonly) NSString *path;

@end

@implementation PlaylistController

- (NSString *)path
{
	return @"playlists/recentEntries";
}

- (NSDictionary *)parameters
{
	if (self.playlist.count)
	{
		return @{
			@"v" : @"2",
			@"direction" : @"next",
			@"referenceID" : [[self.playlist lastObject] valueForKeyPath:@"chronOrderID"] ?: @""
		};
	}
	else
	{
		return @{
			@"v" : @"2",
			@"n" : @"100",
		};
	}
}

- (void)setState:(PlaylistControllerState)state
{
	if (_state != state)
	{
		_state = state;
		[[NSNotificationCenter defaultCenter] postNotificationName:LPStatusChangedNotification object:self];
	}
}

#pragma mark JSON Business

- (void)fetchPlaylist
{
	[RKObjectManager.sharedManager getObjectsAtPath:self.path parameters:self.parameters success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
	 {
		 NSComparisonResult (^comparator)(id a, id b) = ^NSComparisonResult(id a, id b){
			 return [[b valueForKey:@"chronOrderID"] compare:[a valueForKey:@"chronOrderID"]];
		 };
		 
		 NSArray *newEntries = [[mappingResult array] sortedArrayUsingComparator:comparator];
		 _playlist = [[_playlist arrayByAddingObjectsFromArray:newEntries] sortedArrayUsingComparator:comparator];
		 
		 self.state = LP_DONE;
	 } failure:^(RKObjectRequestOperation *operation, NSError *error) {

	 }];
}

#pragma mark constructors

- (id)initWithBaseURL:(NSString*)url
{
	self = [super init];
	
	if (self)
		_playlistMapping = [[PlaylistMapping alloc] init];

	return self;
}


@end
