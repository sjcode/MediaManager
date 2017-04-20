//
//  MMComboBoxCell.m
//  MediaManager
//
//  Created by Arthur on 7/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MMComboBoxCell.h"


@implementation MMComboBoxCell

- (void)awakeFromNib
{
	if([self numberOfItems] > 0 )
	[self selectItemAtIndex:0];
}

- (void)drawButtonInRect:(NSRect) frame {
	NSImage *arrowImage = [NSImage imageNamed:@"cmb_arrow"];
	[arrowImage setFlipped:YES];
	frame.origin.x += (frame.size.width - arrowImage.size.width - 5);
	frame.origin.y = frame.size.height/2 - arrowImage.size.height/2;
	frame.size.width = arrowImage.size.width;
	frame.size.height = arrowImage.size.height;
	NSRect arrowRect = frame;
	[arrowImage drawInRect:arrowRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1];
}

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
	NSBezierPath *path = [[NSBezierPath alloc] init];
	[path appendBezierPathWithRoundedRect: cellFrame xRadius: 3.0 yRadius: 3.0];
	[[NSColor whiteColor]set];
	[path fill];
	
	[path release];
	
	
	[self drawButtonInRect:cellFrame];
	[super drawInteriorWithFrame: cellFrame inView: controlView];
	
}

@end
