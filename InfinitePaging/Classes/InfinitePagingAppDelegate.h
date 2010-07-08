//
//  InfinitePagingAppDelegate.h
//  InfinitePaging
//
//  Created by Andreas Katzian on 08.07.10.
//  Copyright Blackwhale GmbH 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InfinitePagingViewController;

@interface InfinitePagingAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    InfinitePagingViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet InfinitePagingViewController *viewController;

@end

