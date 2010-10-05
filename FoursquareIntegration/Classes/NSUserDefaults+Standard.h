//
//  NSUserDefaults+Standard.h
//  FoursquareIntegration
//
//  Created by Andreas Katzian on 07.08.10.
//  Copyright 2010 Blackwhale GmbH. All rights reserved.
//
//  A simple wrapper category for NSUserDefaults to provide
//  some common methods to read and write default values.
//


@interface NSUserDefaults (Standard) 

//read/wrtie bool values
+ (void) setBool:(BOOL) value forKey:(NSString*) key;
+ (BOOL) boolForKey:(NSString*) key;

//read/write string values
+ (void) setString:(NSString*) value forKey:(NSString*) key;
+ (NSString*) stringForKey:(NSString*) key;


@end
