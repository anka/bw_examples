    //
//  CustomUISplitViewController.m
//  MasterDetail
//
//  Created by Andreas Katzian on 15.05.10.
//  Copyright 2010 Blackwhale GmbH. All rights reserved.
//

#import "CustomUISplitViewController.h"


@implementation CustomUISplitViewController

@synthesize keepMasterInPortraitMode;

// It is possible to keep the Master View in portrait mode
// also. Just pass YES to this method to enable this mode.
- (id) initWithMasterInPortraitMode:(BOOL) masterInPortrait {
	self = [super init];
	self.keepMasterInPortraitMode = masterInPortrait;

	return self;
}


// Thanks to http://intensedebate.com/profiles/fgrios for this code snippet
-(void) viewWillAppear:(BOOL)animated {
	
	if(keepMasterInPortraitMode == NO) {
		return;
	}
	
	//check interface orientation at first view and adjust it
	//if it is in portrait mode
	if (self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
		UIViewController* master = [self.viewControllers objectAtIndex:0];
		UIViewController* detail = [self.viewControllers objectAtIndex:1];
		[self setupPortraitMode:master detail:detail];
	}
	
}

// Thanks to http://intensedebate.com/profiles/fgrios for this code snippet
- (void)setupPortraitMode:(UIViewController*)master detail:(UIViewController*)detail {
	//adjust master view
	CGRect f = master.view.frame;
	f.size.width = 320;
	f.size.height = 1024;
	f.origin.x = 0;
	f.origin.y = 0;
	
	[master.view setFrame:f];
	
	//adjust detail view
	f = detail.view.frame;
	f.size.width = 448;
	f.size.height = 1024;
	f.origin.x = 321;
	f.origin.y = 0;
	
	[detail.view setFrame:f];
}


/**
 * Sent to the view controller just before
 * the user interface begins rotating. This is
 * the place to control the display of master
 * and detail view.
 */
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval) duration {
	
	//call super method only if we don't want to keep the
	//master view in portrait mode also
	if(keepMasterInPortraitMode == NO) {
		[super willAnimateRotationToInterfaceOrientation:interfaceOrientation duration:duration];
		return;
	}
	
	//get master and detail view controller
	UIViewController* master = [self.viewControllers objectAtIndex:0];
	UIViewController* detail = [self.viewControllers objectAtIndex:1];
	
	//only handle the interface orientation
	//of portrait mode
	if(interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
		[self setupPortraitMode: master detail:detail];
	}
	else {
		//re-adjust detail view
		CGRect f = detail.view.frame;
		f = detail.view.frame;
		f.size.width = 704;
		f.size.height = 768;
		f.origin.x = 321;
		f.origin.y = 0;
		
		[detail.view setFrame:f];
		//call super method
		[super willAnimateRotationToInterfaceOrientation:interfaceOrientation duration:duration];
	}
} 


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation) interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)dealloc {
    [super dealloc];
}


@end
