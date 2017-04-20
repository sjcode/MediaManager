//
//  MMRadioButtonCell.m
//  MediaManager
//
//  Created by Arthur on 7/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MMRadioButtonCell.h"


@implementation MMRadioButtonCell

-(void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
	NSRect innerRect = cellFrame;
	NSInteger state = [self state];
	switch (state) {
		case NSOffState: {
			NSImage *image = [NSImage imageNamed:@"radio_unchecked"];
			innerRect.size = [image size];
			[image setFlipped:YES];
			[image drawInRect:NSMakeRect(0, cellFrame.origin.y+5, 28, 28) fromRect: NSZeroRect operation: NSCompositeSourceOver fraction:1.0];	
		}
			break;
		case NSOnState: {
			
			NSImage *image = [NSImage imageNamed:@"radio_checked"];
			innerRect.size = [image size];
			[image setFlipped:YES];
			[image drawInRect:NSMakeRect(0, cellFrame.origin.y+5, 28, 28) fromRect: NSZeroRect operation: NSCompositeSourceOver fraction:1.0];
		}
			break;
		default:
			break;
	}
	
	NSRect textRect;
	NSDivideRect (cellFrame, &innerRect, &textRect, 3 + innerRect.size.width, NSMinXEdge);
	NSMutableDictionary * attributes = [[[NSMutableDictionary alloc] init] autorelease];
	[attributes setObject:[NSColor whiteColor] forKey:NSForegroundColorAttributeName];
	[attributes setObject:[NSFont fontWithName:@"Helvetica" size:14] forKey:NSFontAttributeName]; 
	//NSSize textSize = [[self title] sizeWithAttributes:attributes];
	//textRect.origin.y = textRect.size.height/2 - textSize.height/2-4;
	textRect.origin.y += 9;
	[[self title] drawInRect:textRect withAttributes:attributes ];
}

@end
