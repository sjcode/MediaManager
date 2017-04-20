//
//  MMMusicListView.m
//  MediaManager
//
//  Created by Arthur on 7/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MMMusicListView.h"


@implementation MMMusicListView
@synthesize mouseHoverRect;
- (void)awakeFromNib
{
	
	
	NSTrackingArea *trackingArea = [[[NSTrackingArea alloc] initWithRect:[self visibleRect]
																 options:NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingInVisibleRect |NSTrackingActiveAlways
																   owner:self
																userInfo:nil] autorelease];
	[self addTrackingArea:trackingArea];
}

- (IKImageBrowserCell *) newCellForRepresentedItem:(id) cell
{
	return [[MMMusicListCell alloc] init];
}

- (void) drawRect:(NSRect) rect
{
	NSRect visibleRect = [self visibleRect];

	if(!NSEqualRects(visibleRect, lastVisibleRect))
	{
		[[self backgroundLayer] setNeedsDisplay];
		lastVisibleRect = visibleRect;
	}
	
	[super drawRect:rect];
	[[NSColor whiteColor]set];
	NSRectFill(visibleRect);
}

- (void)mouseMoved:(NSEvent *)theEvent
{
	BOOL bFind = NO;
	NSPoint curPoint = [self convertPoint:[theEvent locationInWindow] fromView:nil];
	NSUInteger index = [self indexOfItemAtPoint:curPoint];
	if(NSNotFound != index)
	{
		NSRect cellRect = [self itemFrameAtIndex:index];
		
		MMMusicListCell * cell = (MMMusicListCell *)[self cellForItemAtIndex:index];
		if(cell)
		{
			if(cell != lastHoverMouseCell)
			{
				if(lastHoverMouseCell)
					lastHoverMouseCell.bMovehover = NO;
				lastHoverMouseCell = cell;
			}
			if(!cell.bMovehover)
			{
				mouseHoverRect = cellRect;
				CALayer *layer = [self foregroundLayer];
				[self setNeedsDisplayInRect:cellRect];
				[layer setNeedsDisplay];
				[layer displayIfNeeded];
				cell.bMovehover = YES;
				return;
			}
			
		}
		bFind = YES;
	}
}

- (void)mouseUp:(NSEvent *)theEvent
{
    
    
}


@end
