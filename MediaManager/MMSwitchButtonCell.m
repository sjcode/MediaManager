//
//  MMSwitchButtonCell.m
//  MediaManager
//
//  Created by Arthur on 7/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MMSwitchButtonCell.h"


@implementation MMSwitchButtonCell

-(void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
{
	NSRect innerRect = cellFrame;
	NSInteger state = [self state];
	switch (state) {
		case NSOffState:
		{
			NSImage *image = [NSImage imageNamed:@"sync_off"];
			innerRect.size = [image size];
			[image drawInRect:innerRect fromRect: NSZeroRect operation: NSCompositeSourceOver fraction:1.0];	
		}
		break;
		case NSOnState:
		{
			NSImage *image = [NSImage imageNamed:@"sync_on"];
			innerRect.size = [image size];
			[image drawInRect:innerRect fromRect: NSZeroRect operation: NSCompositeSourceOver fraction:1.0];
		}
		break;
		default:
			break;
	}
}


@end
