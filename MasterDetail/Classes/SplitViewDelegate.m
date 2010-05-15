//
//  SplitViewDelegate.m
//  MasterDetail
//
//  Created by Andreas Katzian on 15.05.10.
//  Copyright 2010 Blackwhale GmbH. All rights reserved.
//

#import "SplitViewDelegate.h"
#import "CustomUISplitViewController.h"

@implementation SplitViewDelegate

@synthesize detailController, toolBar;

// the master view controller will be displayed in a popover
- (void)splitViewController:(CustomUISplitViewController*)svc 
		  popoverController:(UIPopoverController*)pc 
  willPresentViewController:(UIViewController *)aViewController {

	//empty for the moment
	
}


//the master view controller will be hidden
- (void)splitViewController:(CustomUISplitViewController*)svc 
	 willHideViewController:(UIViewController *)aViewController 
		  withBarButtonItem:(UIBarButtonItem*)barButtonItem 
	   forPopoverController:(UIPopoverController*)pc {
	
	//if we keep master view in portrait mode we do not need
	//a extra toolbar
	if(svc.keepMasterInPortraitMode == YES)
		return;
	
	if(toolBar == nil) {
	
		//set title of master button
		barButtonItem.title = @"Show Master";
		
		//create a toolbar
		toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 1024, 44)];
		[toolBar setItems:[NSArray arrayWithObject:barButtonItem] animated:YES];
		
	}

	//add the toolbar to the details view
	[detailController.view addSubview:toolBar];
}


//the master view will be shown again
- (void)splitViewController:(CustomUISplitViewController*)svc 
	 willShowViewController:(UIViewController *)aViewController 
  invalidatingBarButtonItem:(UIBarButtonItem *)button {
	

	//remove the toolbar
	if(self.toolBar != nil)
		[toolBar removeFromSuperview];
}




@end
