//
//  SongCategory.m
//  MediaManager
//
//  Created by Arthur on 5/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SongCategory.h"


@implementation SongCategory
@synthesize name,array;

- (id)initWithName:(NSString*)s
{
	if(self = [super init])
	{
		name = [NSString stringWithString:s];
		array = [[NSMutableArray alloc]init];
	}
	return self;
}

- (void)dealloc
{
	[name release];
	[array release];
	[super dealloc];
}

@end
