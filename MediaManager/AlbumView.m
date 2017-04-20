//
//  AlbumView.m
//  MediaManager
//
//  Created by Arthur on 5/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AlbumView.h"

@implementation AlbumView

- (id)initWithFrame:(NSRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) {
		NSShadow *dropShadow = [[NSShadow alloc] init];
        [dropShadow setShadowColor:[NSColor blackColor]];
        [dropShadow setShadowOffset:NSMakeSize(0, -10.0)];
        [dropShadow setShadowBlurRadius:10.0];
		
        [self setWantsLayer: YES];
        [self setShadow: dropShadow];
		
        [dropShadow release];
		 
    }
    return self;
}

- (void)dealloc
{
	//[shadow release];
}

//- (void)drawRect:(NSRect)dirtyRect 
//{
//	[[NSColor redColor] set];
//	NSRectFill(dirtyRect);
//}

- (BOOL)isFlipped
{
	return YES;
}

//- (void)drawRect:(NSRect)dirtyRect
//{
//	[super drawRect:dirtyRect];
//	//[[NSColor colorWithCalibratedRed:0.1490f green:0.1490f blue:0.1490f alpha:1.0f] set];
//    //NSRectFill(dirtyRect);
//}

- (BOOL)acceptsFirstResponder
{
	//接受foucs,如果不想带蓝色毛边,需要把tableview的fousc ring设置为none
    return YES;
}

- (void)keyDown:(NSEvent *)theEvent
{
	NSLog(@"AlbumView keyDown");
}


@end
