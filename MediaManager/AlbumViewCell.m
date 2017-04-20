//
//  AlbumViewCell.m
//  MediaManager
//
//  Created by Arthur on 5/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AlbumViewCell.h"
@interface AlbumViewCell (Private)
- (void)createHoverImage;
- (void)createShadowImage;
- (void)cretePauseImage;
- (void)merger;
@end


@implementation AlbumViewCell
@synthesize index,title,albumName,bhoverMouse;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//	NSShadow *dropShadow = [[NSShadow alloc] init];
//	[dropShadow setShadowColor:[NSColor blackColor]];
//	[dropShadow setShadowOffset:NSMakeSize(0, -10.0)];
//	[dropShadow setShadowBlurRadius:10.0];
//	
//	[[self view] setWantsLayer: YES];
//	[[self view ]setShadow: dropShadow];
//	
//	[dropShadow release];
	return self;
}

//- (void)addSubview:(NSView *)aView positioned:(NSWindowOrderingMode)place relativeTo:(NSView *)otherView
- (void)awakeFromNib
{
	//coverImageView.delegate = self;
	
	//[self createHoverImage];
	//[self createShadowImage];
	//[self cretePauseImage];
	//[self merger];

}

- (void)createHoverImage
{
	NSImage *hoverImage = [NSImage imageNamed:@"musicoverplay"];
	hoverImageView = [[NSImageView alloc]initWithFrame:NSMakeRect(0, 0, hoverImage.size.width, hoverImage.size.height)];
	
	NSRect cellRc = [coverImageView bounds];
	NSRect hoverRc = [hoverImageView bounds];
	int x = cellRc.size.width/2 - hoverRc.size.width/2;
	int y = (cellRc.size.height/2 + hoverRc.size.height);
	[hoverImageView setFrame:NSMakeRect(x, y, hoverRc.size.width, hoverRc.size.height)];
	[hoverImageView setImage:hoverImage];

	[hoverImage release];
}

- (void)createShadowImage
{
	NSRect rc = [[self view]bounds];
	shadowView = [[ShadowView alloc]initWithFrame:NSMakeRect(0, 0, rc.size.width, rc.size.height)];
	
}

- (void)cretePauseImage
{
	NSImage *pushImage = [NSImage imageNamed:@"MiniPause_normal"];
	pushImageView = [[NSImageView alloc]initWithFrame:NSMakeRect(0, 0, pushImage.size.width, pushImage.size.height)];
	
	NSRect cellRc = [coverImageView bounds];
	NSRect pushRc = [pushImageView bounds];
	int x = cellRc.size.width/2 - pushRc.size.width/2;
	int y = (cellRc.size.height/2 + pushRc.size.height/2)-5;
	[pushImageView setFrame:NSMakeRect(x, y, pushRc.size.width, pushRc.size.height)];
	[pushImageView setImage:pushImage];
	[pushImage release];
}

- (void)merger
{
	[[self view] addSubview:shadowView positioned:NSWindowAbove relativeTo:coverImageView];
	[shadowView setHidden:YES];
	
	[[self view] addSubview:hoverImageView positioned:NSWindowAbove relativeTo:shadowView];
	[hoverImageView setHidden:YES];
	
	[[self view] addSubview:pushImageView positioned:NSWindowAbove relativeTo:shadowView];
	[pushImageView setHidden:YES];
}

- (void)dealloc
{
	[shadowView release];
	[super dealloc];
}

- (void)setImage:(NSImage *)image
{
	if(image)
	{
		[coverImageView setImage:image];
		[image release];
	}
}

- (void)mouseEntered:(NSEvent *)event
{
	//NSLog(@"[%@] AlbumViewCell::mouseEntered",self);
//	if(!bClick)
//	{
//		[shadowView setHidden:NO];
//		[hoverImageView setHidden:NO];
//	}
}

- (void)mouseExited:(NSEvent *)event
{
	//NSLog(@"[%@] AlbumViewCell::mouseExited",self);
//	if(!bClick)
//	{
//		[shadowView setHidden:YES];
//		[hoverImageView setHidden:YES];
//	}
	
}

- (void)mouseDown:(NSEvent *)event
{
	//NSLog(@"[%@] AlbumViewCell::mouseDown",self);
//	if(!bClick)
//	{
//		[hoverImageView setHidden:YES];
//		[pushImageView setHidden:NO];
//	}
//	else 
//	{
//		[hoverImageView setHidden:NO];
//		[pushImageView setHidden:YES];
//	}
//	[shadowView setHidden:NO];
//	bClick = !bClick;
	NSAlert *alert = [[[NSAlert alloc] init] autorelease];
	[alert setMessageText:@"mouseDown."];
	[alert runModal];
}

- (void)mouseUp:(NSEvent *)event
{
	//NSLog(@"[%@] AlbumViewCell::mouseUp",self);
	NSAlert *alert = [[[NSAlert alloc] init] autorelease];
	[alert setMessageText:@"mouseUp."];
	[alert runModal];
}


@end
