//
//  Created by Jake Bromberg.
//  Copyright WXYC 2009-10. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <AudioToolbox/AudioToolbox.h>
#import <CoreData/CoreData.h>
//#import "SA_OAuthTwitterEngine.h"
#import <RestKit/RestKit.h>

@class PlaylistController;

@interface WXYCAppDelegate : NSObject <UIApplicationDelegate,NSFetchedResultsControllerDelegate> {
    UIWindow *window;
	IBOutlet UITabBarController *rootController;
	PlaylistController *livePlaylistCtrlr;
	
	NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
	
//	SA_OAuthTwitterEngine *twitterEngine;
	NSMutableData *responseData;
//	OAToken *token;
	
	UIWebView *twitterPINResponse;
	NSURLConnection *connection1;
}

@property (nonatomic, retain) PlaylistController *livePlaylistCtrlr;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *rootController;

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, readonly) NSString *applicationDocumentsDirectory;

@end