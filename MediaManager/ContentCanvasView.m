//
//  ContentCanvasView.m
//  MediaManager
//
//  Created by Arthur on 5/31/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ContentCanvasView.h"


@implementation ContentCanvasView

- (id)initWithFrame:(NSRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
		contentLine = [NSImage imageNamed:@"bg_content_divide"];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect 
{
    // Drawing code here.
	
	NSRect rc = [self bounds];
	//rc.origin.x = 10;
	rc.origin.y = rc.size.height-38;
	//rc.size.width = dirtyRect.size.width-20;
	rc.size.height = contentLine.size.height;
	[contentLine drawInRect:rc fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
}

@end
