//
//  GalleryVideoCanvas.m
//  MediaManager
//
//  Created by Arthur on 6/10/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GalleryVideoCanvas.h"


@implementation GalleryVideoCanvas

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}


- (void)updateView:(NSImage*)image
{
	[self setImage:image];
	/*
	 if(frameImage != image)
	 {
	 [frameImage release];
	 [image retain];
	 frameImage = image;
	 //[self setNeedDisplay:YES];
	 }*/
}

- (void)drawRect:(NSRect)dirtyRect {
    if([self image])
    {
		if ([self inLiveResize])
		{
			CGRect rect = self.bounds;
			[[NSColor colorWithDeviceWhite:0.15f alpha:1.0f] set];
			NSRectFill(rect);
		}
		else {
			CGRect rect = self.bounds;
			[[NSColor colorWithDeviceWhite:0.15f alpha:1.0f] set];
			NSRectFill(rect);
			
			NSRect imageRect;
			NSSize imageSize;
			imageRect.size = [[self image] size];

			CGFloat screenAspectRatio = rect.size.width / rect.size.height;
			CGFloat imageAspectRatio = imageRect.size.width / rect.size.height;
			if(screenAspectRatio > imageAspectRatio)
			{
				//取高
				CGFloat n = rect.size.height / imageRect.size.height;
				imageSize = NSMakeSize(imageRect.size.width*n, rect.size.height);
			}
			else
			{
				//取宽
				CGFloat n = rect.size.width / imageRect.size.width;
				imageSize = NSMakeSize(rect.size.width, imageRect.size.height*n);
			}

			int x = rect.size.width/2 - imageSize.width/2;
			int y = 0;
			

			[[self image] drawInRect:NSMakeRect(x, y, imageSize.width, imageSize.height) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
		}
		
		
		
		// [previewImage release]; 
    }
}


@end
