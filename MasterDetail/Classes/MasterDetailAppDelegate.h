//
//  MasterDetailAppDelegate.h
//  MasterDetail
//
//  Created by Andreas Katzian on 15.05.10.
//  Copyright Blackwhale GmbH 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomUISplitViewController.h"

@interface MasterDetailAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    CustomUISplitViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet CustomUISplitViewController *viewController;

@end

