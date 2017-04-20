//
//  GalleryAlbumShadowView.h
//  MediaManager
//
//  Created by Arthur on 6/8/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface GalleryAlbumShadowView : NSView 
{
	NSMutableDictionary *attributes;
	NSString *filename;
	NSDate *filedate;
	NSImage *playImage;
}
@property (nonatomic,copy)NSString *filename;
@property (nonatomic,copy)NSDate *filedate;
@end
