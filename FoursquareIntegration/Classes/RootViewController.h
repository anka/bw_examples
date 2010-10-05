//
//  RootViewController.h
//  FoursquareIntegration
//
//  Created by Andreas Katzian on 04.10.10.
//  Copyright 2010 Blackwhale GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController {
	
	NSArray *venues;
	
}

@property(nonatomic,retain) NSArray *venues;

@end
