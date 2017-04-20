//
//  AlbumListView.m
//  MediaManager
//
//  Created by Arthur on 5/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AlbumListView.h"

@interface AlbumListView(Private)
- (void)layoutList;
- (void)createShadowImage;
- (void)createHoverImage;
@end

@implementation AlbumListView

@synthesize source,delegate,albumContentView;

- (id)initWithFrame:(NSRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
		
		NSRect contentRc = [self bounds];
		NSRect contentViewRect = NSMakeRect(0, 0, contentRc.size.width, contentRc.size.height);
		albumContentView = [[AlbumView alloc] initWithFrame:contentViewRect];
		[albumContentView setBounds:contentViewRect];
		[albumContentView setAutoresizingMask:(NSViewWidthSizable | NSViewHeightSizable)];
		
		scrollView = [[AlbumScrollView alloc]initWithFrame:NSMakeRect(0, 0, frame.size.width, frame.size.height)];
		scrollView.delegate = self;
		[scrollView setDrawsBackground:NO];
		[scrollView setBorderType:NSNoBorder];
		[scrollView setAutohidesScrollers:YES];
		[scrollView setHasVerticalScroller:YES];
		[scrollView setHasHorizontalScroller:NO];
		[scrollView setAutoresizingMask:(NSViewWidthSizable | NSViewHeightSizable)];
		
		scroller = [[AlbumScroller alloc]initWithFrame:NSMakeRect(0,0,10,contentRc.size.height)];
		[scrollView setVerticalScroller:scroller];
		
		[[scrollView contentView] setAutoresizesSubviews:YES];
		[[scrollView verticalScroller] setControlSize:NSSmallControlSize];
		[[scrollView verticalScroller] setArrowsPosition:NSScrollerArrowsNone];
		[[scrollView contentView] setAutoresizesSubviews:YES];
		
		
		[self addSubview:scrollView];
		[scrollView setDocumentView:albumContentView];
		[scrollImageView release];
		[scrollView release];
		albumArray = [[NSMutableArray alloc]init];
		
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mainWindowChanged:) name:NSViewFrameDidChangeNotification object:albumContentView];
    }
    return self;
}

- (void)dealloc
{
	[albumArray release];
	[shadowView release];
	[scrollView release];
	[albumContentView release];
	[scroller release];
	[scrollImageView release];
	[super dealloc];
}

- (void)awakeFromNib
{
	NSTrackingArea *trackingArea = [[[NSTrackingArea alloc] initWithRect:[self visibleRect]
									 // feed in NSTrackingMouseMoved to get mouseMoved: events too
																 options:NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingInVisibleRect |NSTrackingActiveAlways
																   owner:self
																userInfo:nil] autorelease];
	[self addTrackingArea:trackingArea];
}

- (void)mainWindowChanged:(NSNotification *)notification
{
	//NSClipView *changedContentView=[notification object];
    //NSRect changedBounds = [changedContentView bounds];

	[self layoutList];
}

- (void)drawRect:(NSRect)dirtyRect
{
    //[backgroundImage drawInRect:[self bounds]
	//                       fromRect:NSMakeRect(0.0f, 0.0f, backgroundImage.size.width, backgroundImage.size.height)
	//                      operation:NSCompositeSourceAtop
	//                       fraction:1.0f];
    
    //[[NSColor whiteColor] set];  //设置颜色
	//NSRectFill(dirtyRect);
}

- (void)viewWillStartLiveResize
{
	NSLog(@"viewWillStartLiveResize\n");
}

- (void)viewDidEndLiveResize
{
	NSLog(@"viewDidEndLiveResize\n");
}

- (void)reloadData
{
//	NSRect oldBounds = [albumContentView bounds];
//	NSRect contentViewRect = NSMakeRect(0, 0, oldBounds.size.width, oldBounds.size.height*10);
//	[albumContentView setFrame:contentViewRect];
//	return;
	
	NSInteger count = 0;
	if([self.source respondsToSelector:@selector(numberOfAlbum:)])
	{
		count = [source numberOfAlbum:self];
		NSLog(@"addAlbum count = %d\n",(int)count);
	}
	
	if(self.source && [self.source respondsToSelector:@selector(albumlistView:objectValueForField:row:)])
	{
		for(int index = 0; index < count; index++)
		{
			AlbumViewCell *cell = [[AlbumViewCell alloc] initWithNibName:@"AlbumViewCell" bundle:nil];
			cell.index = index;
			cell.title = [self.source albumlistView:self objectValueForField:ID3TAG_TITLE row:index];
			cell.albumName = [self.source albumlistView:self objectValueForField:ID3TAG_ALBUM row:index];
			[[cell view] setAutoresizingMask:(NSViewMaxXMargin|NSViewMinYMargin)];
			NSImage *image = [self.source albumlistView:self objectValueForField:ID3TAG_IMAGE row:index];
			if(!image)
			{
				image = [NSImage imageNamed:@"icon_music_thumbnail"];
			}
			[cell setImage:image];
			[albumContentView addSubview:[cell view]];
			[albumArray addObject:cell];
			[cell release];
			
			//self.source albumContentView
			//NSString *s = [self.source albumlistView:self titleForTabAtIndex:index];
			/*
			AlbumViewCell *cell = [[AlbumViewCell alloc] initWithNibName:@"AlbumViewCell" bundle:nil];
			cell.index = index;
			cell.title = [NSString stringWithFormat:@"title %02d",index+1];
			cell.albumName = [NSString stringWithFormat:@"albume name %02d",index+1];
			NSString *imageFile = [NSString stringWithFormat:@"%d.jpg",index%5+1];
			
			[[cell view] setAutoresizingMask:(NSViewMaxXMargin|NSViewMinYMargin)];
			[cell setImage:imageFile];
			
			[albumContentView addSubview:[cell view]];
			[albumArray addObject:cell];
			[cell release];
			 */
		}
	}
	
	[self createShadowImage];
	[self createHoverImage];
	[self layoutList];
}

- (void)layoutList
{
	NSRect viewRc = [[scrollView contentView] bounds];

	AlbumViewCell *cell = nil;
	int origin_x = 30;
	int origin_y = 0;
	int count = (int)[albumArray count];
	if(count==0)
		return;
	
	int rowMaxCount = (viewRc.size.width)/(ALBUM_WIDTH+EACH_ALBUM_SPACE);
	int fullline = (count<rowMaxCount) ? 1 : count/rowMaxCount;
	int remainline = (count<rowMaxCount) ? 0 : count%rowMaxCount;
	int index = 0;
	

	for(int i=0;i<fullline;i++)
	{
		if(i==0)
			origin_y = 0;
		else
			origin_y += ALBUM_HEIGHT+EACH_ALBUM_SPACE;
		origin_x = 30;
		for(int j = 0;j<rowMaxCount;j++)
		{
			cell = [albumArray objectAtIndex:index++];
			if(j==0)
				origin_x = 30;
			else
				origin_x += ALBUM_WIDTH+EACH_ALBUM_SPACE;
			NSRect newRect = NSMakeRect(origin_x,
										origin_y,
										ALBUM_WIDTH,
										ALBUM_HEIGHT);
			[[cell view ]setFrame:newRect];
			//[[[cell view] layer] setPosition:NSMakePoint(newRect.origin.x, newRect.origin.y)];
		}
	}
	origin_y += ALBUM_HEIGHT+EACH_ALBUM_SPACE;
	for(int r = 0;r<remainline;r++)
	{
		cell = [albumArray objectAtIndex:index++];
		if(r==0)
			origin_x = 0;
		else
			origin_x += ALBUM_WIDTH+EACH_ALBUM_SPACE;
		NSRect newRect = NSMakeRect(origin_x,
									origin_y,
									ALBUM_WIDTH,
									ALBUM_HEIGHT);
		[[cell view ]setFrame:newRect];
		//[[[cell view] layer] setPosition:NSMakePoint(newRect.origin.x, newRect.origin.y)];
	}
	//set view new frame
	NSRect oldBounds = [albumContentView bounds];
	[albumContentView setFrame:NSMakeRect(0, 0, oldBounds.size.width, origin_y)];
}

- (void)addAlbum:(NSString*)name
{
	NSLog(@"AlbumListView::addAlbum\n");
	
}

- (void)mouseMoved:(NSEvent *)theEvent
{
	NSPoint eyeCenter = [albumContentView convertPoint:[theEvent locationInWindow] fromView:nil];
	id obj;
	BOOL bFind = NO;
	for(obj in albumArray)
	{
		AlbumViewCell *cell = obj;
		if(cell)
		{
			NSRect viewFrame,imgFrame;
			viewFrame = [[cell view] frame];
			imgFrame = viewFrame;
			imgFrame.size.height = 119;
			
			BOOL isInside = [self mouse:eyeCenter inRect:imgFrame];
			if(isInside)
			{
				bFind = YES;
				if(cell != lastHoverMouseCell)
				{
					lastHoverMouseCell.bhoverMouse = NO;
					lastHoverMouseCell = cell;		
				}

				if(!cell.bhoverMouse)
				{
					//draw shadow
					[shadowView setFrame:imgFrame];
					[shadowView setHidden:NO];
					
					[hoverImageView setFrame:imgFrame];
					[hoverImageView setHidden:NO];
					
					lastHoverMouseCell = cell;
					cell.bhoverMouse = YES;
					return;
				}
			}
		}
	}
	if(!bFind)
	{
		[shadowView setHidden:YES];
		[hoverImageView setHidden:YES];
		for(obj in albumArray)
		{
			AlbumViewCell *cell = obj;
			cell.bhoverMouse = NO;
		}		
	}
}

- (void)mouseExited:(NSEvent *)event 
{
	id obj;
	for(obj in albumArray)
	{
		AlbumViewCell *cell = obj;
		if(cell)
		{
			cell.bhoverMouse = NO;
		}
	}
	lastHoverMouseCell = nil;
	[shadowView setHidden:YES];
	[hoverImageView setHidden:YES];
}

- (void)mouseDown:(NSEvent *)theEvent
{
	NSPoint eyeCenter = [albumContentView convertPoint:[theEvent locationInWindow] fromView:nil];
	id obj;
	for(obj in albumArray)
	{
		AlbumViewCell *cell = obj;
		if(cell)
		{
			NSRect viewFrame,imgFrame;
			viewFrame = [[cell view] frame];
			imgFrame = viewFrame;
			imgFrame.size.height = 119;
			
			BOOL isInside = [self mouse:eyeCenter inRect:imgFrame];
			if(isInside)
			{
				if(self.delegate && [self.delegate respondsToSelector:@selector(needPlayAlbum:)])
				{
					[delegate needPlayAlbum:cell.index];
				}
				
				return;
			}
		}
	}
}

- (void)albumScrollWheel:(NSEvent *)theEvent
{
	//[self mouseExited:theEvent];
}

- (void)createShadowImage
{
	shadowView = [[ShadowView alloc]initWithFrame:NSMakeRect(0, 0, ALBUM_WIDTH, ALBUM_HEIGHT-119)];
	[shadowView setAlphaValue:0.7f];
	[albumContentView addSubview:shadowView positioned:NSWindowAbove relativeTo:nil];
	[shadowView setHidden:YES];
}

- (void)createHoverImage
{
	NSImage *hoverImage = [NSImage imageNamed:@"musicoverplay"];
	hoverImageView = [[NSImageView alloc]initWithFrame:NSMakeRect(0, 0, hoverImage.size.width, hoverImage.size.height)];
	[hoverImageView setImage:hoverImage];
	
	[albumContentView addSubview:hoverImageView positioned:NSWindowAbove relativeTo:shadowView];
	
	[hoverImageView setHidden:YES];

	[hoverImage release];
}




@end
