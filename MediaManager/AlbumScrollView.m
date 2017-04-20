//
//  AlbumScrollView.m
//  MediaManager
//
//  Created by Arthur on 5/17/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AlbumScrollView.h"


@implementation AlbumScrollView
@synthesize delegate;

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    // Drawing code here.
}

- (void)scrollWheel:(NSEvent *)theEvent
{
	if(delegate && [self.delegate respondsToSelector:@selector(albumScrollWheel:)])
	{
		[delegate albumScrollWheel:theEvent];
	}
	[super scrollWheel:theEvent];
}
@end
