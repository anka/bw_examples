//
//  ObserverOne.m
//  MultipleAccelerometer
//
//  Created by Andreas Katzian on 15.06.10.
//  Copyright 2010 Blackwhale GmbH. All rights reserved.
//

#import "ObserverOne.h"


@implementation ObserverOne

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
	NSLog(@"Observer one was notified about acceleration (x: %f y: %f z: %f).",
						acceleration.x,
						acceleration.y,
						acceleration.z);
}


@end
