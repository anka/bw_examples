//
//  ViewWithPickerController.h
//  PopoverView
//
//  Created by Andreas Katzian on 17.05.10.
//  Copyright 2010 Blackwhale GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewWithPickerController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {

	IBOutlet UIPickerView *pickerView;
	IBOutlet UILabel *label;
	
}

@property(nonatomic, retain) IBOutlet UIPickerView *pickerView;
@property(nonatomic, retain) IBOutlet UILabel *label;



@end
