//
//  MainViewController.m
//  PopoverView
//
//  Created by Andreas Katzian on 17.05.10.
//  Copyright Blackwhale GmbH 2010. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

@synthesize popoverController, popoverButton, viewWithPickerController, popoverButtonForPicker;

//method which gets called when button at toolbar was activated
- (void) toolbarAction:(id) sender {
	
	if([self.popoverController isPopoverVisible])
	{
		//close the popover view if toolbar button was touched
		//again and popover is already visible
		//Thanks to @chrisonhismac
		
		[self.popoverController dismissPopoverAnimated:YES];
		return;
	}
	
	//build our custom popover view
	UIViewController* popoverContent = [[UIViewController alloc]
										init];
	UIView* popoverView = [[UIView alloc]
						   initWithFrame:CGRectMake(0, 0, 300, 400)];
	popoverView.backgroundColor = [UIColor blueColor];
	popoverContent.view = popoverView;
	
	//resize the popover view shown
	//in the current view to the view's size
	popoverContent.contentSizeForViewInPopover = CGSizeMake(300, 400);
	
	//create a popover controller
	self.popoverController = [[UIPopoverController alloc]
							  initWithContentViewController:popoverContent];
	
	//present the popover view non-modal with a
	//refrence to the toolbar button which was pressed
	[self.popoverController presentPopoverFromBarButtonItem:sender
								   permittedArrowDirections:UIPopoverArrowDirectionUp
												   animated:YES];
	
	//release the popover content
	[popoverView release];
	[popoverContent release];
}


//only a helper method
- (void) exampleAction:(id) sender {
	//do nothing
}


//method which gets called when the button at main view was activated
- (void) buttonAction:(id) sender {
	//build our custom popover view
	UIViewController* popoverContent = [[UIViewController alloc]
										init];
	UIView* popoverView = [[UIView alloc]
						   initWithFrame:CGRectMake(0, 0, 200, 300)];
	popoverView.backgroundColor = [UIColor greenColor];
	
	//Example of adding a simple button to the view
	UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[button setFrame:CGRectMake(20, 20, 150, 40)];
	[button setTitle:@"A button" forState:UIControlStateNormal];
	[button addTarget:self action:@selector(exampleAction:) forControlEvents:UIControlEventTouchUpInside];
	[popoverView addSubview:button];
	
	popoverContent.view = popoverView;
	
	//resize the popover view shown
	//in the current view to the view's size
	popoverContent.contentSizeForViewInPopover = CGSizeMake(200, 300);
	
	//create a popover controller
	self.popoverController = [[UIPopoverController alloc]
							  initWithContentViewController:popoverContent];
	
	//present the popover view non-modal with a
	//refrence to the button pressed within the current view
	[self.popoverController presentPopoverFromRect:popoverButton.frame
											inView:self.view
						  permittedArrowDirections:UIPopoverArrowDirectionAny
										  animated:YES];
	
	//release the popover content
	[popoverView release];
	[popoverContent release];
}


- (void) showPickerPopupAction:(id) sender {
	//create the view controller from nib
	self.viewWithPickerController = [[ViewWithPickerController alloc] 
										initWithNibName:@"ViewWithPicker" 
										bundle:[NSBundle mainBundle]];
	

	//set popover content size
	viewWithPickerController.contentSizeForViewInPopover = 
			CGSizeMake(viewWithPickerController.view.frame.size.width, viewWithPickerController.view.frame.size.height);

	
	//create a popover controller
	self.popoverController = [[UIPopoverController alloc]
							  initWithContentViewController:viewWithPickerController];
	

	//present the popover view non-modal with a
	//refrence to the button pressed within the current view
	[self.popoverController presentPopoverFromRect:popoverButtonForPicker.frame
											inView:self.view
						  permittedArrowDirections:UIPopoverArrowDirectionAny
										  animated:YES];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


- (void)dealloc {
	self.popoverController = nil;
	self.popoverButton = nil;
	self.viewWithPickerController = nil;
	self.popoverButtonForPicker = nil;
	
    [super dealloc];
}

@end
