//
//  NSString+Utilities.h
//  FoursquareIntegration
//
//  Created by Christian Inzinger on 5/9/10.
//  Copyright 2010 Blackwhale GmbH. All rights reserved.
//

#import <Foundation/NSString.h>	
#import <Foundation/NSPredicate.h>

@interface NSString (Utilities)

- (BOOL) isEmpty;
- (BOOL) isValidEmailFormat;
- (NSString*) encodeString;

@end
