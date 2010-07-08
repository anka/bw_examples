//
//  InfinitePagingView.m
//  InfinitePaging
//
//  Created by Andreas Katzian on 08.07.10.
//  Copyright 2010 Blackwhale GmbH. All rights reserved.
//

#import "InfinitePagingView.h"

#define MAX_BUFFER_SIZE 6

// Anonymus category for additional methods and properties
@interface InfinitePagingView()

- (void) setup;
- (void) updateToPage:(int) page;
- (void) setViewForPage:(int) page;
- (void) checkViewBuffer;

@property(nonatomic, retain) UIScrollView *scrollView;
@property(nonatomic, retain) NSMutableDictionary *viewBuffer;

@end




@implementation InfinitePagingView

@synthesize dataSource;
@synthesize scrollView;
@synthesize viewBuffer;


// Do the intial setup of the infinite paging view.
- (void) setup
{
	//init page index
	pageIndex = -1;
	
	//init view buffer
	viewBuffer = [[NSMutableDictionary alloc] init];
	
	//setup view
	self.backgroundColor = [UIColor clearColor];
	
	//init scroll view
	self.scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
	scrollView.backgroundColor = [UIColor clearColor];
	scrollView.pagingEnabled = YES;
	scrollView.delegate = self;
	scrollView.scrollEnabled = YES;
	
	//add scroll view
	[self addSubview:scrollView];
	
	//initialize first pages
	[self updateToPage:0];
}

// Update to new page. This occurs when the user
// scrolls the view to a new page.
- (void) updateToPage:(int) page
{
	if(page != pageIndex)
	{
		CGFloat pageWidth	= scrollView.frame.size.width;
		CGSize	contentSize	= scrollView.frame.size;
		
		contentSize.width	= pageWidth * (page + 2);
		
		[self setViewForPage:(page-1)];
		[self setViewForPage:page];
		[self setViewForPage:(page+1)];
		
		self.scrollView.contentSize = contentSize;
		pageIndex = page;
	}
}

// Load the view for a given page. Use the dataSource
// to get the view or check the view buffer.
- (void) setViewForPage:(int) page
{
	if(page < 0)
		return;

	//calculate x offset
	CGFloat offsetX	= scrollView.frame.size.width * page;
	
	//check if view is allready within the view buffer
	UIView *view = nil;
	if((view = [self.viewBuffer objectForKey:[NSNumber numberWithInt:page]]) == nil)
	{
		//get view from data source
		view = [self.dataSource infinitePagingView:self viewForPageIndex:page];
		[self.viewBuffer setObject:view forKey:[NSNumber numberWithInt:page]];
		
		//set the x offset
		CGRect viewFrame = view.frame;
		viewFrame.origin.x = offsetX;
		view.frame = viewFrame;
		
		//add as subview
		[self.scrollView addSubview:view];
		
		//check view buffer size
		[self checkViewBuffer];
	}
	
}

// Check if view buffer violates the max. view
// buffer size and clean it up if necessary.
- (void) checkViewBuffer
{
	if(self.viewBuffer && [self.viewBuffer count] > MAX_BUFFER_SIZE)
	{
		NSLog(@"checkViewBuffer %d items before cleanup", [self.viewBuffer count]);
		
		for(NSNumber *page in [self.viewBuffer allKeys])
		{
			if([page intValue] < (pageIndex - 1) || [page intValue] > (pageIndex + 1))
			{
				UIView *view = [self.viewBuffer objectForKey:page];
				[view removeFromSuperview];
				[self.viewBuffer removeObjectForKey:page];
			}
		}

		NSLog(@"checkViewBuffer %d items after cleanup", [self.viewBuffer count]);
	}
}


#pragma mark -
#pragma mark UIScrollViewDelegate methods

// Notification about any scroll offset change.
- (void)scrollViewDidScroll:(UIScrollView *)sView
{
    CGFloat pageWidth = sView.frame.size.width;
	int page = floor((sView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
	[self updateToPage:page];
}


#pragma mark -
#pragma mark Initialization and memory management

// Initialize the view with given frame and data source.
- (id)initWithFrame:(CGRect)frame andDataSource:(id<InfinitePagingDataSource>) ds
{
    if ((self = [super initWithFrame:frame])) {
		self.dataSource = ds;
		[self setup];
	}
    return self;
}


- (void)dealloc {
	self.scrollView = nil;
	self.viewBuffer = nil;
	
    [super dealloc];
}


@end
