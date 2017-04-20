//
//  MMSharedOperationQueue.m
//  MediaManager
//
//  Created by Arthur on 6/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MMSharedOperationQueue.h"

static MMSharedOperationQueue* _sharedInstance = nil;

@implementation MMSharedOperationQueue
@synthesize _operationQueue;
+ (MMSharedOperationQueue*)shareOperationQueue
{
	@synchronized([MMSharedOperationQueue class])
	{
		if (!_sharedInstance)
			[[self alloc] init];
		
		return _sharedInstance;
	}
	
	return nil;
}

+ (id)alloc
{
	@synchronized([MMSharedOperationQueue class])
	{
		NSAssert(_sharedInstance == nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedInstance = [super alloc];
		_sharedInstance._operationQueue = [[NSOperationQueue alloc]init];
		return _sharedInstance;
	}
	
	return nil;
}

-(id)init {
	self = [super init];
	if (self != nil) 
	{
		// initialize stuff here
	}
	
	return self;
}

- (void)dealloc
{
	[super dealloc];
}

- (NSOperationQueue*)instance
{
	return _operationQueue;
}
@end
