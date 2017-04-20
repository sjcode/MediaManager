//
//  MMMusicListBackgroundLayer.m
//  MediaManager
//
//  Created by Arthur on 7/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MMMusicListBackgroundLayer.h"
#import "Utilities.h"

@implementation MMMusicListBackgroundLayer

@synthesize owner;

- (id) init
{
	if((self = [super init])){
		//needs to redraw when bounds change
		[self setNeedsDisplayOnBoundsChange:YES];
	}
	
	return self;
}

- (id<CAAction>)actionForKey:(NSString *)event
{
	return nil;
}

- (void)drawInContext:(CGContextRef)context
{
	NSRect bounds = [owner bounds];
	
	CGContextSetRGBFillColor(context,0.1490,0.1490,0.1490,1);
	CGContextFillRect (context, NSRectToCGRect(bounds));
	
	return;
}

@end

