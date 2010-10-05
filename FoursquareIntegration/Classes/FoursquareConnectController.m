//
//  FoursquareConnectController.m
//  FoursquareIntegration
//
//  Created by Andreas Katzian on 30.09.10.
//  Copyright 2010 Blackwhale GmbH. All rights reserved.
//

#import "FoursquareConnectController.h"
#import "NSString+Utilities.h"

#define TRANSITION_DURATION 0.8	//set the transition time of view animation

@implementation FoursquareConnectController

//properties
@synthesize username;
@synthesize password;
@synthesize delegate;


#pragma mark -
#pragma mark animation methods

// Methods to animate the apperance of the view.
// The animation looks like a bouncing view.

-(void)initialDelayEnded
{
    self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    self.view.alpha = 1.0;
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:TRANSITION_DURATION/1.5];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(bounce1AnimationStopped)];
	self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    [UIView commitAnimations];
}

- (void)bounce1AnimationStopped
{
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:TRANSITION_DURATION/2];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(bounce2AnimationStopped)];
	self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
    [UIView commitAnimations];
}

- (void)bounce2AnimationStopped
{
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:TRANSITION_DURATION/2];
	self.view.transform = CGAffineTransformIdentity;
    [UIView commitAnimations];
}


#pragma mark -
#pragma mark action methods

// The user canceled the connect view
- (IBAction) cancel:(id) sender
{
	[delegate didCloseFoursquareConnectController:self];
}

// The user wants to connect
- (IBAction) connect:(id) sender
{
	// Check if username and password is given
	BOOL validInput = YES;
	
	if(username.text == nil || [username.text isEmpty])
	{
		validInput = NO;
		[username becomeFirstResponder];
	}
	
	if(password.text == nil || [password.text isEmpty])
	{
		validInput = NO;
		[password becomeFirstResponder];
	}
	
	if(!validInput)
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login" 
														message:@"Please provide username and password." 
													   delegate:nil 
											  cancelButtonTitle:@"OK" 
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	else
	{
		// Advise delegate to connect
		[username resignFirstResponder];
		[password resignFirstResponder];
		[delegate foursquareConnectController:self connectWithUsername:username.text password:password.text];
	}
}


#pragma mark -
#pragma mark UITextFieldDelegate methods

// Called when 'return' key pressed. Return NO to ignore.
// Use this to switch between the input fields.
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	if(textField == self.username)
		[password becomeFirstResponder];
	else if(textField == self.password)
		[username becomeFirstResponder];
	
	return NO;
}


#pragma mark -
#pragma mark view methods

- (void)viewDidLoad {
    [super viewDidLoad];

	// Set delegate of input fields
	username.delegate = self;
	password.delegate = self;
}

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:NO];
	
	// Start animation of view
	self.view.alpha = 0;
	[self performSelector:@selector(initialDelayEnded) withObject:nil afterDelay:.3];
}


- (void)dealloc {
	self.username	= nil;
	self.password	= nil;

    [super dealloc];
}


@end
