//
//  FoursquareConnectController.h
//  FoursquareIntegration
//
//  Created by Andreas Katzian on 30.09.10.
//  Copyright 2010 Blackwhale GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FoursquareConnectController;

// A protocol to define delegate methods
@protocol FoursquareConnectControllerDelegate

// method to authenticate a user with given username and password
- (void) foursquareConnectController:(FoursquareConnectController*) foursquareConnectController 
				 connectWithUsername:(NSString*) username 
							password:(NSString*) password;

// method to signalize the closing of connect view
- (void) didCloseFoursquareConnectController:(FoursquareConnectController*) foursquareConnectController;

@end


@interface FoursquareConnectController : UIViewController <UITextFieldDelegate> {

	//input fields
	IBOutlet UITextField	*username;
	IBOutlet UITextField	*password;
	
	//delegate
	id<FoursquareConnectControllerDelegate> delegate;
	
}

@property(nonatomic,retain) IBOutlet UITextField	*username;
@property(nonatomic,retain) IBOutlet UITextField	*password;

@property(nonatomic,assign) id<FoursquareConnectControllerDelegate> delegate;

// Actions for connect and cancel button 
- (IBAction) cancel:(id) sender;
- (IBAction) connect:(id) sender;


@end
