//
//  Accelerometer.h
//
//  Created by Andreas Katzian on 15.06.10.
//  Copyright 2010 Blackwhale GmbH. All rights reserved.
//


@interface Accelerometer : NSObject <UIAccelerometerDelegate> {

	@private
	NSMutableArray *delegates;		//array of subscribed delegates
	
}

+ (Accelerometer*) sharedInstance;

- (void) addDelegate:(id<UIAccelerometerDelegate>) delegate;
- (void) removeDelegate:(id<UIAccelerometerDelegate>) delegate;

@end
