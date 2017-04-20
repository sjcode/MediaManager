//
//  GalleryAlbumListView.m
//  MediaManager
//
//  Created by Arthur on 6/7/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GalleryAlbumListView.h"
#import "MediaFileManager.h"

NSString *const MMPropertyNamedThumbnailImage = @"displayimage";

@implementation MMDragRectangle

- (id)initWithFrame:(NSRect)frame {
	if(self = [super initWithFrame:frame])
	{
	}
	return self;
}

- (void)drawRect:(NSRect)dirtyRect {
	[[NSColor colorWithDeviceRed:0.5059 green:0.7451 blue:0.1961 alpha:1]set];
	
	NSFrameRect(dirtyRect);
	[[NSColor colorWithDeviceRed:0.5059 green:0.7451 blue:0.1961 alpha:0.4]set];
	dirtyRect.origin.x = 1;
	dirtyRect.origin.y = 1;
	dirtyRect.size.width -= 2;
	dirtyRect.size.height -= 2;
	NSRectFill(dirtyRect);	
}

@end


@interface GalleryAlbumListView()
- (void)layoutList;
- (void)createShadowImage;
- (NSMutableArray*)galleryAlbumCellArray;
@end

@implementation GalleryAlbumListView
@synthesize dataSource,delegate;

- (id)initWithFrame:(NSRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) 
	{
        // Initialization code here.
		NSRect contentViewRect = [self bounds];
		
		contentView = [[GalleryAlbumView alloc]initWithFrame:contentViewRect];
		[contentView setAutoresizingMask:(NSViewWidthSizable | NSViewHeightSizable)];
		
		scrollView = [[NSScrollView alloc]initWithFrame:NSMakeRect(0, 0, frame.size.width, frame.size.height)];
		
		[scrollView setDrawsBackground:NO];
		[scrollView setBorderType:NSNoBorder];
		[scrollView setAutohidesScrollers:YES];
		[scrollView setHasVerticalScroller:YES];
		[scrollView setHasHorizontalScroller:NO];
		[scrollView setAutoresizingMask:(NSViewWidthSizable | NSViewHeightSizable)];
		scroller = [[AlbumScroller alloc]initWithFrame:NSMakeRect(0,0,5,contentViewRect.size.height)];
		[scrollView setVerticalScroller:scroller];
		[[scrollView contentView] setAutoresizesSubviews:YES];
		[[scrollView verticalScroller] setControlSize:NSSmallControlSize];
		[[scrollView verticalScroller] setArrowsPosition:NSScrollerArrowsNone];
		[[scrollView contentView] setAutoresizesSubviews:YES];
		
		[self addSubview:scrollView];
		[scrollView setDocumentView:contentView];
		[scrollView release];
	
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mainWindowChanged:) name:NSViewFrameDidChangeNotification object:contentView];
		
    }
    return self;
}

- (void)awakeFromNib
{
	
	NSTrackingArea *trackingArea = [[[NSTrackingArea alloc] initWithRect:[contentView visibleRect]
																 options:NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingInVisibleRect |NSTrackingActiveAlways
																   owner:self
																userInfo:nil] autorelease];
	[self addTrackingArea:trackingArea];
	lastViewRect = [contentView bounds];
	NSLog(@"lastViewRect = %@",NSStringFromRect(lastViewRect));
}

- (void)drawRect:(NSRect)dirtyRect 
{
    // Drawing code here.
	/*
	if(bMouseDown)
	{
		
		
		NSRect rc = NSMakeRect( MIN(downPt.x, movePt.x), 
							   MIN(downPt.y, movePt.y), 
							   fabs(downPt.x - movePt.x), 
							   fabs(downPt.y - movePt.y));
		NSLog(@"rc = %@",NSStringFromRect(rc));
		[[NSColor clearColor] set];
		NSBezierPath *path = [NSBezierPath bezierPathWithRect:rc];
		
		//[[NSColor colorWithCalibratedWhite:1.00f alpha:0.4f]set];
		[[NSColor colorWithDeviceRed:0.5059 green:0.7451 blue:0.1961 alpha:0.4]set];
		[path fill];
		
		[[NSColor colorWithDeviceRed:0.5059 green:0.7451 blue:0.1961 alpha:1]set];
		[path stroke];
	}*/
}

- (void)mainWindowChanged:(NSNotification *)notification
{
	NSRect contentViewRect = [contentView bounds];
	NSLog(@"mainWindowChanged %@",NSStringFromRect(contentViewRect));

	if(!NSEqualRects(lastViewRect,contentViewRect))
	{
		lastViewRect = contentViewRect;
		[self layoutList];
	}
}

- (void)viewWillDraw
{
	[super viewWillDraw];
	NSArray *galleryAlbumCellArray = [self galleryAlbumCellArray];
	NSEnumerator *enumerator = [galleryAlbumCellArray objectEnumerator];
	GalleryAlbumCell *view;

	NSRect visibleRowsRect = [[scrollView contentView ]documentVisibleRect];
	//NSLog(@"visibleRowRect = %@",NSStringFromRect(visibleRowsRect));
	while ((view = [enumerator nextObject])) 
	{
		if(view.imagestate == THUMBNAIL_IMAGE_NONE)
		{
			if(NSIntersectsRect(visibleRowsRect,[view frame]))
			{
				[view loadImageInBackground:[view filepath]];
				[view addObserver:self forKeyPath:MMPropertyNamedThumbnailImage options:0 context:NULL];
				NSRect imageFrame = [view frame];
				NSProgressIndicator *result = nil;
				result = [[[NSProgressIndicator alloc] initWithFrame:imageFrame] autorelease];
				[result setIndeterminate:YES];
				[result setStyle:NSProgressIndicatorSpinningStyle];
				[result setControlSize:NSRegularControlSize];        
				[result sizeToFit];
				[result startAnimation:nil];
				NSRect progressFrame = [result frame];
				progressFrame.origin.x = NSMinX(imageFrame) + floor((NSWidth(imageFrame) - NSWidth(progressFrame)) / 2.0);
				progressFrame.origin.y = NSMinY(imageFrame) + floor((NSHeight(imageFrame) - NSHeight(progressFrame)) / 2.0);
				[result setFrame:progressFrame];
				[contentView addSubview:result];
				view.progressIndicator = result;
			}
		}
	}
}

- (void)reloadData
{
	NSLog(@"Enter %@",NSStringFromSelector(_cmd));
	int count = 0;
	if(dataSource && [self.dataSource respondsToSelector:@selector(numberOfAlbum:)])
	{
		count = [dataSource numberOfAlbum:self];
	}
	if(count == 0)
		return;
	if(self.dataSource && [self.dataSource respondsToSelector:@selector(albumlistView:row:)])
	{
		for(int index = 0; index < count; index++)
		{
			NSMutableDictionary *obj = [self.dataSource albumlistView:self row:index];
			if(obj 
			   && [[obj objectForKey:kGalleryTypeDataKey] caseInsensitiveCompare:@"picture"] == NSOrderedSame
			   )
			{				
				NSViewController *cellControl = [[NSViewController alloc] initWithNibName:@"GalleryAlbumCell" bundle:nil];
				if(cellControl)
				{
					GalleryAlbumCell *cell = (GalleryAlbumCell *)[cellControl view];
					cell.filepath = [obj objectForKey:kGalleryPathDataKey];
					cell.index = [[obj objectForKey:kGalleryIndexDataKey] unsignedIntValue];
					cell.filename = [obj objectForKey:kGalleryTitleDataKey];
					cell.filedate = [obj objectForKey:kGalleryShootTimeDataKey];
					cell.filetype = @"picture";
					[contentView addSubview:cell];
				}
			}
			if(obj 
			   && [[obj objectForKey:kGalleryTypeDataKey] caseInsensitiveCompare:@"video"] == NSOrderedSame
			   )
			{				
				NSViewController *cellControl = [[NSViewController alloc] initWithNibName:@"GalleryAlbumCell" bundle:nil];
				if(cellControl)
				{
					GalleryAlbumCell *cell = (GalleryAlbumCell *)[cellControl view];
					cell.displayimage = [NSImage imageNamed:@"defaultvedio"];
					cell.imagestate = THUMBNAIL_IMAGE_FINISH;
					cell.filepath = [obj objectForKey:kGalleryPathDataKey];
					cell.index = [[obj objectForKey:kGalleryIndexDataKey] unsignedIntValue];
					cell.filename = [obj objectForKey:kGalleryTitleDataKey];
					cell.filedate = [obj objectForKey:kGalleryShootTimeDataKey];
					cell.filetype = @"video";
					[contentView addSubview:cell];
				}
			}
		}
	}
	
	[self createShadowImage];
	[self layoutList];
	if(dragRectangle)
	{
		[dragRectangle removeFromSuperview];
		[dragRectangle release];
		dragRectangle = nil;
	}
	dragRectangle = [[MMDragRectangle alloc]initWithFrame:NSMakeRect(0, 0, 1, 1)];
	[dragRectangle setAlphaValue:0.4];
	[dragRectangle setHidden:YES];
	[contentView addSubview:dragRectangle positioned:NSWindowAbove relativeTo:nil];
	
	NSLog(@"Leave %@",NSStringFromSelector(_cmd));
}


- (void)layoutList
{
	NSLog(@"Enter %@",NSStringFromSelector(_cmd));
	NSRect viewRc = [[scrollView contentView] bounds];
	
	NSImageView *cell = nil;
	int origin_x = 0;
	int origin_y = 0;
	int count = 0;
	NSMutableArray *galleryAlbumCellArray = [[[NSMutableArray alloc]init]autorelease];
	NSArray *subviews = [contentView subviews];
	NSEnumerator *enumerator = [subviews objectEnumerator];
	id object;
	while ((object = [enumerator nextObject])) {
		if ([object isKindOfClass:[GalleryAlbumCell class]]) {
			[galleryAlbumCellArray addObject:object];
			count++;
		}
	}

	if(count==0)
		return;
	
	int rowMaxCount = (viewRc.size.width)/(GALLERY_ALBUM_WIDTH+GALLERY_EACH_ALBUM_SPACE);
	int fullline = (count<rowMaxCount) ? 1 : count/rowMaxCount;
	int remainline = (count<rowMaxCount) ? 0 : count%rowMaxCount;
	int index = 0;
	
	
	for(int i=0;i<fullline;i++)
	{
		if(i==0)
			origin_y = 0;
		else
			origin_y += GALLERY_ALBUM_HEIGHT+GALLERY_EACH_ALBUM_SPACE;
		origin_x = 0;
		for(int j = 0;j<rowMaxCount;j++)
		{
			cell = [galleryAlbumCellArray objectAtIndex:index++];
			if(j==0)
				origin_x = 0;
			else
				origin_x += GALLERY_ALBUM_WIDTH+GALLERY_EACH_ALBUM_SPACE;
			NSRect newRect = NSMakeRect(origin_x,
										origin_y,
										GALLERY_ALBUM_WIDTH,
										GALLERY_ALBUM_HEIGHT);
			[cell setFrame:newRect];
		}
	}
	origin_y += GALLERY_ALBUM_HEIGHT+GALLERY_EACH_ALBUM_SPACE;
	
	for(int r = 0;r<remainline;r++)
	{
		cell = [galleryAlbumCellArray objectAtIndex:index++];
		if(r==0)
			origin_x = 0;
		else
			origin_x += GALLERY_ALBUM_WIDTH+GALLERY_EACH_ALBUM_SPACE;
		NSRect newRect = NSMakeRect(origin_x,
									origin_y,
									GALLERY_ALBUM_WIDTH,
									GALLERY_ALBUM_HEIGHT);
		[cell setFrame:newRect];
	}
	//set view new frame
	origin_y += GALLERY_ALBUM_HEIGHT;
	NSRect oldBounds = [contentView bounds];
	[contentView setFrame:NSMakeRect(0, 0, oldBounds.size.width, origin_y)];
	NSLog(@"Leave %@",NSStringFromSelector(_cmd));
}

- (void)mouseMoved:(NSEvent *)theEvent
{
	NSPoint eyeCenter = [contentView convertPoint:[theEvent locationInWindow] fromView:nil];
	id obj;
	BOOL bFind = NO;
	NSArray *subViews = [contentView subviews];
	for(obj in subViews)
	{
		if ([obj isKindOfClass:[GalleryAlbumCell class]])
		{
			GalleryAlbumCell *cell = obj;
			if(cell)
			{
				NSRect viewFrame;
				viewFrame = [cell frame];
				
				BOOL isInside = [self mouse:eyeCenter inRect:viewFrame];
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
						NSRect shadowFrame = viewFrame;
		//				shadowFrame.origin.x += 5;
//						shadowFrame.origin.y += 5;
//						shadowFrame.size.width -= 10;
//						shadowFrame.size.height -= 10;
						[shadowView setFrame:shadowFrame];
						shadowView.filename = cell.filename;
						shadowView.filedate = cell.filedate;
						//[shadowView setNeedsDisplay:YES];
						[shadowView setHidden:NO];
						//cell.selected = YES;
						lastHoverMouseCell = cell;
						cell.bhoverMouse = YES;
						return;
					}
				}
			}
		}
	}
	if(!bFind)
	{
		[shadowView setHidden:YES];
		for(obj in subViews)
		{
			if ([obj isKindOfClass:[GalleryAlbumCell class]])
			{
				GalleryAlbumCell *cell = obj;
				cell.bhoverMouse = NO;
			}
		}
	}
}

- (void)mouseExited:(NSEvent *)event 
{
	id obj;
	NSArray *subViews = [contentView subviews];
	for(obj in subViews)
	{
		if ([obj isKindOfClass:[GalleryAlbumCell class]])
		{
			GalleryAlbumCell *cell = obj;
			if(cell)
			{
				cell.bhoverMouse = NO;
			}
		}
	}
	lastHoverMouseCell = nil;
	[shadowView setHidden:YES];
	bMouseDown = NO;
	[dragRectangle setHidden:YES];
	[self setNeedsDisplay:YES];
}

- (void)_hideShadowView:(NSView *)shadow;
{
	[shadow setHidden:YES];
}

- (void)mouseDown:(NSEvent *)theEvent
{	
	NSPoint eyeCenter = downPt = [contentView convertPoint:[theEvent locationInWindow] fromView:nil];
	bMouseDown = YES;
	[dragRectangle setFrame:NSMakeRect(downPt.x, downPt.y, 1, 1)];
	[dragRectangle setHidden:NO];
	id obj;

	NSArray *subViews = [contentView subviews];
	for(obj in subViews)
	{
		if ([obj isKindOfClass:[GalleryAlbumCell class]])
		{
			GalleryAlbumCell *cell = obj;
			if(cell)
			{
				cell.selected = NO;
				[cell setNeedsDisplay:YES];
			}
		}
	}
	
	for(obj in subViews)
	{
		if ([obj isKindOfClass:[GalleryAlbumCell class]])
		{
			GalleryAlbumCell *cell = obj;
			if(cell)
			{
				NSRect viewFrame;
				viewFrame = [cell frame];
				
				BOOL isInside = [self mouse:eyeCenter inRect:viewFrame];
				if(isInside)
				{
					NSRect playButtonFrame = NSMakeRect(viewFrame.origin.x+viewFrame.size.width/2-20,
														viewFrame.origin.y+viewFrame.size.height/2-20
														, 40, 40);
					if([self mouse:eyeCenter inRect:playButtonFrame])
					{
						//need play
						if(delegate && [self.delegate respondsToSelector:@selector(needPlayAlbum:)])
						{
							[delegate needPlayAlbum:cell.index];
						}
					}
					else 
					{
						//only selected
						//[self performSelectorOnMainThread:@selector(_hideShadowView:) withObject:shadowView waitUntilDone:NO];
						cell.selected = YES;
						[cell setNeedsDisplay:YES];
						//[shadowView setHidden:YES];
						//
					}
				}
			}
		}
	}
}

- (void)mouseUp:(NSEvent *)theEvent
{
	bMouseDown = NO;
	[dragRectangle setHidden:YES];
	[self setNeedsDisplay:YES];
}

- (void)mouseDragged:(NSEvent *)theEvent
{
	movePt = [contentView convertPoint:[theEvent locationInWindow] fromView:nil];
	NSRect rc = NSMakeRect( MIN(downPt.x, movePt.x), 
						   MIN(downPt.y, movePt.y), 
						   fabs(downPt.x - movePt.x), 
						   fabs(downPt.y - movePt.y));
	[dragRectangle setFrame:rc];
	
	NSArray *galleryAlbumCellArray = [self galleryAlbumCellArray];
	NSEnumerator *enumerator = [galleryAlbumCellArray objectEnumerator];
	GalleryAlbumCell *view;
	while ((view = [enumerator nextObject])) {
		if(NSIntersectsRect(rc,[view frame]))
		{
			view.selected = YES;
			[view setNeedsDisplay:YES];
		}
		else {
			view.selected = NO;
			[view setNeedsDisplay:YES];
		}
	}
}

- (void)createShadowImage
{
	shadowView = [[GalleryAlbumShadowView alloc]initWithFrame:NSMakeRect(0, 0, GALLERY_ALBUM_WIDTH, GALLERY_ALBUM_HEIGHT)];
	[shadowView setAlphaValue:0.9f];
	[contentView addSubview:shadowView positioned:NSWindowAbove relativeTo:nil];
	[shadowView setHidden:YES];
}

- (NSMutableArray*)galleryAlbumCellArray
{
	NSMutableArray *galleryAlbumCellArray = [[[NSMutableArray alloc]init]autorelease];
	NSArray * subviews = [contentView subviews];
	NSEnumerator *enumerator = [subviews objectEnumerator];
	id object;
	while ((object = [enumerator nextObject])) {
		if ([object isKindOfClass:[GalleryAlbumCell class]]) {
			[galleryAlbumCellArray addObject:object];
		}
	}
	return galleryAlbumCellArray;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context 
{
    if (keyPath == MMPropertyNamedThumbnailImage) 
	{
		GalleryAlbumCell *view = object;
		if(view && view.progressIndicator != nil)
		{
			[view.progressIndicator removeFromSuperview];
		}
    }
}


@end
