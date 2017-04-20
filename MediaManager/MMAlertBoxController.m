//
//  MMAlertBoxController.m
//  MediaManager
//
//  Created by Arthur on 8/8/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MMAlertBoxController.h"
#import "CustomImageButtonCell.h"
@implementation MMAlertBoxController
@synthesize title,message;

+ (void)alertBox:(NSString*)title message:(NSString*)msg
{
	MMAlertBoxController *alertBoxController = [[MMAlertBoxController alloc]initWithWindowNibName:@"MMAlertBoxController"];
	if(alertBoxController)
	{
		[[alertBoxController window] setBackgroundColor:[NSColor colorWithDeviceRed:0.1490f green:0.1490f blue:0.1490f alpha:1.0f]];
		alertBoxController.title = title;
		alertBoxController.message = msg;
		
		[[alertBoxController window]setStyleMask:NSBorderlessWindowMask];
		[[alertBoxController window] setOpaque:NO];
		[[alertBoxController window] setMovableByWindowBackground:YES];
		[[alertBoxController window] setHasShadow:YES];
		[[alertBoxController window] setIsVisible:YES];
		[[alertBoxController window] setReleasedWhenClosed:NO];
				
		NSRect frame = [[alertBoxController window]frame];
		NSRect mainFrame = [[[NSApplication sharedApplication] mainWindow] frame];
		float x=mainFrame.size.width/2.0 - frame.size.width/2 + mainFrame.origin.x;
		float y=mainFrame.size.height/2.0 - frame.size.height/2 + mainFrame.origin.y;
		[[alertBoxController window]setFrame:NSMakeRect(x, y, frame.size.width, frame.size.height) display:YES];
		
		[NSApp runModalForWindow:[alertBoxController window]];
		[alertBoxController release];
	}
}

- (void)awakeFromNib
{
	[okButton setHoverImage:[NSImage imageNamed:@"icon_butn_hover"]];
	[okButton setDownImage:[NSImage imageNamed:@"icon_butn_push"]];
	[okButton setDisableImage:[NSImage imageNamed:@"icon_butn_disable"]];
	[okButton setNormalImage:[NSImage imageNamed:@"icon_butn_normal"]];
	[okButton setTextColor:[NSColor whiteColor]];
	
}

- (void)dealloc
{
	[title release];
	[message release];
	[super dealloc];
}

- (void)setTitle:(NSString *)alerttitle
{
	title = [alerttitle copy];
	[alertTitle setStringValue:alerttitle];
}

- (void)setMessage:(NSString *)alertmessage
{
	message = [alertmessage copy];
	[alertMessage setStringValue:alertmessage];
}

- (NSInteger)titleFontSize
{
	return 20;
}

- (NSInteger)messageFontSize
{
	return 20;
}

- (IBAction)okAction:(id)sender
{
	[[sender window]close];
	[NSApp stopModal];
}

@end
