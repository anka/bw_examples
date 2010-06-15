//
//  MultipleAccelerometerAppDelegate.h
//  MultipleAccelerometer
//
//  Created by Andreas Katzian on 15.06.10.
//  Copyright Blackwhale GmbH 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MultipleAccelerometerViewController;

@interface MultipleAccelerometerAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MultipleAccelerometerViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MultipleAccelerometerViewController *viewController;

@end

