//
//  ShadowView.m
//  MediaManager
//
//  Created by Arthur on 5/7/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ShadowView.h"


@implementation ShadowView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {

	[[NSColor colorWithCalibratedRed:0.1490f green:0.1490f blue:0.1490 alpha:0.5] set];
	NSRectFill(dirtyRect);
}

@end
