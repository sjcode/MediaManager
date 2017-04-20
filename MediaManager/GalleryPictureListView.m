//
//  GalleryPictureListView.m
//  MediaManager
//
//  Created by Arthur on 6/13/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GalleryPictureListView.h"


@implementation GalleryPictureListView

- (id)initWithFrame:(NSRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect 
{
	NSRect bounds = self.bounds;
    
    // Draw background gradient
    NSGradient *gradient = [[NSGradient alloc] initWithColorsAndLocations:
                            [NSColor colorWithDeviceWhite:0.15f alpha:1.0f], 0.0f, 
                            //[NSColor colorWithDeviceWhite:0.19f alpha:1.0f], 0.5f, 
                            //[NSColor colorWithDeviceWhite:0.20f alpha:1.0f], 0.5f, 
                            //[NSColor colorWithDeviceWhite:0.25f alpha:1.0f], 1.0f, 
                            nil];
    
    [gradient drawInRect:bounds angle:90.0f];
    [gradient release];
    
    // Stroke bounds
    [[NSColor blackColor] setStroke];
    [NSBezierPath strokeRect:bounds];
}

@end
