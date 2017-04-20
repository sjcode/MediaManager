//
//  AlbumImageView.m
//  MediaManager
//
//  Created by Arthur on 5/7/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AlbumImageView.h"


@implementation AlbumImageView
@synthesize delegate;

- (id)initWithFrame:(NSRect)frameRect
{
	if(self = [super initWithFrame:frameRect])
	{
	
	}
	return self;
}

- (void)awakeFromNib
{
	NSTrackingArea *trackingArea = [[[NSTrackingArea alloc] initWithRect:[self visibleRect]
																 options:NSTrackingMouseEnteredAndExited | NSTrackingInVisibleRect |NSTrackingActiveAlways
																   owner:self
																userInfo:nil] autorelease];
	
	[self addTrackingArea:trackingArea];
}

- (void)mouseEntered:(NSEvent *)event 
{
	//NSLog(@"[%@] AlbumImageView::mouseEntered",self);
	if(self.delegate && [self.delegate respondsToSelector:@selector(mouseEntered:)])
	{
		[self.delegate mouseEntered:event];
	}
}

- (void)mouseExited:(NSEvent *)event 
{
	if(self.delegate && [self.delegate respondsToSelector:@selector(mouseExited:)])
	{
		[self.delegate mouseExited:event];
	}
}

- (void)mouseDown:(NSEvent *)event
{
	if(self.delegate && [self.delegate respondsToSelector:@selector(mouseDown:)])
	{
		[self.delegate mouseDown:event];
	}
}

- (void)mouseUp:(NSEvent *)event
{
	if(self.delegate && [self.delegate respondsToSelector:@selector(mouseUp:)])
	{
		[self.delegate mouseUp:event];
	}
}

@end
