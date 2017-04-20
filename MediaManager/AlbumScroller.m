//
//  AlbumScroller.m
//  MediaManager
//
//  Created by Arthur on 5/7/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AlbumScroller.h"

@implementation CustomWidthScroller

+(CGFloat)scrollerWidth
{
    return 10.0;
}

@end



@implementation AlbumScroller

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    // Drawing code here.
	[[NSColor colorWithDeviceRed:0.1490f green:0.1490f blue:0.1490f alpha:1.0f] set];
    NSRectFill(dirtyRect);
	
    // Call NSScroller's drawKnob method (or your own if you overrode it)
    [self drawKnob];
}

- (void)drawKnobSlotInRect:(NSRect)slotRect highlight:(BOOL)flag
{
	[[NSColor redColor] set];
    NSRectFill(slotRect);
}

- (void)drawKnob
{
	NSRect knobRect = [self rectForPart:NSScrollerKnob];
	[[NSColor colorWithDeviceRed:0.1961
						   green:0.1922 blue:0.1922 alpha:1.0]set];
	 NSRectFill(knobRect);
}




@end
