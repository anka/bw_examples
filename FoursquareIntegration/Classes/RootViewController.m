//
//  RootViewController.m
//  FoursquareIntegration
//
//  Created by Andreas Katzian on 04.10.10.
//  Copyright 2010 Blackwhale GmbH. All rights reserved.
//

#import "RootViewController.h"
#import "Foursquare.h"

@implementation RootViewController

@synthesize venues;


#pragma mark -
#pragma mark Action methods

- (void) foursquareLoginLogout:(id) sender
{
	if([[Foursquare sharedInstance] isActive])
	{
		[[Foursquare sharedInstance] logout];
		[(UIBarButtonItem*)sender setTitle:@"Connect"];
	}
	else
	{
		[[Foursquare sharedInstance] setRootController:self];
		[[Foursquare sharedInstance] login];
		[(UIBarButtonItem*)sender setTitle:@"Disconnect"];
	}
}

- (void) reloadVenues:(id) sender
{
	if([[Foursquare sharedInstance] isActive] == NO)
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Foursquare" 
														message:@"Connect your foursquare account first." 
													   delegate:nil 
											  cancelButtonTitle:@"OK" 
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	else
	{
		//Search venues nearby the wall street (limit to 30 venues)
		//Customize this on your own.
		self.venues = [[Foursquare sharedInstance] findLocationsNearbyLatitude:40.705651 
																	 longitude:-74.008117 
																		 limit:30 
																	searchterm:nil];
		[self.tableView reloadData];
	}
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
	//Set title
	self.title = @"foursquare";

	//Add a foursquare connect/disconnect button
	NSString *title = [[Foursquare sharedInstance] isActive] ? @"Disconnect" : @"Connect";
	UIBarButtonItem *connectButton = [[UIBarButtonItem alloc] initWithTitle:title 
																	  style:UIBarButtonItemStyleDone 
																	 target:self 
																	 action:@selector(foursquareLoginLogout:)];
	self.navigationItem.leftBarButtonItem = connectButton;
	[connectButton release];


	//Add a reload button
	UIBarButtonItem *reloadButton = [[UIBarButtonItem alloc] initWithTitle:@"Reload" 
																	  style:UIBarButtonItemStyleDone 
																	 target:self 
																	 action:@selector(reloadVenues:)];
	self.navigationItem.rightBarButtonItem = reloadButton;
	[reloadButton release];
}


#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return venues ? [venues count] : 1; 
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
	
	if(venues && [venues count] > 0)
	{
		//Get dictionary with venue information
		NSDictionary *venue = (NSDictionary*)[venues objectAtIndex:indexPath.row];
		
		NSString *name		= [venue objectForKey:@"name"];
		NSNumber *distance	= [venue objectForKey:@"distance"];
		
		cell.textLabel.text = name;
		cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ meters", distance];
	}
	else
	{
		cell.textLabel.text = @"";
		cell.detailTextLabel.text = @"Connect to foursquare and reload";
	}
    

    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	//Deselect cell
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
	
	//Check if venues present
	if(venues == nil || [venues count] < 1)
		return;

	if([[Foursquare sharedInstance] isActive] == NO)
		return;
	
	//Get dictionary with venue information
	NSDictionary *venue = (NSDictionary*)[venues objectAtIndex:indexPath.row];

	NSNumber *venueId	= [venue objectForKey:@"id"];
	NSNumber *geolat	= [venue objectForKey:@"geolat"];
	NSNumber *geolong	= [venue objectForKey:@"geolong"];

	//Checkin to venue and get message
	NSString *message = [[Foursquare sharedInstance] checkinAtVenue:[venueId stringValue] 
														   latitude:[geolat doubleValue] 
														  longitude:[geolong doubleValue]];
	
	//Show message from foursquare
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Checkin" 
													message:message 
												   delegate:nil 
										  cancelButtonTitle:@"Thanks!" 
										  otherButtonTitles:nil];
	[alert show];
	[alert release];
}


#pragma mark -
#pragma mark Memory management


- (void)dealloc {
	self.venues = nil;
	
    [super dealloc];
}


@end

