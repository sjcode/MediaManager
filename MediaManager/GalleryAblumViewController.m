//
//  GalleryAblumViewController.m
//  MediaManager
//
//  Created by Arthur on 5/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GalleryAblumViewController.h"

@interface GalleryAblumViewController (Private)
- (void)changePopupButtonFirstTextColor:(NSColor*)color text:(NSString*)text button:(NSPopUpButton*)button;
@end


@implementation GalleryAblumViewController
//- (id)initWithNibNameAndFrame:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil frame:(NSRect)rect
//{
//	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//	NSInteger flag = NSViewMinXMargin | NSViewWidthSizable | NSViewMaxXMargin | NSViewMinYMargin | NSViewHeightSizable | NSViewMaxYMargin;
//	[[self view] setAutoresizingMask:flag];
//	return self;
//}
@synthesize delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
	{
		
	}
	return self;
}

- (void)loadView
{
	[super loadView];
	
}

- (void)awakeFromNib
{
	NSRect bounds = [[self view] bounds];
	[albumView setFrame:bounds];
	bounds.origin.x = 20;
	bounds.origin.y = 0;
	bounds.size.width -= 40;
	bounds.size.height -= 38;
	[galleryAlbumListView setFrame:bounds];
	[albumView addSubview:galleryAlbumListView];
	
	[[self view] addSubview:albumView];
	previousView = albumView;
	
	[self changePopupButtonFirstTextColor:[NSColor whiteColor] text:@"Album name" button:sortPopupButton];
	[galleryAlbumListView reloadData];
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

#pragma mark -- GalleryAblumListView DataSource
- (int)numberOfAlbum:(GalleryAlbumListView *)galleryAlbumListView
{
	return (int)[[MediaFileManager shareMediaFileManager].galleryArray count];
}

- (id)albumlistView:(GalleryAlbumListView *)av row:(int)row
{
	NSMutableDictionary *song = [[MediaFileManager shareMediaFileManager].galleryArray objectAtIndex:row];
	if(song)
	{
		return song;
	}
	
	return nil;
}

#pragma mark -- GalleryAblumListView Delegate
- (void)needPlayAlbum:(NSInteger)row
{
	NSMutableDictionary *album = [[MediaFileManager shareMediaFileManager].galleryArray objectAtIndex:row];
	if(album)
	{
		if([[album objectForKey:kGalleryTypeDataKey] caseInsensitiveCompare:@"video"] == NSOrderedSame)
		{
			if(delegate && [self.delegate respondsToSelector:@selector(needPlayVideoInCanvas:)])
			{
				[delegate needPlayVideoInCanvas:album];
			}
		}
		if([[album objectForKey:kGalleryTypeDataKey] caseInsensitiveCompare:@"picture"] == NSOrderedSame)
		{
			if(delegate && [self.delegate respondsToSelector:@selector(needOpenImageInArray:)])
			{
				[delegate needOpenImageInArray:[album objectForKey:kGalleryPathDataKey]];
			}
		}
	}
}
@end
