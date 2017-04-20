//
//  SJFootView.m
//  MediaManager
//
//  Created by jian su on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SJFootView.h"

@implementation SJFootView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        backgroundImage = [NSImage imageNamed:@"bg_toolbar"];
        trackingArea = [[NSTrackingArea alloc] initWithRect:frame
                                                    options: (NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingActiveInKeyWindow )
                                                      owner:self userInfo:nil];
        [self addTrackingArea:trackingArea];
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [backgroundImage drawInRect:[self bounds]
                       fromRect:NSMakeRect(0.0f, 0.0f, backgroundImage.size.width, backgroundImage.size.height)
                      operation:NSCompositeSourceAtop
                       fraction:1.0f];
}
@end
