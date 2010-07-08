//
//  InfinitePagingViewController.m
//  InfinitePaging
//
//  Created by Andreas Katzian on 08.07.10.
//  Copyright Blackwhale GmbH 2010. All rights reserved.
//

#import "InfinitePagingViewController.h"

@implementation InfinitePagingViewController

- (UIView*) infinitePagingView:(InfinitePagingView*) infinitePagingView viewForPageIndex:(int) index
{
	//provide some very simple views with different background
	//colors to demonstrate the infinite paging view
	UIView *v = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 300)] autorelease];
	
	int r = rand();

	if(r%3 == 0)
		v.backgroundColor = [UIColor grayColor];
	else if(r%5 == 0)
		v.backgroundColor = [UIColor greenColor];
	else if(r%7 == 0)
		v.backgroundColor = [UIColor redColor];
	else
		v.backgroundColor = [UIColor blueColor];
	
	return v;
}


// Implement viewDidLoad to do additional setup after 
// loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	srand(time(NULL));
	
	InfinitePagingView *infinitePagingView = [[InfinitePagingView alloc] 
											  initWithFrame:CGRectMake(0, 0, 320, 480)
											  andDataSource:self];
	
	[self.view addSubview:infinitePagingView];
	[infinitePagingView release];
}


- (void)dealloc {
    [super dealloc];
}

@end
