//
//  NSString+Utilities.h
//  arstreets
//
//  Created by Christian Inzinger on 5/9/10.
//  Copyright 2010 Blackwhale GmbH. All rights reserved.
//

//if we don't import this logic test doesn't work???
#import <Foundation/NSString.h>	
#import <Foundation/NSPredicate.h>

@interface NSString (Utilities)

- (BOOL) isEmpty;
- (BOOL) isValidEmailFormat;
- (NSString*) encodeString;

@end
