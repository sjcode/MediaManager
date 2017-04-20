//
//  GalleryAlbumListView.h
//  MediaManager
//
//  Created by Arthur on 6/7/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "GalleryAlbumView.h"
#import "GalleryAlbumCell.h"
#import "AlbumScroller.h"
#import "GalleryAlbumShadowView.h"

#define GALLERY_ALBUM_WIDTH	170
#define GALLERY_ALBUM_HEIGHT 170
#define GALLERY_EACH_ALBUM_SPACE 5

extern NSString *const MMPropertyNamedThumbnailImage;

@interface MMDragRectangle : NSView
{
	
}

@end


@protocol GalleryAlbumListViewDataSource,GalleryAlbumListViewDelegate;
@interface GalleryAlbumListView : NSView 
{
	GalleryAlbumView *contentView;
	NSScrollView *scrollView;
	AlbumScroller *scroller;
	GalleryAlbumShadowView *shadowView;
	GalleryAlbumCell *lastHoverMouseCell;
	id<GalleryAlbumListViewDataSource> dataSource;
	id<GalleryAlbumListViewDelegate> delegate;
	
	NSPoint downPt;
	NSPoint movePt;
	BOOL bMouseDown;
	MMDragRectangle *dragRectangle;
	NSRect lastViewRect;
}
- (void)reloadData;

@property (nonatomic,retain) id dataSource;
@property (nonatomic,retain) id delegate;
@end

@protocol GalleryAlbumListViewDataSource
- (int)numberOfAlbum:(GalleryAlbumListView *)galleryAlbumListView;
- (id)albumlistView:(GalleryAlbumListView *)av row:(int)row;
@end

@protocol GalleryAlbumListViewDelegate
- (void)needPlayAlbum:(NSInteger)row;
@end