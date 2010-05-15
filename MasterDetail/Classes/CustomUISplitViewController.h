//
//  CustomUISplitViewController.h
//  MasterDetail
//
//  Created by Andreas Katzian on 15.05.10.
//  Copyright 2010 Blackwhale GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomUISplitViewController : UISplitViewController {

	BOOL keepMasterInPortraitMode;
	
}

@property(nonatomic, assign) BOOL keepMasterInPortraitMode;


- (id) initWithMasterInPortraitMode:(BOOL) masterInPortrait;
- (void) setupPortraitMode:(UIViewController*)master detail:(UIViewController*)detail;

@end
