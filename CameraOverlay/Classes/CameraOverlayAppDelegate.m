//
//  CameraOverlayAppDelegate.m
//  CameraOverlay
//
//  Created by Andreas Katzian on 12.05.10.
//  Copyright Blackwhale GmbH 2010. All rights reserved.
//

#import "CameraOverlayAppDelegate.h"

@implementation CameraOverlayAppDelegate

@synthesize window;
@synthesize viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    

    // Override point for customization after application launch
	
	[window addSubview:viewController.view];
    [window makeKeyAndVisible];
	
	return YES;
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
