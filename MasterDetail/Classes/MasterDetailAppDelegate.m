//
//  MasterDetailAppDelegate.m
//  MasterDetail
//
//  Created by Andreas Katzian on 15.05.10.
//  Copyright Blackwhale GmbH 2010. All rights reserved.
//

#import "MasterDetailAppDelegate.h"
#import "MasterViewController.h"
#import "DetailViewController.h"
#import "SplitViewDelegate.h"

@implementation MasterDetailAppDelegate

@synthesize window;
@synthesize viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
	//create the master view
	MasterViewController *masterView = [[MasterViewController alloc]
										initWithNibName:@"Master"
										bundle:[NSBundle mainBundle]];
	
	//create the details view
	DetailViewController *detailView = [[DetailViewController alloc]
										  initWithNibName:@"Detail"
										  bundle:[NSBundle mainBundle]];
	
	//create the custom split view controller
	//here you can control if you want to keep the master
	//view in portrait mode or not
	self.viewController = [[CustomUISplitViewController alloc] initWithMasterInPortraitMode: NO];
	
	//set the view controllers array
	viewController.viewControllers = [NSArray arrayWithObjects:masterView, detailView, nil];
	
	//create and set the split view delegate
	SplitViewDelegate* splitViewDelegate = [[SplitViewDelegate alloc] init];
	splitViewDelegate.detailController = detailView;
	viewController.delegate = splitViewDelegate;
	
	
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
	
	[masterView release];
	[detailView release];

	return YES;
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
