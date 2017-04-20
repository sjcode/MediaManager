//
//  MusicLibraryViewController.m
//  MediaManager
//
//  Created by Arthur on 5/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MusicLibraryViewController.h"
#import "MediaFileManager.h"
#import "AlbumWrapper.h"
#import "ColorTextButton.h"
#import "MMMusicListBackgroundLayer.h"

@interface myImageObject : NSObject
{
	NSString *title;
	NSString *subTitle;
	NSData *data;
}

@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *subTitle;
@property (nonatomic,retain)NSData *data;
@end

@implementation myImageObject
@synthesize title,subTitle,data;

- (void)dealloc
{
    [title release];
	[subTitle release];
    [super dealloc];
}

- (NSString*)imageRepresentationType
{
	//return IKImageBrowserPathRepresentationType;
	return IKImageBrowserNSDataRepresentationType;
}

- (id)imageRepresentation
{
	return data;
}

- (NSString*)imageUID
{
    return title;
}

- (NSString*)imageTitle
{
    return title;
}

- (NSString*)imageSubtitle
{
    return subTitle;
}

@end

@interface MusicLibraryViewController ()
- (void)changePopupButtonFirstTextColor:(NSColor*)color  text:(NSString*)text  button:(NSPopUpButton*)button;
- (void)setPopupButtonTitle:(NSString*)text button:(NSPopUpButton*)button;
- (void)switchShowAndSortButton:(NSUInteger)showmode sort:(NSUInteger)sortmode;

@end


@implementation MusicLibraryViewController
@synthesize delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

	
	return self;
}

- (void)dealloc
{
	[musiclistArray release];
	[albumArray release];
	[super dealloc];
}

- (void)initializeMusicListView
{
    [musicListView setAllowsReordering:YES];
    [musicListView setAnimates:YES];
    [musicListView setDraggingDestinationDelegate:self];
	[musicListView setCellSize:NSMakeSize( 130,130)];
	
	// customize the appearance
	[musicListView setCellsStyleMask:IKCellsStyleTitled |  IKCellsStyleSubtitled |IKCellsStyleShadowed];
	
	// background layer
	MMMusicListBackgroundLayer *backgroundLayer = [[[MMMusicListBackgroundLayer alloc] init] autorelease];
	[musicListView setBackgroundLayer:backgroundLayer];
	backgroundLayer.owner = musicListView;
	backgroundLayer.delegate = self;
	
	
	// foreground layer
	//	ImageBrowserForegroundLayer *foregroundLayer = [[[ImageBrowserForegroundLayer alloc] init] autorelease];
	//	[imageBrowser setForegroundLayer:foregroundLayer];
	//	foregroundLayer.owner = imageBrowser;
	
	//-- change default font 
	// create a centered paragraph style
	NSMutableParagraphStyle *paraphStyle = [[[NSMutableParagraphStyle alloc] init] autorelease];
	[paraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
	[paraphStyle setAlignment:NSCenterTextAlignment];
	
	NSMutableDictionary *attributes = [[[NSMutableDictionary alloc] init] autorelease];	
	[attributes setObject:[NSFont systemFontOfSize:12] forKey:NSFontAttributeName]; 
	[attributes setObject:paraphStyle forKey:NSParagraphStyleAttributeName];	
	[attributes setObject:[NSColor whiteColor] forKey:NSForegroundColorAttributeName];
	[musicListView setValue:attributes forKey:IKImageBrowserCellsTitleAttributesKey];
	
	attributes = [[[NSMutableDictionary alloc] init] autorelease];	
	[attributes setObject:[NSFont systemFontOfSize:12] forKey:NSFontAttributeName]; 
	[attributes setObject:paraphStyle forKey:NSParagraphStyleAttributeName];	
	[attributes setObject:[NSColor whiteColor] forKey:NSForegroundColorAttributeName];
	[musicListView setValue:attributes forKey:IKImageBrowserCellsSubtitleAttributesKey];
	
	attributes = [[[NSMutableDictionary alloc] init] autorelease];	
	[attributes setObject:[NSFont boldSystemFontOfSize:12] forKey:NSFontAttributeName]; 
	[attributes setObject:paraphStyle forKey:NSParagraphStyleAttributeName];	
	[attributes setObject:[NSColor whiteColor] forKey:NSForegroundColorAttributeName];
	
	//[imageBrowser setValue:attributes forKey:IKImageBrowserCellsHighlightedTitleAttributesKey];	
	
	//change intercell spacing
	[musicListView setIntercellSpacing:NSMakeSize(10, 10)];
	
	
	//change selection color
	[musicListView setValue:[NSColor colorWithDeviceRed:0.5059 green:0.7451 blue:0.1961 alpha:1] forKey:IKImageBrowserSelectionColorKey];
	
	//set initial zoom value
	//[imageBrowser setZoomValue:0.5];
}

- (void)awakeFromNib
{	
	//[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mainWindowChanged:) name:NSViewFrameDidChangeNotification object:nil];
	NSRect bounds = [[self view] bounds];
	[detailParentView setFrame:bounds];
	bounds.origin.x = 30;
	bounds.origin.y = 0;
	bounds.size.width -= 60;
	bounds.size.height -= 38;
	
	//[musicListView setFrame:bounds];
	[albumViewLayer setFrame:bounds];
	
	[detailParentView addSubview:albumViewLayer];
	[[self view] addSubview:detailParentView];
	
	previousRootView = detailParentView;
	previousDetailView = albumViewLayer;
	[self changePopupButtonFirstTextColor:[NSColor whiteColor] text:@"Show:Album" button:categoryButton];
	[categoryButton selectItemAtIndex:1];
	//[self changePopupButtonFirstTextColor:[NSColor whiteColor] text:@"Sort:Album Name" button:sortMethodButton];
	[self switchShowAndSortButton:1 sort:1];
	
	//[[[self view] window] makeFirstResponder:albumViewLayer.albumContentView];
	//[simpleListView setDoubleAction:@selector(doubleClickTableView:)];
	
	[self initializeMusicListView];
	
	musiclistArray = [[NSMutableArray alloc]init];
	musicArrayInLibrary = [self musicArrayInLibrary];
	NSEnumerator *enumerator = [musicArrayInLibrary objectEnumerator];
	NSManagedObject *song;
	while(song = [enumerator nextObject])
	{
		myImageObject *p = [[[myImageObject alloc]init]autorelease];
		p.title = [song valueForKey:@"MusicTitle"];
		p.subTitle = [song valueForKey:@"MusicAlbum"];
		NSData *data = [song valueForKey:@"MusicImage"];
		if(data == nil)
		{
			data = [[NSImage imageNamed:@"icon_music_thumbnail"]TIFFRepresentation];
		}
		p.data = data;
		[musiclistArray addObject:p];
	}
	
	[musicListView reloadData];
	[detailListView reloadData];
}

- (void)mainWindowChanged:(NSNotification *)notification
{
	// [self setMainWindow:[notification object]];
	
	
	NSLog(@"mainWindowChanged\n");
	
}

- (void)loadView
{
	[super loadView];
	
}

- (void)addAlbum
{
	
	
}

- (NSArray*)musicArrayInLibrary
{
	if(!musicArrayInLibrary)
	{
		musicArrayInLibrary = [[MediaFileManager shareMediaFileManager] musicArrayInLibrary];
	}
	return musicArrayInLibrary;
}

#pragma mark -
#pragma mark MMMusicListViewSource

- (NSUInteger)numberOfItemsInImageBrowser:(IKImageBrowserView*)view
{
    return [musiclistArray count];
	//return [[MediaFileManager sharedInstance] musicCount];
}

- (id)imageBrowser:(IKImageBrowserView *) view itemAtIndex:(NSUInteger) index
{
    //return [images objectAtIndex:index];
	return [musiclistArray objectAtIndex:index];
	
}

//- (BOOL)imageBrowser:(IKImageBrowserView*)aBrowser moveItemsAtIndexes: (NSIndexSet*)indexes toIndex:(unsigned int)destinationIndex
//{
//	NSInteger		index;
//	NSMutableArray*	temporaryArray;
//	
//	temporaryArray = [[[NSMutableArray alloc] init] autorelease];
//	
//	// First remove items from the data source and keep them in a temporary array.
//	for (index = [indexes lastIndex]; index != NSNotFound; index = [indexes indexLessThanIndex:index])
//	{
//		if (index < destinationIndex)
//			destinationIndex --;
//		
//		id obj = [images objectAtIndex:index];
//		[temporaryArray addObject:obj];
//		[images removeObjectAtIndex:index];
//	}
//	
//	// Then insert the removed items at the appropriate location.
//	NSInteger n = [temporaryArray count];
//	for (index = 0; index < n; index++)
//	{
//		[images insertObject:[temporaryArray objectAtIndex:index] atIndex:destinationIndex];
//	}
//	
//	return YES;
//}


#pragma mark -

- (int)numberOfAlbum:(AlbumListView *)albumlistView
{
	return (int)[[MediaFileManager shareMediaFileManager].songArray count];
}

- (id)albumlistView:(AlbumListView *)av objectValueForField:(int)field row:(int)row
{
	NSMutableDictionary *song = [[MediaFileManager shareMediaFileManager].songArray objectAtIndex:row];
	if(song)
	{
		switch (field) 
		{
			case ID3TAG_TITLE:
				return [song valueForKey:kMusicTitleDataKey];
			case ID3TAG_ARTIST:
				return [song valueForKey:kMusicArtistDataKey];
			case ID3TAG_ALBUM:
				return [song valueForKey:kMusicAlbumDataKey];
			case ID3TAG_YEAR:
				return [song valueForKey:kMusicYearDataKey];
			case ID3TAG_COMMENT:
				return [song valueForKey:kMusicCommentDataKey];
			case ID3TAG_TRACK:
				return [song valueForKey:kMusicTrackDataKey];
			case ID3TAG_GENRE:
				return [song valueForKey:kMusicGenreDataKey];
			case ID3TAG_IMAGE:
				return [song valueForKey:kMusicImageDataKey];
			default:
				break;				
		}
	}
	
	return nil;
}

- (void)needPlayAlbum:(NSInteger)row
{
	
	//AVAudioPlayer* audioPlayer;
	//NSSound *mySound = [[NSSound alloc] initWithContentsOfFile:@"/Users/Arthur/1.mp3" byReference:YES]; 
	//[mySound play];
	NSMutableDictionary *song = [[MediaFileManager shareMediaFileManager].songArray objectAtIndex:row];
	if(self.delegate && [self.delegate respondsToSelector:@selector(needPlayMusic:)])
	{
		[self.delegate needPlayMusic:song];
	}
}

- (void)toggleShowMode:(SongShowMode)mode
{
//	[NSAnimationContext beginGrouping];
//	
//	// With the shift key down, do slow-mo animation
//	if ([[NSApp currentEvent] modifierFlags] & NSShiftKeyMask)
//	    [[NSAnimationContext currentContext] setDuration:1.0];
//	
//	// Call the animator instead of the view / window directly
//	[[[[self window] contentView] animator] replaceSubview:previousView with:view];
//	[[[self window] animator] setFrame:newFrame display:YES];
//	
//	[NSAnimationContext endGrouping];
	
	NSRect bounds = [[self view] bounds];
//	bounds.origin.x = 20;
//	bounds.origin.y = 10;
//	bounds.size.width -= 40;
//	bounds.size.height -= 10;
	
//	bounds.origin.x = 30;
//	bounds.origin.y = 0;
//	bounds.size.width -= 60;
//	bounds.size.height -= 38;
	
	[NSAnimationContext beginGrouping];
	if ([[NSApp currentEvent] modifierFlags] & NSShiftKeyMask)
	    [[NSAnimationContext currentContext] setDuration:1.0];
	switch (mode) 
	{
		case TableListView:
			[[[self view]animator] replaceSubview:previousRootView with:simpleParentView];
			previousRootView = simpleParentView;
			[previousRootView setFrame:bounds];
			break;
		case GridListView:
			[[[self view]animator] replaceSubview:previousRootView with:detailParentView];
			previousRootView = detailParentView;
			[previousRootView setFrame:bounds];
			break;
		default:
			break;
	}
	[NSAnimationContext endGrouping];
}

#pragma mark -
#pragma mark NSTableView Source
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tv
{
	//return (int)[[MediaFileManager shareMediaFileManager].songArray count];
	NSInteger count = [[MediaFileManager shareMediaFileManager]musicCount];
	return count;
}

- (id)tableView:(NSTableView *)tv objectValueForTableColumn:(NSTableColumn *)tableColume row:(int)row
{
	/*
	NSMutableDictionary *song = [[MediaFileManager shareMediaFileManager].songArray objectAtIndex:row];
	if(song)
	{
		if([[tableColume identifier] isEqualToString:kMusicDurationDataKey])
		{
			int hours, mins, secs;
			secs = [[song valueForKey:[tableColume identifier]] intValue];
			mins = secs / 60;
			secs %= 60;
			hours = mins / 60;
			mins %= 60;
			return [NSString stringWithFormat:@"%02d:%02d",mins,secs ];
		}
		return [song valueForKey:[tableColume identifier]];
	}
	return nil;
	 */
	NSManagedObject *song = [[self musicArrayInLibrary] objectAtIndex:row];
	if(song)
	{
		if([[tableColume identifier] isEqualToString:kMusicDurationDataKey])
		{
			int hours, mins, secs;
			secs = [[song valueForKey:@"MusicDuration"] intValue];
			mins = secs / 60;
			secs %= 60;
			hours = mins / 60;
			mins %= 60;
			return [NSString stringWithFormat:@"%02d:%02d",mins,secs ];
		}
		if([[tableColume identifier] isEqualToString:kMusicTitleDataKey])
		{
			NSString *title = [song valueForKey:@"MusicTitle"];
			return title;
		}
		if([[tableColume identifier] isEqualToString:kMusicAlbumDataKey])
		{
			return [song valueForKey:@"MusicAlbum"];
		}
		if([[tableColume identifier] isEqualToString:kMusicArtistDataKey])
		{
			return [song valueForKey:@"MusicArtist"];
		}
	}
	return nil;
}

- (void)tableViewNeedPlaySong:(id)obj
{
	if(self.delegate && [self.delegate respondsToSelector:@selector(needPlayMusic:)])
	{
		[self.delegate needPlayMusic:obj];
		
	}
}

- (IBAction)doubleClickTableView:(id)sender
{
	NSLog(@"doubleClickTableView");
	NSInteger row = [simpleListView selectedRow];
	if(row == -1)
	{
		return;
	}
	
	NSMutableDictionary *song = [[MediaFileManager shareMediaFileManager].songArray objectAtIndex:row];
	[self performSelectorOnMainThread:@selector(tableViewNeedPlaySong:) withObject:song waitUntilDone:NO];
}

//- (void)tableViewSelectionDidChange:(NSNotification *)notification
//{
//	NSInteger row = [simpleListView selectedRow];
//	if(row == -1)
//	{
//		return;
//	}
//	
//	NSMutableDictionary *song = [[MediaFileManager shareMediaFileManager].songArray objectAtIndex:row];
//	//[self performSelectorOnMainThread:@selector(tableViewNeedPlaySong:) withObject:song waitUntilDone:NO];
//}

- (void)tableView:(NSTableView *)tableView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
	//设置row的文字颜色为白色
	if ([cell isKindOfClass:[NSTextFieldCell class]]) 
	{
		[cell setTextColor: [NSColor whiteColor]];
	}
}

- (void)sortWithDescriptor:(id)descriptor
{
	NSMutableArray *sorted = [[NSMutableArray alloc] initWithCapacity:1];
	[sorted addObjectsFromArray:[[MediaFileManager shareMediaFileManager].songArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:descriptor]]];
	[[MediaFileManager shareMediaFileManager].songArray removeAllObjects];
	[[MediaFileManager shareMediaFileManager].songArray addObjectsFromArray:sorted];
	[simpleListView reloadData];
	[sorted release];
}

- (void)tableView:(NSTableView *)tableView didClickTableColumn:(NSTableColumn *)tableColumn 
{	
	NSArray *allColumns=[simpleListView tableColumns];
	NSInteger i;
	//遍历所有的列信息
	for (i=0; i<[simpleListView numberOfColumns]; i++) 
	{
		NSTableColumn *column = [allColumns objectAtIndex:i];
		if (column!=tableColumn)
		{
			//移除非排序的列上的排序图片
			[(MMSimpleListCell*)[column headerCell] setNeedSort:NO];
		}
		else 
		{
			//设置排序列上的排序图片
			[(MMSimpleListCell*)[column headerCell] setNeedSort:YES];
			BOOL bAscending = [(MMSimpleListCell*)[column headerCell] sortAscending];
			if(bAscending)
			{
				//升序
				NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc] initWithKey:[tableColumn identifier] ascending:YES];
				[self sortWithDescriptor:sortDesc];
				[sortDesc release];
			}
			else 
			{	
				//降序
				NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc] initWithKey:[tableColumn identifier] ascending:NO];
				[self sortWithDescriptor:sortDesc];
				[sortDesc release];
			}
		}
	}
	//[mytableView setHighlightedTableColumn:tableColumn];  //设置column高亮,触发MyTableHeaderCell::highlight函数,来绘制高亮
}

#pragma mark -
#pragma mark detailView
- (int)numberOfRowsInListView:(MMDetailListContentView *)v
{
	return (int)[[MediaFileManager shareMediaFileManager].songArray count];
}

- (id)detailListContentView:(MMDetailListContentView *)v row:(int)row
{
	NSInteger count = [[MediaFileManager shareMediaFileManager].songArray count];
	if(count == 0)
		return nil;
	id customData = [[MediaFileManager shareMediaFileManager].songArray objectAtIndex:row];
	if(customData)
		return customData;
	return nil;
}

- (void)switchShowAndSortButton:(NSUInteger)showmode sort:(NSUInteger)sortmode
{
	[sortMethodButton removeAllItems];
	[sortMethodButton addItemWithTitle:@"Sort:"];
	NSRect bounds = [[self view] bounds];
	//[detailParentView setFrame:bounds];
	//bounds.origin.x = 30;
	bounds.origin.y = 0;
	//bounds.size.width -= 60;
	bounds.size.height -= 38;
	[previousDetailView retain]; //必须的,否则replaceSubview会被release
	[NSAnimationContext beginGrouping];

	switch (showmode) 
	{
		case ShowMode_Song:
			[self changePopupButtonFirstTextColor:[NSColor whiteColor] text:@"Show:Songs" button:categoryButton];
			[sortMethodButton addItemWithTitle:@"Album/Artist"];
			[sortMethodButton addItemWithTitle:@"Song Name"];
			[sortMethodButton addItemWithTitle:@"Time"];
			[sortMethodButton addItemWithTitle:@"Play Count"];
			[sortMethodButton addItemWithTitle:@"File Size"];
			[sortMethodButton addItemWithTitle:@"Recently Added"];
			switch (sortmode) 
			{
				case SortMode_Songs_AlbumArtist:
					{
						[[detailParentView animator] replaceSubview:previousDetailView with:albumViewLayer];
						previousDetailView = albumViewLayer;
						[previousDetailView setFrame:bounds];
						[self changePopupButtonFirstTextColor:[NSColor whiteColor] text:@"Sort:Album/Artist" button:sortMethodButton];
					}
					break;
				case SortMode_Songs_SongName:
					{
						[[detailParentView animator] replaceSubview:previousDetailView with:detailListView];
						previousDetailView = detailListView;
						[previousDetailView setFrame:bounds];
						[self changePopupButtonFirstTextColor:[NSColor whiteColor] text:@"Sort:Song Name" button:sortMethodButton];
						
						NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc] initWithKey:kMusicTitleDataKey ascending:YES];
						[self sortWithDescriptor:sortDesc];
						[detailListView reloadData];
						[sortDesc release];
						
					}
					break;
				case SortMode_Songs_Time:
					{
						[[detailParentView animator] replaceSubview:previousDetailView with:detailListView];
						previousDetailView = detailListView;
						[previousDetailView setFrame:bounds];
						[self changePopupButtonFirstTextColor:[NSColor whiteColor] text:@"Sort:Time" button:sortMethodButton];
						
						NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc] initWithKey:kMusicDurationDataKey ascending:YES];
						[self sortWithDescriptor:sortDesc];
						[detailListView reloadData];
						[sortDesc release];
					}
					break;
				case SortMode_Songs_PlayCount:
					{
						[[detailParentView animator] replaceSubview:previousDetailView with:detailListView];
						previousDetailView = detailListView;
						[previousDetailView setFrame:bounds];
						[self changePopupButtonFirstTextColor:[NSColor whiteColor] text:@"Sort:Play Count" button:sortMethodButton];
						
						NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc] initWithKey:kMusicDurationDataKey ascending:YES];
						[self sortWithDescriptor:sortDesc];
						[detailListView reloadData];
						[sortDesc release];
					}
					break;
				case SortMode_Songs_FileSize:
					{
						[[detailParentView animator] replaceSubview:previousDetailView with:detailListView];
						previousDetailView = detailListView;
						[previousDetailView setFrame:bounds];
						[self changePopupButtonFirstTextColor:[NSColor whiteColor] text:@"Sort:File Size" button:sortMethodButton];
						
						NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc] initWithKey:kMusicDurationDataKey ascending:YES];
						[self sortWithDescriptor:sortDesc];
						[detailListView reloadData];
						[sortDesc release];
					}
					break;
				case SortMode_Songs_RecentlyAdded:
					{
						[[detailParentView animator] replaceSubview:previousDetailView with:detailListView];
						previousDetailView = detailListView;
						[previousDetailView setFrame:bounds];
						[self changePopupButtonFirstTextColor:[NSColor whiteColor] text:@"Sort:Recently Added" button:sortMethodButton];
						NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc] initWithKey:kMusicDurationDataKey ascending:YES];
						[self sortWithDescriptor:sortDesc];
						[detailListView reloadData];
						[sortDesc release];
					}
					break;
			}
			break;
		case ShowMode_Album:
			[self changePopupButtonFirstTextColor:[NSColor whiteColor] text:@"Show:Album" button:categoryButton];
			[sortMethodButton addItemWithTitle:@"Album Name"];
			[sortMethodButton addItemWithTitle:@"Artist Name"];
			[sortMethodButton addItemWithTitle:@"Number of Songs"];
			[sortMethodButton addItemWithTitle:@"Play Count"];
			[sortMethodButton addItemWithTitle:@"Recently Added"];
			[sortMethodButton addItemWithTitle:@"Rating"];
			switch(sortmode)
			{
				case SortMode_Albums_AlbumName:
					{
						[[detailParentView animator] replaceSubview:previousDetailView with:albumViewLayer];
						previousDetailView = albumViewLayer;
						[previousDetailView setFrame:bounds];
						[self changePopupButtonFirstTextColor:[NSColor whiteColor] text:@"Sort:Album Name" button:sortMethodButton];
					}
					break;
				case SortMode_Albums_ArtistName:
					{
						[[detailParentView animator] replaceSubview:previousDetailView with:albumViewLayer];
						previousDetailView = albumViewLayer;
						[previousDetailView setFrame:bounds];
						[self changePopupButtonFirstTextColor:[NSColor whiteColor] text:@"Sort:Artist Name" button:sortMethodButton];
					}
					break;
				case SortMode_Albums_NumberOfSongs:
					{
						[[detailParentView animator] replaceSubview:previousDetailView with:albumViewLayer];
						previousDetailView = albumViewLayer;
						[previousDetailView setFrame:bounds];
						[self changePopupButtonFirstTextColor:[NSColor whiteColor] text:@"Sort:Number Of Songs" button:sortMethodButton];
					}
					break;
				case SortMode_Albums_PlayCount:
					{
						[[detailParentView animator] replaceSubview:previousDetailView with:albumViewLayer];
						previousDetailView = albumViewLayer;
						[previousDetailView setFrame:bounds];
						[self changePopupButtonFirstTextColor:[NSColor whiteColor] text:@"Sort:Play Count" button:sortMethodButton];
					}
					break;
				case SortMode_Albums_RecentlyAdded:
					{
						[[detailParentView animator] replaceSubview:previousDetailView with:albumViewLayer];
						previousDetailView = albumViewLayer;
						[previousDetailView setFrame:bounds];
						[self changePopupButtonFirstTextColor:[NSColor whiteColor] text:@"Sort:Recently Added" button:sortMethodButton];
					}
					break;
				case SortMode_Albums_Rating:
					{
						[[detailParentView animator] replaceSubview:previousDetailView with:albumViewLayer];
						previousDetailView = albumViewLayer;
						[previousDetailView setFrame:bounds];
						[self changePopupButtonFirstTextColor:[NSColor whiteColor] text:@"Sort:Rating" button:sortMethodButton];
					}
					break;
			}
			break;
		case ShowMode_Genre:
			[self changePopupButtonFirstTextColor:[NSColor whiteColor] text:@"Show:Genre" button:categoryButton];
			[sortMethodButton addItemWithTitle:@"Genre Name"];
			[sortMethodButton addItemWithTitle:@"Number of Songs"];
			[sortMethodButton addItemWithTitle:@"Play Count"];
			[sortMethodButton addItemWithTitle:@"Recently Added"];
			switch(sortmode)
			{
				case SortMode_Genres_GenreName:
					{
						
						[[detailParentView animator] replaceSubview:previousDetailView with:albumViewLayer];
						previousDetailView = albumViewLayer;
						[previousDetailView setFrame:bounds];
						[self changePopupButtonFirstTextColor:[NSColor whiteColor] text:@"Sort:Genre Name" button:sortMethodButton];
					}
					break;
				case SortMode_Genres_NumberOfSongs:
					{
						[[detailParentView animator] replaceSubview:previousDetailView with:albumViewLayer];
						previousDetailView = albumViewLayer;
						[previousDetailView setFrame:bounds];
						[self changePopupButtonFirstTextColor:[NSColor whiteColor] text:@"Sort:Number Of Songs" button:sortMethodButton];
					}
					break;
				case SortMode_Genres_PlayCount:
					{
						[[detailParentView animator] replaceSubview:previousDetailView with:albumViewLayer];
						previousDetailView = albumViewLayer;
						[previousDetailView setFrame:bounds];
						[self changePopupButtonFirstTextColor:[NSColor whiteColor] text:@"Sort:Play Count" button:sortMethodButton];
					}
					break;
				case SortMode_Genres_RecentlyAdded:
					{
						[[detailParentView animator] replaceSubview:previousDetailView with:albumViewLayer];
						previousDetailView = albumViewLayer;
						[previousDetailView setFrame:bounds];
						[self changePopupButtonFirstTextColor:[NSColor whiteColor] text:@"Sort:Rencently Added" button:sortMethodButton];
					}
					break;
			}			
			break;
		case ShowMode_Artist:
			[self changePopupButtonFirstTextColor:[NSColor whiteColor] text:@"Show:Artist" button:categoryButton];
			[sortMethodButton addItemWithTitle:@"Artist Name"];
			[sortMethodButton addItemWithTitle:@"Number of Albums"];
			[sortMethodButton addItemWithTitle:@"Play Count"];
			[sortMethodButton addItemWithTitle:@"Recently Added"];
			switch(sortmode)
			{
				case SortMode_Artists_ArtistName:
					{
						[[detailParentView animator] replaceSubview:previousDetailView with:albumViewLayer];
						previousDetailView = albumViewLayer;
						[previousDetailView setFrame:bounds];
						[self changePopupButtonFirstTextColor:[NSColor whiteColor] text:@"Sort:Artist Name" button:sortMethodButton];
					}
					break;
				case SortMode_Artists_NumberOfAlbums:
					{
						[[detailParentView animator] replaceSubview:previousDetailView with:albumViewLayer];
						previousDetailView = albumViewLayer;
						[previousDetailView setFrame:bounds];
						[self changePopupButtonFirstTextColor:[NSColor whiteColor] text:@"Sort:Number Of Albums" button:sortMethodButton];
					}
					break;
				case SortMode_Artists_PlayCount:
					{
						[[detailParentView animator] replaceSubview:previousDetailView with:albumViewLayer];
						previousDetailView = albumViewLayer;
						[previousDetailView setFrame:bounds];
						[self changePopupButtonFirstTextColor:[NSColor whiteColor] text:@"Sort:Play Count" button:sortMethodButton];
					}
					break;
				case SortMode_Artists_RecentlyAdded:
					{
						[[detailParentView animator] replaceSubview:previousDetailView with:albumViewLayer];
						previousDetailView = albumViewLayer;
						[previousDetailView setFrame:bounds];
						[self changePopupButtonFirstTextColor:[NSColor whiteColor] text:@"Sort:Recently Aded" button:sortMethodButton];
					}
					break;
			}
			break;
		default:
			break;
	}
	[NSAnimationContext endGrouping];
}

- (IBAction)clickShowMode:(id)sender
{
	NSUInteger selected = [categoryButton indexOfSelectedItem];
	[self switchShowAndSortButton:selected sort:1];
}

- (IBAction)clickSortMode:(id)sender
{
	NSUInteger showMode = [categoryButton indexOfSelectedItem];
	NSUInteger sortMode = [sortMethodButton indexOfSelectedItem];
	[self switchShowAndSortButton:showMode sort:sortMode];
}

- (void)changePopupButtonFirstTextColor:(NSColor*)color text:(NSString*)text button:(NSPopUpButton*)button
{
	NSArray *itemArray = [button itemArray];
	NSDictionary *attributes = [NSDictionary
								dictionaryWithObjectsAndKeys:
								color, NSForegroundColorAttributeName,
								[NSFont systemFontOfSize: [NSFont systemFontSize]],
								NSFontAttributeName, nil];
	
	NSMenuItem *item = [itemArray objectAtIndex:0];
	[item setTitle:text];
	NSAttributedString *as = [[NSAttributedString alloc] 
							  initWithString:[item title]
							  attributes:attributes];
	
	[item setAttributedTitle:as];
}


@end
