//
//  FoursquareIntegrationAppDelegate.h
//  FoursquareIntegration
//
//  Created by Andreas Katzian on 04.10.10.
//  Copyright 2010 Blackwhale GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoursquareIntegrationAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

