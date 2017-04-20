//
//  MusicLibraryViewController.h
//  MediaManager
//
//  Created by Arthur on 5/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AlbumView.h"
#import "AlbumListView.h"
#import "AlbumItem.h"
#import "PlayControllerDelegate.h"
#import "MMSimpleListView.h"
#import "MMDetailListContentView.h"
#import "MMPopUpButtonCell.h"
#import "MMMusicListView.h"

enum  
{
	TableListView,
	GridListView
};
typedef NSUInteger SongShowMode;

enum  
{
	ShowMode_Song = 1,
	ShowMode_Album,
	ShowMode_Genre,
	ShowMode_Artist
};
typedef NSUInteger ShowMode;

enum  
{
	SortMode_Songs_AlbumArtist = 1,
	SortMode_Songs_SongName,
	SortMode_Songs_Time,
	SortMode_Songs_PlayCount,
	SortMode_Songs_FileSize,
	SortMode_Songs_RecentlyAdded
};
typedef NSUInteger SortMode_Songs;

enum  
{
	SortMode_Albums_AlbumName = 1,
	SortMode_Albums_ArtistName,
	SortMode_Albums_NumberOfSongs,
	SortMode_Albums_PlayCount,
	SortMode_Albums_RecentlyAdded,
	SortMode_Albums_Rating
};
typedef NSUInteger SortMode_Albums;

enum  
{
	SortMode_Genres_GenreName = 1,
	SortMode_Genres_NumberOfSongs,
	SortMode_Genres_PlayCount,
	SortMode_Genres_RecentlyAdded
};
typedef NSUInteger SortMode_Genres;

enum  
{
	SortMode_Artists_ArtistName = 1,
	SortMode_Artists_NumberOfAlbums,
	SortMode_Artists_PlayCount,
	SortMode_Artists_RecentlyAdded
};
typedef NSUInteger SortMode_Artists;

@interface MusicLibraryViewController : NSViewController <AlbumListViewDataSource,AlbumListViewDelegate>
{
	//IBOutlet AlbumListView *albumViewLayer;
	IBOutlet MMSimpleListView *simpleListView;
	IBOutlet MMDetailListContentView *detailListView;
	IBOutlet NSView *detailParentView;
	IBOutlet NSView *simpleParentView;
	
	
	IBOutlet NSPopUpButton *categoryButton;
	IBOutlet NSPopUpButton *sortMethodButton;
	
	NSImage *contentLine;
	NSMutableArray *albumArray;
	id<PlayControllerDelegate> delegate;
	
	NSView *previousRootView;
	NSView *previousDetailView;
	
	///////////////////////////////////////////////////
	IBOutlet NSScrollView *albumViewLayer;
	IBOutlet MMMusicListView *musicListView;
	NSMutableArray *musiclistArray;
	NSArray *musicArrayInLibrary;
}

@property (nonatomic,retain)id delegate;

- (void)toggleShowMode:(SongShowMode)mode;
- (IBAction)clickShowMode:(id)sender;
- (IBAction)clickSortMode:(id)sender;
- (IBAction)doubleClickTableView:(id)sender;

- (NSArray*)musicArrayInLibrary;

@end
