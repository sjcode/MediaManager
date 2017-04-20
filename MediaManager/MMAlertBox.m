//
//  MMAlertBox.m
//  MediaManager
//
//  Created by Arthur on 8/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MMAlertBox.h"
#import "CustomImageButtonCell.h"

@implementation MMAlertBox

+ (void)alertBox:(NSString*)title message:(NSString*)msg
{
	NSRect mainFrame = [[[NSApplication sharedApplication] mainWindow] frame];
	float x=mainFrame.size.width/2.0 - ALERTBOXWIDTH/2 + mainFrame.origin.x;
	float y=mainFrame.size.height/2.0 - ALERTBOXHEIGHT/2 + mainFrame.origin.y;
	//box		 
	MMAlertBox *box = [[[MMAlertBox alloc] initWithContentRect:NSMakeRect(x, y, ALERTBOXWIDTH, ALERTBOXHEIGHT) styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:YES] autorelease];
	[box setLevel:NSFloatingWindowLevel];
	[box setBackgroundColor:[NSColor colorWithDeviceRed:0.1490f green:0.1490f blue:0.1490f alpha:1.0f]];
	[box setOpaque:NO];
	[box setMovableByWindowBackground:YES];
	[box setHasShadow:YES];
	[box setIsVisible:YES];
	[box setReleasedWhenClosed:NO];
	
	//title
	NSTextField *titleField = [[[NSTextField alloc] initWithFrame:NSMakeRect(10, ALERTBOXHEIGHT-40, ALERTBOXWIDTH-20, 20)] autorelease];
	[titleField setTextColor:[NSColor whiteColor]];
	[titleField setBordered:NO];
	[titleField setDrawsBackground:NO];
	[titleField setEditable:NO];
	[titleField setStringValue:title];
	[[titleField cell]setScrollable:NO];
	[titleField setFont:[NSFont systemFontOfSize:20]];
	
	//message
	NSTextField *msgField = [[[NSTextField alloc] initWithFrame:NSMakeRect(10, ALERTBOXHEIGHT-80, ALERTBOXWIDTH-20, 20)] autorelease];
	[msgField setTextColor:[NSColor whiteColor]];
	[msgField setBordered:NO];
	[msgField setDrawsBackground:NO];
	[msgField setEditable:NO];
	[msgField setStringValue:msg];
	[msgField setFont:[NSFont systemFontOfSize:12]];
	
	//okbutton
	NSButton *okButton = [[[NSButton alloc] initWithFrame:NSMakeRect(ALERTBOXWIDTH-180, 20, 125, 30)] autorelease];
	[okButton setBezelStyle:NSRoundRectBezelStyle];
	
	/*
	
	CustomImageButtonCell *cell = [[CustomImageButtonCell alloc]init];
	[cell setGradientType:NSGradientNone];
	[okButton setCell:cell];
	[okButton setBordered:NO];
	[okButton setHoverImage:[NSImage imageNamed:@"icon_butn_hover"]];
	[okButton setDownImage:[NSImage imageNamed:@"icon_butn_push"]];
	[okButton setDisableImage:[NSImage imageNamed:@"icon_butn_disable"]];
	[okButton setNormalImage:[NSImage imageNamed:@"icon_butn_normal"]];
	 */
	[okButton setTextColor:[NSColor whiteColor]];
	[okButton setTitle:@"OK"];
	[okButton setAction:@selector(okButtonAction:)];
	
	[[box contentView] addSubview:titleField];
	[[box contentView] addSubview:msgField];
	[[box contentView] addSubview:okButton];

	[NSApp runModalForWindow:box];
}

- (IBAction)okButtonAction:(id)sender
{
	[[sender window] close];
	[NSApp stopModal];
}

@end
