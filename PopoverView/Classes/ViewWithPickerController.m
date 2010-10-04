    //
//  ViewWithPickerController.m
//  PopoverView
//
//  Created by Andreas Katzian on 17.05.10.
//  Copyright 2010 Blackwhale GmbH. All rights reserved.
//

#import "ViewWithPickerController.h"


@implementation ViewWithPickerController

@synthesize pickerView, label, delegate;


#pragma mark -
#pragma mark UIPickerViewDataSource methods

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)picker {
	return 1;
}

// returns the number of rows in each component.
- (NSInteger)pickerView:(UIPickerView *)picker numberOfRowsInComponent:(NSInteger)component {
	return 5;
}


#pragma mark -
#pragma mark UIPickerViewDelegate methods

//returns the string value for the current row
- (NSString *)pickerView:(UIPickerView *)picker titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	return [NSString stringWithFormat:@"Picker Element %i", row];
}

//handle selection of a row
- (void)pickerView:(UIPickerView *)picker didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	NSString *value = [pickerView.delegate pickerView:picker titleForRow:row forComponent:component];
	self.label.text = value;
	
	//notify the delegate about selecting a value
	if(delegate != nil)
		[delegate viewWithPickerController:self didSelectValue:value];
}



#pragma mark -
#pragma mark View controller methods


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)dealloc {
	self.pickerView = nil;
	self.label = nil;
	
    [super dealloc];
}


@end
