//
//  MMSettingViewController.m
//  MediaManager
//
//  Created by Arthur on 7/27/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MMSettingViewController.h"
#import "ColorTextButton.h"
#import "CustomImageButtonCell.h"
#import "MMAlertBoxController.h"
#import "MediaFileManager.h"
#import "AppDelegate.h"
@implementation MMSettingViewController
@synthesize progressStep,progressMax,sreachFilename;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
	{
		
	}
	return self;
}

- (void)dealloc
{
	[super dealloc];
}

- (void)_initButtons
{	
	//root
	for(int i=0;i<4+1;i++)
	{
		id button = [[self view] viewWithTag:i];
		if(button)
		{
			[button setHoverColor:[NSColor colorWithDeviceRed:0.5059 green:0.7451 blue:0.1961 alpha:1]];
			[button setPushColor:[NSColor colorWithDeviceRed:0.5059 green:0.7451 blue:0.1961 alpha:1]];
			[button setNormalColor:[NSColor colorWithDeviceRed:1 green:1 blue:1 alpha:1]];
			[button setHeightLight:NO];
		}
	}
	[[[self view] viewWithTag:1] setHeightLight:YES];
	
}

- (void)_initMusicView
{
	//music
	for(int j=101;j<106;j++)
	{
		id button = [[self view] viewWithTag:j];
		if(button)
		{
			[button setHoverImage:[NSImage imageNamed:@"icon_butn_hover"]];
			[button setDownImage:[NSImage imageNamed:@"icon_butn_push"]];
			[button setDisableImage:[NSImage imageNamed:@"icon_butn_disable"]];
			[button setNormalImage:[NSImage imageNamed:@"icon_butn_normal"]];
			[button setTextColor:[NSColor whiteColor]];
		}
	}

	divideLine = [NSImage imageNamed:@"bg_content_divide"];
	NSRect frame = [musicSimpleComboBox frame];
	frame.origin.x = 10;
	frame.origin.y = 10;
	frame.size.height = divideLine.size.height;
	
//	[musicLibraryView lockFocus];
//	[divideLine drawInRect:frame fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
//	[musicLibraryView unlockFocus];
	
	NSRect bounds = [musicSimpleComboBox bounds];
	[myScrollView setFrame:bounds];
	[musicSimpleComboBox setContentView:myScrollView];
	
}

- (void)awakeFromNib
{
	[self _initButtons];
	NSRect contentRect = [contentViewBox bounds];
	
	[musicLibraryView setFrame:contentRect];
	[galleryLibraryView setFrame:contentRect];
	[videoView setFrame:contentRect];
	[importCDView setFrame:contentRect];
	
	[contentViewBox setContentView:musicLibraryView];
	[self _initMusicView];
}

- (IBAction)toggleView:(id)sender
{
	for(int i=1;i<5;i++)
	{
		NSButton *button = [[self view] viewWithTag:i];
		[button setHeightLight:NO];
	}
	[[[self view] viewWithTag:[sender tag]] setHeightLight:YES];
	NSInteger tag = [sender tag];
	switch (tag) 
	{
		case 1:
			[contentViewBox setContentView:musicLibraryView];
			break;
		case 2:
			[contentViewBox setContentView:galleryLibraryView];
			break;
		case 3:
			[contentViewBox setContentView:videoView];
			break;
		case 4:
			[contentViewBox setContentView:importCDView];
			break;
		default:
			break;
	}
}

#pragma mark -
#pragma mark MusicSetting

- (IBAction)addMusic:(id)sender
{
	NSOpenPanel *panel =  [NSOpenPanel openPanel];
	[panel setCanChooseDirectories:YES];
    [panel beginSheetForDirectory:@"" 
		   file:nil 
		   types:nil 
		   modalForWindow:[sender window] 
		   modalDelegate:self 
		   didEndSelector:@selector(openPanelDidEnd:returnCode:contextInfo:) 
		   contextInfo:NULL];
}

- (void)hasAlreadyExistFolder:(id)object
{
	NSString *msg = [NSString stringWithFormat:@"The %@ has been added to library.",object];
	[MMAlertBoxController alertBox:@"Folder added" message:msg];
}

- (void)serachFolder:(id)object
{
	NSArray *paths = [NSArray arrayWithObjects:object,nil];
	[MediaFileManager shareMediaFileManager].delegate = self;
	[[MediaFileManager shareMediaFileManager] serachMusic:paths];
	[paths release];
}

- (void)sreachProgress:(NSInteger)step filename:(NSString*)name contextInfo:(id)context
{
	NSLog(@"step = %lu name = %@",step,name);
	self.progressStep = step;
	self.sreachFilename = name;

	if(step == self.progressMax)
	{
		[(NSWindow*)context close];
		[NSApp stopModal];
	}
}

- (void)runModalProgressWindow:(NSString*)folder
{
	NSRect bounds = [importView bounds];
	NSRect mainFrame = [[[NSApplication sharedApplication] mainWindow] frame];
	float x=mainFrame.size.width/2.0 - bounds.size.width/2 + mainFrame.origin.x;
	float y=mainFrame.size.height/2.0 - bounds.size.height/2 + mainFrame.origin.y;
	
	MMStyleWindow *window=[[MMStyleWindow alloc] initWithContentRect:NSMakeRect(x, y, bounds.size.width, bounds.size.height) withView:importView];
    [window setLevel:NSFloatingWindowLevel];
    [window setCustomShadow:NO];
	[window setHasShadow:YES];
	[window setIsVisible:YES];
	[window setReleasedWhenClosed:NO];
	
	[MediaFileManager shareMediaFileManager].delegate = self;
	self.progressMax = (double)[[MediaFileManager shareMediaFileManager] startSerachMusic:folder contextInfo:window];

	[NSApp runModalForWindow: window];
}

- (void)openPanelDidEnd:(id)panel returnCode:(NSInteger)code contextInfo:(void *)userInfo 
{
    if (code == NSAlertDefaultReturn) 
	{
		NSArray *array = [musicFolderArray arrangedObjects];
		NSEnumerator *enumerator = [array objectEnumerator];
		id obj;
		while(obj = [enumerator nextObject])
		{
			NSString *folder = [obj valueForKey:@"foldername"];
			if([folder isEqualToString:[panel filename]] == YES)
			{
				[self performSelectorOnMainThread:@selector(hasAlreadyExistFolder:) withObject:[[panel filename]lastPathComponent] waitUntilDone:NO];
				return;
			}
		}
		
		//NSMutableDictionary * mfEntryDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
		//																	 [panel filename],@"musicFolders",nil];
        
		//[musicFolderArray addObject:mfEntryDict];
        
        NSEntityDescription *entity = [[[self managedObjectModel] entitiesByName] objectForKey:@"MusicFolder"];
        NSManagedObject *newObject = [[NSManagedObject alloc]initWithEntity:entity insertIntoManagedObjectContext:[self managedObjectContext]];
        [newObject setValue:[panel filename] forKey:@"foldername"];
        [musicFolderArray addObject:newObject];
        NSError *error;
        if (![[self managedObjectContext] save: &error])
        {
            NSLog(@"import songitem field!");
        }
		[self performSelectorOnMainThread:@selector(runModalProgressWindow:) withObject:[panel filename] waitUntilDone:NO]; 
	}
}

- (NSManagedObjectContext *)managedObjectContext
{
	return [[MediaFileManager shareMediaFileManager] managedObjectContext];
}

- (NSManagedObjectModel *)managedObjectModel
{
    return [[MediaFileManager shareMediaFileManager] managedObjectModel];
}

#pragma mark -
#pragma mark UI Style
- (NSInteger)categroyFontSize
{
	return 18;
}

- (NSColor *)textColor
{
	return [NSColor whiteColor];
}

@end
