//
//  GalleryAlbumShadowView.m
//  MediaManager
//
//  Created by Arthur on 6/8/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GalleryAlbumShadowView.h"
@interface GalleryAlbumShadowView(Private)
- (void)prepareTextAttributes;
- (void)drawStringCenterIn:(NSRect)r;
@end

@implementation GalleryAlbumShadowView
@synthesize filename,filedate;
- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
		//filename = @"";
		[self prepareTextAttributes];
		playImage = [NSImage imageNamed:@"musicoverplay"];
    }
    return self;
}


- (void)dealloc
{
	[attributes release];
	[filename release];
	[super dealloc];
}

- (void)prepareTextAttributes
{
	attributes = [[NSMutableDictionary alloc] init];
	[attributes setObject:[NSColor whiteColor] forKey:NSForegroundColorAttributeName];
	[attributes setObject:[NSFont fontWithName:@"Helvetica" size:12] forKey:NSFontAttributeName]; 
}

- (void)createHoverImage
{
	playImage = [NSImage imageNamed:@"musicoverplay"];
}

- (void)drawStringCenterIn:(NSRect)r
{
	NSSize strSize = [filename sizeWithAttributes:attributes];
	NSPoint strOrigin;
	strOrigin.x = r.origin.x + (r.size.width - strSize.width) / 2;
	strOrigin.y = 2;//r.origin.y + (r.size.height - strSize.height) / 2;
	[filename drawAtPoint:strOrigin withAttributes:attributes];
}

- (void)drawPlayImageCenterIn:(NSRect)frame
{
	NSPoint strOrigin;
	strOrigin.x = frame.origin.x + (frame.size.width - playImage.size.width)/2;
	strOrigin.y = frame.origin.y + (frame.size.height - playImage.size.height)/2;
	[playImage drawAtPoint:strOrigin fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
}

- (void)drawFileDataTime:(NSRect)frame
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
		
	NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
	[dateFormatter setLocale:usLocale];
	
	NSString *dateString = [NSString stringWithString:[dateFormatter stringFromDate:filedate]];
	
	NSSize strSize = [dateString sizeWithAttributes:attributes];
	NSPoint strOrigin;
	strOrigin.x = frame.origin.x + (frame.size.width - strSize.width) / 2;
	strOrigin.y = strSize.height+5;//r.origin.y + (r.size.height - strSize.height) / 2;
	[dateString drawAtPoint:strOrigin withAttributes:attributes];
	
	[dateFormatter release];
}

- (void)drawRect:(NSRect)dirtyRect {
    // Drawing code here.
	[[NSColor colorWithCalibratedRed:0.1490f green:0.1490f blue:0.1490 alpha:0.8f] set];
	NSRectFill(dirtyRect);
	[self drawPlayImageCenterIn:dirtyRect];
	[self drawFileDataTime:dirtyRect];
	[self drawStringCenterIn:dirtyRect];
}





@end
