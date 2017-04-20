//
//  GalleryAblumViewController.h
//  MediaManager
//
//  Created by Arthur on 5/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "GalleryAlbumListView.h"
#import "MediaFileManager.h"
#import "PlayControllerDelegate.h"

@interface GalleryAblumViewController : NSViewController 
{
	IBOutlet NSView *albumView;
	IBOutlet NSPopUpButton *sortPopupButton;
	
	IBOutlet GalleryAlbumListView *galleryAlbumListView;
	
	NSView *previousView;
	id<PlayControllerDelegate> delegate;
}
@property (nonatomic,retain)id delegate;
@end
