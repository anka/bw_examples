//
//  ViewWithPickerController.h
//  PopoverView
//
//  Created by Andreas Katzian on 17.05.10.
//  Copyright 2010 Blackwhale GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

//need to declare class
@class ViewWithPickerController;


//A simple protocol to implement delegation
//for value selection within the picker view
@protocol PopoverPickerDelegate

@required
- (void) viewWithPickerController:(ViewWithPickerController*) viewWithPickerController didSelectValue:(NSString*) value;

@end


@interface ViewWithPickerController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {

	IBOutlet UIPickerView *pickerView;
	IBOutlet UILabel *label;
	
	id<PopoverPickerDelegate> delegate;
	
}

@property(nonatomic, retain) IBOutlet UIPickerView *pickerView;
@property(nonatomic, retain) IBOutlet UILabel *label;

@property(nonatomic, assign) id<PopoverPickerDelegate> delegate;



@end
