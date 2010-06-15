//
//  Accelerometer.m
//
//  Created by Andreas Katzian on 15.06.10.
//  Copyright 2010 Blackwhale GmbH. All rights reserved.
//
//  The singelton pattern which is used was thankfully described at
//  http://www.duckrowing.com/2010/05/21/using-the-singleton-pattern-in-objective-c/
//

#import "Accelerometer.h"

// Anonymus category for private properties
// and methods.
@interface Accelerometer ()
	
@property(nonatomic,retain) NSMutableArray *delegates;	//array of subscribed delegates

@end


static Accelerometer* sharedInstance_ = nil;			//the shared instance


// Class implementation
@implementation Accelerometer

@synthesize delegates;


#pragma mark -
#pragma mark Delegates management

// Subscribe a new delegate.
- (void) addDelegate:(id<UIAccelerometerDelegate>) delegate
{
	[self.delegates addObject:delegate];
}

// Remove a delegate.
- (void) removeDelegate:(id<UIAccelerometerDelegate>) delegate
{
	[self.delegates removeObject:delegate];
}


#pragma mark -
#pragma mark UIAccelerometerDelegate delegate

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
	@synchronized(sharedInstance_)
	{
		//Notify all delegates of acceleration event
		for(id<UIAccelerometerDelegate> delegate in self.delegates)
		{
			[delegate accelerometer:accelerometer didAccelerate:acceleration];
		}
	}
}


#pragma mark -
#pragma mark Singelton methods

// Get the shared instance of this singelton.
+ (Accelerometer*) sharedInstance
{
	@synchronized(self)
	{
		[[self alloc] init];
	}
	
	return sharedInstance_;
}

// Overwrite allocWithZone to be sure to 
// allocate memory only once.
+ (id)allocWithZone:(NSZone *)zone
{
	@synchronized(self) {
		if (sharedInstance_ == nil) {
			sharedInstance_ = [super allocWithZone:zone];

			//additional initialization
			sharedInstance_.delegates = [[NSMutableArray alloc] init];
			[UIAccelerometer sharedAccelerometer].delegate = sharedInstance_;
			
			return sharedInstance_;
		}
	}
	
	return nil;
}

// Nobody should be able to copy 
// the shared instance.
- (id)copyWithZone:(NSZone *)zone
{
	return self;
}

// Retaining the shared instance should not
// effect the retain count.
- (id)retain
{
	return self;
}

// Releasing the shared instance should not
// effect the retain count.
- (void)release
{
}

// Auto-releasing the shared instance should not
// effect the retain count.
- (id)autorelease
{
	return self;
}

// Retain count should not go to zero.
- (NSUInteger)retainCount
{
	return NSUIntegerMax;
}

@end
