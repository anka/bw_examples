//
//  TablePopoverController.m
//  PopoverView
//
//  Created by Andreas Katzian on 04.10.10.
//  Copyright 2010 Blackwhale GmbH. All rights reserved.
//

#import "TablePopoverController.h"


@implementation TablePopoverController



#pragma mark -
#pragma mark Table view data source

// Return the number of sections.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}


// Return the number of rows in the section.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"This is cell nr. %d", indexPath.section];
	cell.textLabel.text	 = [NSString stringWithFormat:@"Cell %d", indexPath.section];
    
    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	//do something in here
}


#pragma mark -
#pragma mark Memory management


- (void)dealloc {
    [super dealloc];
}


@end

