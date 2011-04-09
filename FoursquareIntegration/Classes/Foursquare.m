//
//  Foursquare.m
//  FoursquareIntegration
//
//  Created by Andreas Katzian on 29.09.10.
//  Copyright 2010 Blackwhale GmbH. All rights reserved.
//

#import "Foursquare.h"
#import "NSUserDefaults+Standard.h"
#import "NSString+SBJSON.h"
#import "NSString+Utilities.h"

#define XAUTH_ACCESS_TOKEN_URL	@"http://foursquare.com/oauth/access_token"	// URL for request access token
#define VENUES_URL				@"http://api.foursquare.com/v1/venues"		// URL to search venues
#define CHECKIN_URL				@"http://api.foursquare.com/v1/checkin"		// URL to checkin at venue

#define SERVICE_FORMAT			@".json"			// Service format for response

#define OAUTHTOKEN_PROVIDER		@"foursquare"
#define OAUTHTOKEN_PREFIX		@"token"

#define HTTP_POST_METHOD		@"POST"
#define URL_REQUEST_TIMEOUT		30


// Static shared instance
static Foursquare* sharedInstance_;


#pragma mark -
#pragma mark Anonyms category

// Anonymus category for some private methods
@interface Foursquare()

// Set consumer key and secret
- (void) setConsumerKey:(NSString *)key secret:(NSString *)secret;

// Request the access token
- (void) requestXAuthAccessTokenForUsername:(NSString *)username password:(NSString *)password;

// Restore the last session 
- (void) restoreSession;

// Get the basic URL request for url location
- (NSMutableURLRequest*) requestForUrl:(NSString*) url method:(NSString*) method params:(NSMutableDictionary*) params;

@end


#pragma mark -
#pragma mark Class implementation


@implementation Foursquare

@synthesize consumerKey;
@synthesize consumerSecret;
@synthesize oauthToken;
@synthesize rootController;


#pragma mark -
#pragma mark Custom property methods

- (BOOL) isActive
{
	return self.oauthToken != nil && ![oauthToken hasExpired];
}


#pragma mark -
#pragma mark Foursquare connection methods


- (void)setConsumerKey:(NSString *)key secret:(NSString *)secret
{
	self.consumerKey	= key;
	self.consumerSecret = secret;
}


- (void)requestXAuthAccessTokenForUsername:(NSString *)username 
								  password:(NSString *)password
{
	//clear old token
	self.oauthToken = nil;
	
	OAConsumer *consumer = [[[OAConsumer alloc] initWithKey:self.consumerKey secret:self.consumerSecret] autorelease];

	//setup oauth request
	OAMutableURLRequest *request = [[OAMutableURLRequest alloc] initWithURL:[NSURL URLWithString:XAUTH_ACCESS_TOKEN_URL]
																   consumer:consumer
																	  token:nil		// xAuth needs no request token
																	  realm:nil		// our service provider doesn't specify a realm
														  signatureProvider:nil];	// use the default method, HMAC-SHA1
	
	[request setHTTPMethod:HTTP_POST_METHOD];
	
	[request setParameters:[NSArray arrayWithObjects:
							[OARequestParameter requestParameter:@"x_auth_mode" value:@"client_auth"],
							[OARequestParameter requestParameter:@"x_auth_username" value:username],
							[OARequestParameter requestParameter:@"x_auth_password" value:password],
							nil]];	
	
	
	// alway prepare the OA request
	[request prepare];
	
	//execute request
	NSHTTPURLResponse *response;
	NSError *error;
	NSData *respData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	
	//receive oauth token
	if(respData != nil && response != NULL && [response statusCode] >= 200 && [response statusCode] < 300)
	{
		NSLog(@"Foursquare: received oAuth Token for %@", username);

		//get response data
		NSString *text = [[NSString alloc] initWithData:respData encoding:NSUTF8StringEncoding];
		NSLog(@"Foursquare: received %@", text);
		
		//parse token
		OAToken *token = [[OAToken alloc] initWithHTTPResponseBody:text];
		[text release];
		
		if([token isValid]) 
		{
			//store token within user defaults
			self.oauthToken = token;
			[oauthToken storeInUserDefaultsWithServiceProviderName:OAUTHTOKEN_PROVIDER prefix:OAUTHTOKEN_PREFIX];
		}
		else
			NSLog(@"Foursquare: oAuth Token is not valid!");
		
		[token release];
	}
	else
	{
		NSLog(@"Foursquare: could not receive a valid oAuth Token for %@", username);
	}
}

- (BOOL) loginWithUsername:(NSString*) u password:(NSString*) pwd
{
	// Request oauth token for the user
	[self requestXAuthAccessTokenForUsername:u password:pwd];
	
	// Return YES if connection is active
	return [self isActive];
}


- (void) login
{
	// A root controller is necessary
	if(rootController != nil)
	{
		// Initiate foursquare connect controller and show it
		FoursquareConnectController *connectController = [[FoursquareConnectController alloc] initWithNibName:@"FoursquareConnectView" 
																								 bundle:[NSBundle mainBundle]];
		connectController.delegate = self;
		[rootController presentModalViewController:connectController animated:NO];
		[connectController release];
	}
	else
		NSLog(@"No root view controller provided for Twitter connect.");
}

- (void) logout
{
	// Remove saved data from user settings
	[OAToken removeFromUserDefaultsWithServiceProviderName:OAUTHTOKEN_PROVIDER prefix:OAUTHTOKEN_PREFIX];
	self.oauthToken = nil;
}

- (void) restoreSession
{
	self.oauthToken = [[[OAToken alloc] initWithUserDefaultsUsingServiceProviderName:OAUTHTOKEN_PROVIDER 
																			  prefix:OAUTHTOKEN_PREFIX] autorelease];
}


#pragma mark -
#pragma mark TwitterConnectControllerDelegate methods

- (void) foursquareConnectController:(FoursquareConnectController*) foursquareConnectController 
				 connectWithUsername:(NSString*) u 
							password:(NSString*) pwd
{
	if([self loginWithUsername:u password:pwd] == YES)
	{
		[foursquareConnectController dismissModalViewControllerAnimated:NO];
	}
	else
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Foursquare Connect" 
														message:@"It was not possible to connect to your foursquare account. "
																 "Please review your login details and try again." 
													   delegate:nil 
											  cancelButtonTitle:@"OK" 
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
}


- (void) didCloseFoursquareConnectController:(FoursquareConnectController*) foursquareConnectController
{
	[foursquareConnectController dismissModalViewControllerAnimated:NO];
}


#pragma mark -
#pragma mark Foursquare service methods

/**
 * API DOCUMENTATION http://groups.google.com/group/foursquare-api/web/api-documentation
 */

/**
 URL: http://api.foursquare.com/v1/venues
 Formats: XML, JSON
 HTTP Method(s): GET
 Requires Authentication: No, but recommended
 Parameters:
 
 * geolat - latitude (required)
 * geolong - longitude (required)
 * l - limit of results (optional, default 10, maximum 50)
 * q - keyword search (optional) 
*/ 

- (NSArray*) findLocationsNearbyLatitude:(double) latitude longitude:(double)longitude limit:(int) limit searchterm:(NSString*) searchterm
{
	NSArray *venues = nil;

	// Build GET URL
	NSMutableString *venuesURL = [[NSMutableString alloc] initWithFormat:@"http://api.foursquare.com/v1/venues%@?", SERVICE_FORMAT];
	[venuesURL appendFormat:@"geolat=%f&geolong=%f", latitude, longitude];
	[venuesURL appendFormat:@"&l=%d", limit];
	if(searchterm != nil) [venuesURL appendFormat:@"&q=%@", searchterm];

	NSURL *url = [[NSURL alloc] initWithString:venuesURL];
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
	
	// Execute URL and read response
	NSHTTPURLResponse *httpResponse;
	NSData *resp = [NSURLConnection sendSynchronousRequest:request returningResponse:&httpResponse error:NULL];
	
	if(resp != nil && httpResponse != NULL && [httpResponse statusCode] >= 200 && [httpResponse statusCode] < 300)
	{
		NSString *bodyText = [[NSString alloc] initWithData:resp encoding:NSUTF8StringEncoding];
		NSLog(@"Foursquare: locations found: %@", bodyText);
		
		//parse JSON data
		id parsedData = [bodyText JSONValue];
		[bodyText release];
		
		if(parsedData != nil && [parsedData isKindOfClass:[NSDictionary class]])
		{
			//Dictionary should contain:
			// key: "groups" -> Array of Dictionaries
			//      -> key: "venues" -> Array of Dictionaries
			//              -> key: "id" -> string
			//              -> key: "name" -> string
			//              -> key: "primarycategory" -> Dictionary
			//						-> key: "nodename" -> string
			//						-> key: "iconurl" -> string
			//              -> key: "address" -> string
			//              -> key: "city" -> string
			//              -> key: "state" -> string
			//              -> key: "zip" -> string
			//              -> key: "geolat" -> double
			//              -> key: "geolong" -> double
			//              -> key: "distance" -> double
			
			//get all groups
			NSArray *groups = [(NSDictionary*)parsedData objectForKey:@"groups"];
			if(groups != nil && [groups count] > 0)
			{
				//get only the first array item and its venues
				NSDictionary *firstGroup = [groups objectAtIndex:0];
				venues = [firstGroup objectForKey:@"venues"];
			}
			
		}
		else
		{
			NSLog(@"Foursquare: couldn't parse response %@ as a dictionary", bodyText);
		}
	}
	else
	{
		NSLog(@"Foursquare: couldn't receive any venues from %@", venuesURL);
	}
	
	//release objects
	[venuesURL release];
	[url release];
	[request release];
	
	
	return venues;
}



/**
 URL: http://api.foursquare.com/v1/checkin
 Formats: XML, JSON
 HTTP Method(s): POST
 Requires Authentication: Yes
 Parameters:
 
 * vid - (optional, not necessary if you are 'shouting' or have a venue name). ID of the venue where you want to check-in
 * venue - (optional, not necessary if you are 'shouting' or have a vid) if you don't have a venue ID or would rather prefer a 'venueless' checkin, pass the venue name as a string using this parameter. it will become an 'orphan' (no address or venueid but with geolat, geolong)
 * shout - (optional) a message about your check-in. the maximum length of this field is 140 characters
 * private - (optional). "1" means "don't show your friends". "0" means "show everyone"
 * twitter - (optional, defaults to the user's setting). "1" means "send to Twitter". "0" means "don't send to Twitter"
 * facebook - (optional, defaults to the user's setting). "1" means "send to Facebook". "0" means "don't send to Facebook"
 * geolat - (optional, but recommended)
 * geolong - (optional, but recommended)
*/

- (NSString*) checkinAtVenue:(NSString*) venueId latitude:(double) latitude longitude:(double)longitude
{
	NSString *outMessage = nil;
	
	//Build checkin url
	NSString *url = [NSString stringWithFormat:@"http://api.foursquare.com/v1/checkin%@", SERVICE_FORMAT];
	
	//Set parameters
	NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
	[params setObject:venueId forKey:@"vid"];
	[params setObject:[NSString stringWithFormat:@"%f",latitude] forKey:@"geolat"];
	[params setObject:[NSString stringWithFormat:@"%f",longitude] forKey:@"geolong"];
	
	//Create and execute checkin request
	NSMutableURLRequest *request = [self requestForUrl:url method:HTTP_POST_METHOD params:params];
	NSHTTPURLResponse *httpResponse;
	NSData *resp = [NSURLConnection sendSynchronousRequest:request returningResponse:&httpResponse error:NULL];
	if(httpResponse && [httpResponse statusCode] >= 200 && [httpResponse statusCode] < 300)
	{
		outMessage = @"OK";

		NSString *bodyText = [[NSString alloc] initWithData:resp encoding:NSUTF8StringEncoding];
		NSLog(@"Foursquare: checked in and got %@", bodyText);
		id parsedDataObject = [bodyText JSONValue];
		[bodyText release];

		if(parsedDataObject != nil && [parsedDataObject isKindOfClass:[NSDictionary class]])
		{
			//Dictionary should contain:
			// key: "checkin" -> Dictionary
			//      -> key: "message" -> string
			//      -> key: "id" -> string
			//      -> key: "created" -> string
			//      -> key: "venue" -> Dictionary
			//              -> venue details
			//      -> key: "mayor" -> Dictionary
			//              -> mayor details
			//      -> key: "badges" -> Dictionary
			//              -> badges details
			//      -> key: "scoring" -> Dictionary
			//              -> scoring details
			//      -> key: "specials" -> Dictionary
			//              -> specials details
			NSDictionary *checkin = [(NSDictionary*)parsedDataObject objectForKey:@"checkin"];
			outMessage = [checkin objectForKey:@"message"];
		}			
	}
	
	NSString *bodyText = [[NSString alloc] initWithData:resp encoding:NSUTF8StringEncoding];

	NSLog(@"Foursquare: checkin got response: %@", bodyText);
	
	[params release];
	
	//Return the foursquare checkin message
	return outMessage;
}



#pragma mark -
#pragma mark Connection helper methods

// Construct an NSMutableURLRequest for the URL and set appropriate request method.
- (NSMutableURLRequest*) requestForUrl:(NSString*) urlstring method:(NSString*) method params:(NSMutableDictionary*) params
{
	// Prepare consumer and url
	OAConsumer *consumer = [[OAConsumer alloc] initWithKey:consumerKey secret:consumerSecret];
	NSURL *url = [[NSURL alloc] initWithString:urlstring];
	
	// Add params to HTTP body
	NSMutableString *body = [[NSMutableString alloc] initWithString:@""];
	NSArray *keys = [params allKeys];
	for(int i=0; i<[keys count]; i++)
	{
		NSString *key = [keys objectAtIndex:i];
		NSString *param = [params objectForKey:key];
		[body appendString:key];
		[body appendString:@"="];
		[body appendString:[param encodeString]];
		
		if(i < [keys count]-1)
			[body appendString:@"&"];
	}
	
	// Setup the request
	OAMutableURLRequest *theRequest = nil;
	theRequest = [[[OAMutableURLRequest alloc] initWithURL:url
												  consumer:consumer
													 token:self.oauthToken
													 realm:nil
										 signatureProvider:nil] autorelease];
	
	[theRequest setCachePolicy:NSURLRequestReloadIgnoringCacheData];
	[theRequest setTimeoutInterval:URL_REQUEST_TIMEOUT];
	[theRequest setHTTPMethod:method];
    [theRequest setHTTPShouldHandleCookies:NO];
	[theRequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
	[theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	[theRequest prepare];
	
	[url release];
	[consumer release];
	
	return theRequest;
}





#pragma mark -
#pragma mark Singelton methods

- (id) init
{
	self = [super init];
	
	//set consumer key and secret
	[self setConsumerKey:[NSUserDefaults stringForKey:@"foursquare.consumer.key"]
				  secret:[NSUserDefaults stringForKey:@"foursquare.consumer.secret"]];
	
	//try to restore session
	[self restoreSession];
	
	return self;
}


// Get the shared instance of this singelton.
+ (Foursquare*) sharedInstance
{
	@synchronized(self)
	{
		[[self alloc] init];
	}
	
	return sharedInstance_;
}

// Overwrite allocWithZone to be sure to 
// allocate memory only once.
+ (id)allocWithZone:(NSZone *)zone
{
	@synchronized(self) {
		if (sharedInstance_ == nil) {
			sharedInstance_ = [super allocWithZone:zone];
			return sharedInstance_;
		}
	}
	
	return nil;
}

// Nobody should be able to copy 
// the shared instance.
- (id)copyWithZone:(NSZone *)zone
{
	return self;
}

// Retaining the shared instance should not
// effect the retain count.
- (id)retain
{
	return self;
}

// Releasing the shared instance should not
// effect the retain count.
- (void)release
{
}

// Auto-releasing the shared instance should not
// effect the retain count.
- (id)autorelease
{
	return self;
}

// Retain count should not go to zero.
- (NSUInteger)retainCount
{
	return NSUIntegerMax;
}

@end
