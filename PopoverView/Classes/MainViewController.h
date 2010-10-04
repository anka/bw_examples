//
//  MainViewController.h
//  PopoverView
//
//  Created by Andreas Katzian on 17.05.10.
//  Copyright Blackwhale GmbH 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewWithPickerController.h"

@interface MainViewController : UIViewController <PopoverPickerDelegate> {

	UIPopoverController *popoverController;

	IBOutlet UIButton *popoverButton;
	IBOutlet UIButton *popoverButtonForPicker;
	
	ViewWithPickerController *viewWithPickerController;
}

@property(nonatomic, retain) UIPopoverController *popoverController;
@property(nonatomic, retain) IBOutlet UIButton *popoverButton;
@property(nonatomic, retain) IBOutlet UIButton *popoverButtonForPicker;

@property(nonatomic, retain) ViewWithPickerController *viewWithPickerController;

- (void) toolbarAction:(id) sender;
- (void) buttonAction:(id) sender;
- (void) showPickerPopupAction:(id) sender;


@end

