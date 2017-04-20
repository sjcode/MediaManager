//
//  SplashWindow.m
//  SplashTest
//
//  Created by Arthur on 5/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SplashWindow.h"


@implementation SplashWindow

- (id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag
{
	self = [super initWithContentRect:contentRect
							styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered
								defer:NO];
	
	NSRect screenRect = [[NSScreen mainScreen] frame]; // NSRect for screen
	
	NSImage *backgroundImage = [NSImage imageNamed:@"bg_splash"];
	NSSize size = [backgroundImage size];
	contentRect = CGRectMake(screenRect.size.width /2-size.width/2, screenRect.size.height/2-size.height/2, size.width, size.height);
	[self setBackgroundColor:[NSColor colorWithPatternImage:backgroundImage]];
	
	[self setFrame:contentRect display:YES animate:YES];

	[self orderFront:self ];
	return self;
	
}

- (BOOL)acceptsMouseMovedEvents
{
	return NO;
}
@end
