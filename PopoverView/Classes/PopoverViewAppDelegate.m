//
//  PopoverViewAppDelegate.m
//  PopoverView
//
//  Created by Andreas Katzian on 17.05.10.
//  Copyright Blackwhale GmbH 2010. All rights reserved.
//

#import "PopoverViewAppDelegate.h"
#import "MainViewController.h"

@implementation PopoverViewAppDelegate

@synthesize window;
@synthesize viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];

	return YES;
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
