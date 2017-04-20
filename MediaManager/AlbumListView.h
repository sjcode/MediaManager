//
//  AlbumListView.h
//  MediaManager
//
//  Created by Arthur on 5/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AlbumView.h"
#import "AlbumViewCell.h"
#import "AlbumScroller.h"
#import "AlbumScrollView.h"
#import "ShadowView.h"

#define ALBUM_WIDTH	130
#define ALBUM_HEIGHT 177
#define EACH_ALBUM_SPACE 20

@protocol AlbumListViewDataSource;
@protocol AlbumListViewDelegate;

enum ID3_TAG 
{
	ID3TAG_TITLE,
	ID3TAG_ARTIST,
	ID3TAG_ALBUM,
	ID3TAG_YEAR,
	ID3TAG_COMMENT,
	ID3TAG_TRACK,
	ID3TAG_GENRE,
	ID3TAG_IMAGE,
	ID3TAG_MAX
};

@interface AlbumListView : NSView<AlbumScrollViewDelegate> 
{
	id<AlbumListViewDataSource> source;
	id<AlbumListViewDelegate> delegate;
	NSMutableArray *albumArray;
	AlbumScrollView *scrollView;
	AlbumView *albumContentView;
	AlbumScroller *scroller;
	
	NSImageView *scrollImageView;
	
	AlbumViewCell *lastHoverMouseCell;
	
	ShadowView *shadowView;
	NSImageView *hoverImageView;
}

- (void)addAlbum:(NSString*)name;
- (void)reloadData;

@property (nonatomic, retain) id source;
@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) AlbumView *albumContentView;

@end


@protocol AlbumListViewDataSource <NSObject>
- (int)numberOfAlbum:(AlbumListView *)albumlistView;
- (id)albumlistView:(AlbumListView *)av objectValueForField:(int)field row:(int)row;
@end

@protocol AlbumListViewDelegate

- (void)needPlayAlbum:(NSInteger)row;

@end

