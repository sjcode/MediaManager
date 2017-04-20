//
//  MMTextFieldCell.m
//  MediaManager
//
//  Created by Arthur on 7/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MMTextFieldCell.h"


@implementation MMTextFieldCell

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView{
	NSBezierPath *path = [[[NSBezierPath alloc] init]autorelease];
	[path appendBezierPathWithRoundedRect: cellFrame xRadius: 3.0 yRadius: 3.0];
	[[NSColor whiteColor]set];
	
	[path fill];
	
	[self drawInteriorWithFrame: cellFrame inView: controlView];
}

-(void)drawInteriorWithFrame:(NSRect) cellFrame inView:(NSView *) controlView {
	
	[super drawInteriorWithFrame: cellFrame inView: controlView];
}

@end
