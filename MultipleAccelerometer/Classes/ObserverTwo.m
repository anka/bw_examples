//
//  ObserverTwo.m
//  MultipleAccelerometer
//
//  Created by Andreas Katzian on 15.06.10.
//  Copyright 2010 Blackwhale GmbH. All rights reserved.
//

#import "ObserverTwo.h"


@implementation ObserverTwo

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
	NSLog(@"Observer two was notified about acceleration (x: %f y: %f z: %f).",
					acceleration.x,
					acceleration.y,
					acceleration.z);
}

@end
