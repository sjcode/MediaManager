//
//  AlbumViewCell.h
//  MediaManager
//
//  Created by Arthur on 5/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AlbumImageView.h"
#import "ShadowView.h"

@protocol AlbumViewCellDelegate

@end


@interface AlbumViewCell : NSViewController<AlbumImageDelegate>
{
	NSInteger index;
	IBOutlet NSImageView *coverImageView;
	IBOutlet NSString *title;
	IBOutlet NSString *albumName;
	
	NSImageView *hoverImageView;
	ShadowView *shadowView;
	
	NSImageView *pushImageView;
	
	BOOL bClick;
	BOOL bhoverMouse;
}
@property (nonatomic,assign)NSInteger index;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *albumName;
@property (nonatomic,assign)BOOL bhoverMouse;

- (void)setImage:(NSImage *)image;
@end
