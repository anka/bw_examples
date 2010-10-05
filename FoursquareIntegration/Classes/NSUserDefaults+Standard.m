//
//  NSUserDefaults+Standard.m
//  FoursquareIntegration
//
//  Created by Andreas Katzian on 07.08.10.
//  Copyright 2010 Blackwhale GmbH. All rights reserved.
//

#import "NSUserDefaults+Standard.h"


@implementation NSUserDefaults (Standard)


+ (void) setBool:(BOOL) value forKey:(NSString*) key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setBool:value forKey:key];
	[defaults synchronize];
}

+ (BOOL) boolForKey:(NSString*) key
{
	return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}


+ (void) setObject:(id) value forKey:(NSString*) key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setValue:value forKey:key];
	[defaults synchronize];
}


+ (void) setString:(NSString*) value forKey:(NSString*) key
{
	[NSUserDefaults setObject:value forKey:key];
}

+ (NSString*) stringForKey:(NSString*) key
{
	return [[NSUserDefaults standardUserDefaults] stringForKey:key];
}


@end
