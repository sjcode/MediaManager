//
//  MMProgressBar.m
//  MediaManager
//
//  Created by Arthur on 7/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MMProgressBar.h"

NSString * MMProgressBarValueDidChangeNotify = @"MMProgressBarValueDidChange";

@implementation MMProgressBar
- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib{
	progressImage = [NSImage imageNamed:@"bg_player_progress"];
	thumbImage = [NSImage imageNamed:@"bg_player_thumb"];
	knobImage = [NSImage imageNamed:@"progressposition"];
	
	progressImageLeft = [NSImage imageNamed:@"bg_player_progress_left"];
	progressImageMiddle = [NSImage imageNamed:@"bg_player_progress_middle"];
	progressImageRight = [NSImage imageNamed:@"bg_player_progress_right"];
	
	thumbImageLeft = [NSImage imageNamed:@"bg_player_progress_thumb_left"];
	thumbImageMiddle = [NSImage imageNamed:@"bg_player_progress_thumb_middle"];
	thumbImageRight = [NSImage imageNamed:@"bg_player_progress_thumb_right"];
	
	isMouseDown=NO;
	isKnobRelease = YES;
	lastpostdate=[[NSDate date] retain];
	
	NSTrackingArea *trackingArea = [[[NSTrackingArea alloc] initWithRect:[self visibleRect]
																 options:NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingInVisibleRect |NSTrackingActiveAlways
																   owner:self
																userInfo:nil] autorelease];
	[self addTrackingArea:trackingArea];
	[self display];
}

- (void) dealloc
{
	[super dealloc];
}

- (void)drawRect:(NSRect)dirtyRect {
	
	NSSize canvasSize = NSMakeSize([self bounds].size.width, [self bounds].size.height);
	NSImage *canvas = [[[NSImage alloc] initWithSize:canvasSize] autorelease];
	NSRect canvasRect=NSMakeRect(0, 0, [canvas size].width,[canvas size].height);
	
	
	NSRect sliderRect = canvasRect;
	
	sliderRect.origin.y = (canvasRect.size.height/2) - (progressImage.size.height/2);
	sliderRect.size.height=progressImage.size.height;
	
	[canvas lockFocus];
	
	NSRect leftRect = NSMakeRect(0, 0, [progressImageLeft size].width, [progressImageLeft size].height);
	[progressImageLeft drawInRect:leftRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];	
	
	NSRect middleRect = NSMakeRect([progressImageLeft size].width, 0, canvasSize.width-leftRect.size.width*2, [progressImageMiddle size].height);
	[progressImageMiddle drawInRect:middleRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	
	NSRect rightRect = NSMakeRect(leftRect.size.width+middleRect.size.width, 0, [progressImageRight size].width, [progressImageRight size].height);
	[progressImageRight drawInRect:rightRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	
	NSRect thumbRect = sliderRect;
	thumbRect.size.height = [thumbImageMiddle size].height;
	thumbRect.size.width = canvasRect.size.width*[self doubleValue]/[self maxValue];
	
	NSRect thumbLeftRect = NSMakeRect(0, 0, [thumbImageLeft size].width, [thumbImageLeft size].height);
	NSRect thumbMiddleRect = NSMakeRect([thumbImageLeft size].width, 0, thumbRect.size.width-thumbLeftRect.size.width, [thumbImageMiddle size].height);
	NSRect thumbRightRect = NSMakeRect(thumbLeftRect.size.width+thumbMiddleRect.size.width, 0, [thumbImageRight size].width, [thumbImageRight size].height);
	
	[thumbImageLeft drawInRect:thumbLeftRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0]; 
	[thumbImageMiddle drawInRect:thumbMiddleRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0]; 
	[thumbImageRight drawInRect:thumbRightRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0]; 
	
	/*
	[progressImage drawInRect:sliderRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	
	NSRect thumbRc = sliderRect;
	thumbRc.size.width = canvasRect.size.width*[self doubleValue]/[self maxValue];
	[thumbImage drawInRect:thumbRc fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	
	if(isMouseEnter)
	{
		NSRect knobRect;
		if(thumbRc.size.width < knobImage.size.width)
		{
			knobRect = NSMakeRect(0, 2, knobImage.size.width, knobImage.size.height);
		}
		else {
			knobRect = NSMakeRect(thumbRc.size.width-knobImage.size.width, 2, knobImage.size.width, knobImage.size.height);
		}
		
		[knobImage drawInRect:knobRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	}
	*/
	[canvas unlockFocus];
	
	[canvas drawInRect:canvasRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
}

- (void)setDoubleValue:(double)doubleValue
{
	[super setDoubleValue:doubleValue];
	[self setNeedsDisplay:YES];
}

- (BOOL)mouseDownCanMoveWindow
{
	return NO;
}

- (BOOL)isFlipped
{	
	return NO;
}

@end
