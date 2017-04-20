//
//  DeviceViewController.m
//  MediaManager
//
//  Created by Arthur on 6/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DeviceViewController.h"
#import "CustomImageButtonCell.h"
#import "ColorTextButton.h"

@interface DeviceViewController(Private)
- (void)_initModelColor;
- (void)_initButtons;
- (void)_initConfigureViews;
@end

@implementation DeviceViewController
@synthesize progressStep;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
	{
		[[NSNotificationCenter defaultCenter] addObserver: self
												 selector: @selector(mainWindowChanged:)
													 name: NSViewFrameDidChangeNotification
												   object: contentViewBox];
	}
	return self;
}

- (void)dealloc
{
	[super dealloc];
}

- (void)initColorButton
{
	for(int i=1;i<3;i++)
	{
		NSButton *button = [deviceOverView viewWithTag:i];
		if(button)
		{
			[button setHoverColor:[NSColor colorWithDeviceRed:0.5059 green:0.7451 blue:0.1961 alpha:1]];
			[button setPushColor:[NSColor colorWithDeviceRed:0.5059 green:0.7451 blue:0.1961 alpha:1]];
			[button setNormalColor:[NSColor colorWithDeviceRed:1 green:1 blue:1 alpha:1]];
			[button setHeightLight:NO];
		}
	}
	[[deviceOverView viewWithTag:1] setHeightLight:YES];
}

- (void)_initModelColor
{
	NSArray *colorArray = [NSArray arrayWithObjects:[NSColor redColor],[NSColor blueColor],[NSColor yellowColor],
						   [NSColor grayColor],[NSColor greenColor],[NSColor brownColor],nil];
	for(int i = 12;i<=62;i+=10)
	{
		id color = [deviceOverView viewWithTag:i];
		if([color isKindOfClass:[NSImageView class]])
		{
			NSImageView *v = (NSImageView*)color;
			[v setImageFrameStyle:NSImageFrameNone];
			NSImage *image = [[NSImage alloc] initWithSize:[v bounds].size];
			[image lockFocus];
			[[colorArray objectAtIndex:i/10-1]set];
			NSRectFill([v bounds]);
			[image unlockFocus];
			[v setImage:image];
			[image release];
		}
	}
}

- (void)_initButtons
{
	for(int i=11;i<=61;i+=10)
	{
		id settingBtn = [deviceOverView viewWithTag:i];
		if([settingBtn isKindOfClass:[NSButton class]])
		{
			NSButton *b = (NSButton*)settingBtn;
			[b setHoverImage:[NSImage imageNamed:@"setting_hover"]];
			[b setDownImage:[NSImage imageNamed:@"setting_hover"]];
			[b setNormalImage:[NSImage imageNamed:@"setting"]];
		}
	}
	
	[syncNowButton setHoverImage:[NSImage imageNamed:@"icon_butn_hover"]];
    [syncNowButton setDownImage:[NSImage imageNamed:@"icon_butn_push"]];
    [syncNowButton setDisableImage:[NSImage imageNamed:@"icon_butn_disable"]];
    [syncNowButton setNormalImage:[NSImage imageNamed:@"icon_butn_normal"]];
    [syncNowButton setTextColor:[NSColor whiteColor]];
	
	[galleryDoneBtn setHoverImage:[NSImage imageNamed:@"icon_butn_hover"]];
    [galleryDoneBtn setDownImage:[NSImage imageNamed:@"icon_butn_push"]];
    [galleryDoneBtn setDisableImage:[NSImage imageNamed:@"icon_butn_disable"]];
    [galleryDoneBtn setNormalImage:[NSImage imageNamed:@"icon_butn_normal"]];
    [galleryDoneBtn setTextColor:[NSColor whiteColor]];
	
	[musicDoneBtn setHoverImage:[NSImage imageNamed:@"icon_butn_hover"]];
    [musicDoneBtn setDownImage:[NSImage imageNamed:@"icon_butn_push"]];
    [musicDoneBtn setDisableImage:[NSImage imageNamed:@"icon_butn_disable"]];
    [musicDoneBtn setNormalImage:[NSImage imageNamed:@"icon_butn_normal"]];
    [musicDoneBtn setTextColor:[NSColor whiteColor]];
	
	[peopleDoneBtn setHoverImage:[NSImage imageNamed:@"icon_butn_hover"]];
    [peopleDoneBtn setDownImage:[NSImage imageNamed:@"icon_butn_push"]];
    [peopleDoneBtn setDisableImage:[NSImage imageNamed:@"icon_butn_disable"]];
    [peopleDoneBtn setNormalImage:[NSImage imageNamed:@"icon_butn_normal"]];
    [peopleDoneBtn setTextColor:[NSColor whiteColor]];
	
	[calendarDoneBtn setHoverImage:[NSImage imageNamed:@"icon_butn_hover"]];
    [calendarDoneBtn setDownImage:[NSImage imageNamed:@"icon_butn_push"]];
    [calendarDoneBtn setDisableImage:[NSImage imageNamed:@"icon_butn_disable"]];
    [calendarDoneBtn setNormalImage:[NSImage imageNamed:@"icon_butn_normal"]];
    [calendarDoneBtn setTextColor:[NSColor whiteColor]];
	
	[documentDoneBtn setHoverImage:[NSImage imageNamed:@"icon_butn_hover"]];
    [documentDoneBtn setDownImage:[NSImage imageNamed:@"icon_butn_push"]];
    [documentDoneBtn setDisableImage:[NSImage imageNamed:@"icon_butn_disable"]];
    [documentDoneBtn setNormalImage:[NSImage imageNamed:@"icon_butn_normal"]];
    [documentDoneBtn setTextColor:[NSColor whiteColor]];
	
	[bookmarksDoneBtn setHoverImage:[NSImage imageNamed:@"icon_butn_hover"]];
    [bookmarksDoneBtn setDownImage:[NSImage imageNamed:@"icon_butn_push"]];
    [bookmarksDoneBtn setDisableImage:[NSImage imageNamed:@"icon_butn_disable"]];
    [bookmarksDoneBtn setNormalImage:[NSImage imageNamed:@"icon_butn_normal"]];
    [bookmarksDoneBtn setTextColor:[NSColor whiteColor]];
	
	[isAutoSyncCheckBoxBtn setTextColor:[NSColor whiteColor]];
}

- (void)awakeFromNib
{
	NSRect bounds = [[self view]bounds];
	[[self view] addSubview:deviceOverView];
	[deviceOverView setFrame:bounds];
	
	NSRect contentRect = [contentViewBox bounds];
	[deviceView setFrame:contentRect];
	[contentViewBox setContentView:deviceView];
	
	NSRect subRect = [subViewBox bounds];
	[syncView setFrame:subRect];
	[editView setFrame:subRect];
	[subViewBox setContentView:syncView];
	
	[[self view] addSubview:deviceListView];
	[deviceListView setFrame:bounds];
	[deviceButton setNormalImage:[NSImage imageNamed:@"large"]];
	[deviceButton setDownImage:[NSImage imageNamed:@"large"]];
	previousView = deviceListView;
	
	[self initColorButton];
		
	[storageCombo selectItemAtIndex:0];
	[self _initModelColor];
	[self _initButtons];
	[self _initConfigureViews];
	
	//NSNib *nib = [[[NSNib alloc] init]autorelease];
//	NSArray *objectArray = nil;
//	BOOL success = [nib instantiateNibWithOwner:self topLevelObjects:&objectArray];
//	if(success)
//	{
//		NSEnumerator *enumerator = [objectArray objectEnumerator];
//		id anObject = nil;
//		while (anObject = [enumerator nextObject]) 
//		{
//			if ([anObject isKindOfClass: [NSComboBox class]])
//			{
//				[anObject selectItemAtIndex:0];
//			}
//		}			
//	}
}

- (void)_initConfigureViews
{
	NSRect subRect = [contentViewBox bounds];
	[galleryConfigureView setFrame:subRect];
	[musicConfigureView setFrame:subRect];
	[peopleConfigureView setFrame:subRect];
	[calendarConfigureView setFrame:subRect];
	[documentConfigureView setFrame:subRect];
	[bookmarkConfigureView setFrame:subRect];
	
	for(int i=11;i<=61;i+=10)
	{
		[[deviceOverView viewWithTag:i] setTarget:self];
		[[deviceOverView viewWithTag:i] setAction:@selector(toggleConfigureView:)];
	}
}

- (void)mainWindowChanged:(NSNotification *)notification
{

}

- (IBAction)toggleDevice:(id)sender
{
	[[self view] replaceSubview:previousView with:deviceOverView];
}

- (IBAction)toggleView:(id)sender
{
	for(int i=1;i<3;i++)
	{
		NSButton *button = [deviceOverView viewWithTag:i];
		[button setHeightLight:NO];
	}
	[[deviceOverView viewWithTag:[sender tag]] setHeightLight:YES];
	[contentViewBox setContentView:deviceView];
	NSInteger tag = [sender tag];
	switch (tag) 
	{
		case 1:
			[subViewBox setContentView:syncView];
			[syncNowButton setHidden:NO];
			break;
		case 2:
			[subViewBox setContentView:editView];
			[syncNowButton setHidden:YES];
			break;
		default:
			break;
	}
	
	for(int i=11;i<=61;i+=10)
	{
		id settingBtn = [deviceOverView viewWithTag:i];
		if([settingBtn isKindOfClass:[NSButton class]])
		{
			[settingBtn setNeedsDisplay:YES];
		}
	}
}

- (IBAction)toggleConfigureView:(id)sender
{
	switch([sender tag])
	{
		case 11:
			[contentViewBox setContentView:galleryConfigureView];
			break;
		case 21:
			[contentViewBox setContentView:musicConfigureView];
			break;
		case 31:
			[contentViewBox setContentView:peopleConfigureView];
			break;
		case 41:
			[contentViewBox setContentView:calendarConfigureView];
			break;
		case 51:
			[contentViewBox setContentView:documentConfigureView];
			break;
		case 61:
			[contentViewBox setContentView:bookmarkConfigureView];
			break;
		default:
			break;
	}
}

- (IBAction)doneConfigureView:(id)sender
{
	[contentViewBox setContentView:deviceView];
}

- (NSInteger)entryFontSize
{
	return 24;
}

- (NSInteger)categoryFontSize
{
	return 18;
}

- (NSInteger)deviceModelFontSize
{
	return 22;
}

- (NSColor *)historyTextColor
{
	return [NSColor grayColor];
}

- (NSColor *)textColor
{
	return [NSColor whiteColor];
}



- (IBAction)startSync:(id)sender
{
	//[[NSApplication sharedApplication] runModalForWindow:mSettingsPanel];
	NSRect bounds = [view1 bounds];
	float x=[[NSScreen mainScreen] frame].size.width/2.0 - bounds.size.width/2;
    float y=[[NSScreen mainScreen] frame].size.height/2.0 - bounds.size.height/2;

    MMStyleWindow *win1=[[MMStyleWindow alloc] initWithContentRect:NSMakeRect(x, y, bounds.size.width, bounds.size.height) withView:view1];
    [win1 setLevel:NSFloatingWindowLevel];
    [win1 setCustomShadow:NO];
	[win1 center];

	NSOperationQueue *operation = [[NSOperationQueue alloc]init];
	[operation addOperationWithBlock:^(void) 
	 {
		 while(YES)
		 {
			 [self setProgressStep:[self progressStep]+1];
			 [NSThread sleepForTimeInterval:0.1];
		 }
		 		 
	 }];
	[NSApp runModalForWindow: win1];

}
@end
