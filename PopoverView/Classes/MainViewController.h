//
//  MainViewController.h
//  PopoverView
//
//  Created by Andreas Katzian on 17.05.10.
//  Copyright Blackwhale GmbH 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewWithPickerController.h"
#import "TablePopoverController.h"

@interface MainViewController : UIViewController <PopoverPickerDelegate> {

	UIPopoverController *popoverController;

	IBOutlet UIButton *popoverButton;
	IBOutlet UIButton *popoverButtonForPicker;
	IBOutlet UIButton *popoverButtonForTable;
	
	ViewWithPickerController *viewWithPickerController;
	TablePopoverController *tablePopoverController;
}

@property(nonatomic, retain) UIPopoverController *popoverController;
@property(nonatomic, retain) IBOutlet UIButton *popoverButton;
@property(nonatomic, retain) IBOutlet UIButton *popoverButtonForPicker;
@property(nonatomic, retain) IBOutlet UIButton *popoverButtonForTable;

@property(nonatomic, retain) ViewWithPickerController *viewWithPickerController;
@property(nonatomic, retain) TablePopoverController *tablePopoverController;

- (void) toolbarAction:(id) sender;
- (void) buttonAction:(id) sender;
- (void) showPickerPopupAction:(id) sender;
- (void) showTablePopupAction:(id) sender;


@end

