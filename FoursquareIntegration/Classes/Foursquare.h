//
//  Foursquare.h
//  FoursquareIntegration
//
//  Created by Andreas Katzian on 29.09.10.
//  Copyright 2010 Blackwhale GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OAuthConsumer.h"
#import "FoursquareConnectController.h"


@interface Foursquare : NSObject <FoursquareConnectControllerDelegate> {

	NSString *consumerKey;
	NSString *consumerSecret;
	
	OAToken *oauthToken;
	
	UIViewController *rootController;
	
}

@property(nonatomic,retain) NSString *consumerKey;
@property(nonatomic,retain) NSString *consumerSecret;

@property(nonatomic,retain) OAToken *oauthToken;

@property(nonatomic,assign) UIViewController *rootController;

@property(readonly, getter=isActive) BOOL active;

+ (Foursquare*) sharedInstance;

// Methods to login into and logout of foursquare
- (void) login;
- (void) logout;

// Methods to find nearby locations
- (NSArray*) findLocationsNearbyLatitude:(double) latitude longitude:(double)longitude limit:(int) limit searchterm:(NSString*) searchterm;

// Method to checkin a user at given venue
- (NSString*) checkinAtVenue:(NSString*) venueId latitude:(double) latitude longitude:(double)longitude;


@end
