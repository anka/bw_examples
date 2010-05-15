//
//  SplitViewDelegate.h
//  MasterDetail
//
//  Created by Andreas Katzian on 15.05.10.
//  Copyright 2010 Blackwhale GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SplitViewDelegate : NSObject <UISplitViewControllerDelegate> {

	
	UIToolbar* toolBar;
	UIViewController* detailController;
	
}

@property(nonatomic, retain) UIToolbar* toolBar;
@property(nonatomic, retain) UIViewController* detailController;


@end
