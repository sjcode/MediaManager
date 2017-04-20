//
//  GalleryAlbumCell.h
//  MediaManager
//
//  Created by Arthur on 6/8/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MMSharedOperationQueue.h"

enum  {
	THUMBNAIL_IMAGE_NONE,
	THUMBNAIL_IMAGE_LOADING,
	THUMBNAIL_IMAGE_FINISH
};
typedef NSUInteger MMThumbnailImageState;

@interface GalleryAlbumCell : NSView 
{
	NSProgressIndicator *progressIndicator;
	NSImage *displayimage;
	MMThumbnailImageState imagestate;
}
@property (nonatomic,copy)NSString *filetype;
@property (nonatomic,retain)NSProgressIndicator *progressIndicator;
@property (nonatomic,retain)NSImage *displayimage;
@property (nonatomic,copy)NSString *filepath;
@property (nonatomic,assign)NSUInteger index;
@property (nonatomic,copy)NSString *filename;
@property (nonatomic,copy)NSDate *filedate;
@property (nonatomic,assign)BOOL bhoverMouse;
@property (nonatomic,assign) BOOL selected;
@property (nonatomic,assign)MMThumbnailImageState imagestate;

- (void) loadImageInBackground:(NSString *)url;

@end
