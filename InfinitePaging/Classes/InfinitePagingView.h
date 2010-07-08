//
//  InfinitePagingView.h
//  InfinitePaging
//
//  Created by Andreas Katzian on 08.07.10.
//  Copyright 2010 Blackwhale GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InfinitePagingView;

// Protocol to define methods for a data souce delegate
@protocol InfinitePagingDataSource

@required
- (UIView*) infinitePagingView:(InfinitePagingView*) infinitePagingView viewForPageIndex:(int) index;

@end


// Interface definition.
@interface InfinitePagingView : UIView <UIScrollViewDelegate> {
	
	id<InfinitePagingDataSource> dataSource;	//data source delegate
	
	UIScrollView		*scrollView;		//internal scroll view
	NSMutableDictionary	*viewBuffer;		//temporary view buffer
	int					pageIndex;			//current page index
	
	
}

@property(nonatomic, assign) id<InfinitePagingDataSource> dataSource;

- (id)initWithFrame:(CGRect)frame andDataSource:(id<InfinitePagingDataSource>) ds;

@end
