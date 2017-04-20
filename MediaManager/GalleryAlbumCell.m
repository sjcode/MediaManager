//
//  GalleryAlbumCell.m
//  MediaManager
//
//  Created by Arthur on 6/8/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GalleryAlbumCell.h"

@implementation GalleryAlbumCell
@synthesize index,filename,filedate,bhoverMouse,selected,displayimage,filepath,imagestate,progressIndicator,filetype;

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.

    }
    return self;
}

- (void)dealloc
{
	[filetype release];
	[filepath release];
	[filename release];
	[super dealloc];
}

- (void)drawRect:(NSRect)dirtyRect 
{
    // Drawing code here.

	[[NSColor colorWithDeviceRed:0.1961
						   green:0.1922 blue:0.1922 alpha:1.0]set];
	NSRectFill(dirtyRect);

	/*

	NSBezierPath *path = [[NSBezierPath alloc] init];
	[path setLineWidth:2];
	[path moveToPoint: NSMakePoint(NSMaxX(dirtyRect), NSMaxY(dirtyRect))];
	[path lineToPoint: NSMakePoint(NSMinX(dirtyRect), NSMaxY(dirtyRect))];
	[path lineToPoint: NSMakePoint(NSMinX(dirtyRect), NSMinY(dirtyRect) )];
	
	[path moveToPoint: NSMakePoint(NSMinX(dirtyRect), NSMinY(dirtyRect))];
	[path lineToPoint:NSMakePoint(NSMaxX(dirtyRect), NSMinY(dirtyRect))];	
	[path lineToPoint: NSMakePoint(NSMaxX(dirtyRect), NSMaxX(dirtyRect))];
	*/
	NSRect bounds = [self bounds];
	if(selected)
	{
		[[NSColor colorWithDeviceRed:0.5059 green:0.7451 blue:0.1961 alpha:1]set];
	}
	else 
	{
		[[NSColor colorWithDeviceRed:0.2471 green:0.2471 blue:0.2471 alpha:1]set];
	}
	
	//draw image
	if( displayimage != nil)
	{
		if([self.filetype caseInsensitiveCompare:@"picture"] == NSOrderedSame)
		{
			CGFloat x = 170/2-displayimage.size.width/2;
			CGFloat y = 170/2-displayimage.size.height/2;
			[displayimage drawInRect:NSMakeRect(x, y, displayimage.size.width, displayimage.size.height) fromRect:NSZeroRect operation:NSCompositeCopy fraction:1.0];
		}
		else if([self.filetype caseInsensitiveCompare:@"video"] == NSOrderedSame)
		{
			[displayimage drawInRect:NSMakeRect(0, 0, bounds.size.width, bounds.size.height) fromRect:NSZeroRect operation:NSCompositeCopy fraction:1.0];
		}
		else 
		{
			
		}

	}
	NSFrameRect(bounds);
	//[path stroke];
	//[path release];
}

- (BOOL)canDrawConcurrently
{
	return NO;
}

- (NSImage *)thumbnailImageFromImage:(NSImage*)image
{
	NSSize imageSize = [image size];
	if(imageSize.width==0 || imageSize.height==0)
		return nil;
	NSSize thumbnailSize;
	if(imageSize.width<170 && imageSize.height<170)
	{
		thumbnailSize = imageSize;
	}
	else 
	{
		if(imageSize.width > imageSize.height)
		{
			CGFloat imageAspectRatio = imageSize.height / imageSize.width;
			thumbnailSize = NSMakeSize(170,170*imageAspectRatio);
		}
		else 
		{
			CGFloat imageAspectRatio = imageSize.width / imageSize.height;
			thumbnailSize = NSMakeSize(170*imageAspectRatio,170);
		}
	}

    NSImage *thumbnailImage = [[NSImage alloc] initWithSize:thumbnailSize];
	
    [thumbnailImage lockFocus];
    [image drawInRect:NSMakeRect(0, 0, thumbnailSize.width, thumbnailSize.height) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];                
    [thumbnailImage unlockFocus];
	imagestate = THUMBNAIL_IMAGE_FINISH;

    return thumbnailImage;//[thumbnailImage autorelease];
}

- (void) loadImageInBackground:(NSString *)url
{
	imagestate = THUMBNAIL_IMAGE_LOADING;
	[[[MMSharedOperationQueue shareOperationQueue] instance] addOperationWithBlock:^(void) 
	 {
		 
		 //NSImage * lazyImage = [[[NSImage alloc] initByReferencingURL:
		//						 [NSURL URLWithString:@"http://londonwebdev.com/wp-content/uploads/2010/07/featured_hoe.png"]]
		//						autorelease];
		 NSImage *lazyImage = [[[NSImage alloc] initWithContentsOfFile:url]autorelease];
		 if (lazyImage != nil) 
		 {
			 NSImage *thumbnailImage = [self thumbnailImageFromImage:lazyImage];
			 if(thumbnailImage == nil)
				 return;
			 // We synchronize access to the image/imageLoading pair of variables
			 @synchronized (self) 
			 {
				 self.displayimage = thumbnailImage;
			 }
			 [self setNeedsDisplay:YES];
		 }
		 
	 }];
}

@end
