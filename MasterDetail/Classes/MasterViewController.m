//
//  MasterViewController.m
//  MasterDetail
//
//  Created by Andreas Katzian on 15.05.10.
//  Copyright 2010 Blackwhale GmbH. All rights reserved.
//

#import "MasterViewController.h"


@implementation MasterViewController


#pragma mark -
#pragma mark View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // MUST return YES to allow all orientations
    return YES;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 4;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	cell.textLabel.text = [NSString stringWithFormat:@"Example Entry %i, %i", indexPath.section, indexPath.row];
    
    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	//need to remove cell selection 
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
	
	//if there is now split view controller this controller
	//is not used as a master controller
	if(self.splitViewController == nil)
		return;
	
	//since we are the master view controller of a split view 
	//we know there is a parent UISplitViewController
	NSArray *controllers = self.splitViewController.viewControllers;
	
	//Excerpt from the documentation:
	//http://developer.apple.com/library/ios/#documentation/UIKit/Reference/UISplitViewController_class/Reference/Reference.html
	//The array in this property must contain exactly two view controllers. 
	//The view controllers are presented left-to-right in the split view interface 
	//when it is in a landscape orientation. Thus, the view controller at index 0 
	//is displayed on the left side and the view controller at index 1 is displayed 
	//on the right side of the interface.
	
	//if there aren't at least two controllers somethin went wrong
	if([controllers count] < 2)
		return;
	
	//get the detail controller
	UIViewController *detailViewController = [controllers objectAtIndex:1];
	
	//now you can do whatever you want to change 
	//controls or text on detail view controller
	//EXAMPLE:
	//UIView *detailView = detailViewController.view;
	//detailView.backgroundColor = (indexPath.row % 2 == 0) ? [UIColor grayColor] : [UIColor blackColor];
	
	//if you want to change the detail view controller
	//just create a new array containing the master and 
	//new detail controller and set the property "viewControllers"
	//of the current split view controller
	UIViewController *newDetailController = [[UIViewController alloc] init];
	UIView *newDetailView = [[UIView alloc] initWithFrame:detailViewController.view.frame];
	newDetailView.backgroundColor = [UIColor yellowColor];
	newDetailController.view = newDetailView;
	
	NSArray *newControllers = [NSArray arrayWithObjects:self, newDetailController, nil];
	self.splitViewController.viewControllers = newControllers;
	
	[newDetailController release];
	[newDetailView release];
}


#pragma mark -
#pragma mark Memory management


- (void)dealloc {
    [super dealloc];
}


@end

