//
//  GalleryScrollPictureView.m
//  MediaManager
//
//  Created by Arthur on 6/14/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GalleryScrollPictureView.h"


@implementation GalleryScrollPictureView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
		scrollCanvas =[[NSView alloc]initWithFrame:frame];
		[[self contentView] addSubview:scrollCanvas];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    // Drawing code here.
}

@end
