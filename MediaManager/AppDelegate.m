//
//  AppDelegate.m
//  MediaManager
//
//  Created by jian su on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "MediaFileManager.h"
@implementation AppDelegate
@synthesize fileManager;
//@synthesize window;

- (void)applicationWillFinishLaunching:(NSNotification *)aNotification 
{  

}

- (void)closeSplashBox:(NSTimer*)timer
{
	NSLog(@"closeSplashBox");
}

- (void)loadFinish:(id)obj
{
	[splashWindowController close];
	[mainContentController.window setDelegate:self];
	[mainContentController showWindow:nil];
	[[mainContentController window] makeKeyAndOrderFront:self];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    //[[mainContentController window] makeKeyAndOrderFront:self];
	
	

	splashWindowController = [[NSWindowController alloc] initWithWindowNibName:@"SplashWindowController"];
	[[splashWindowController window ]makeKeyAndOrderFront:self];
	[NSThread detachNewThreadSelector:@selector(scanFolderMusic:) toTarget:self withObject:nil];
	
		[NSTimer scheduledTimerWithTimeInterval: 1.0f 
										 target:self 
									   selector:@selector(loadFinish:) 
									   userInfo:self 
										repeats:false];
}

- (void)showMainWindow;
{
    if(!mainContentController)
    {
        mainContentController = [[MainContentController alloc]init];
		//[mainContentController.window setDelegate:self];
    }
    //[mainContentController showWindow:nil];
	//[[mainContentController window] makeKeyAndOrderFront:self];
}

- (void)awakeFromNib
{
    [self showMainWindow];
}

- (BOOL)windowShouldClose:(id)sender	//close box quits the app
{
    [NSApp terminate:self];
    return YES;
}

- (void)dealloc
{
	[splashWindowController release];
	[mainContentController release];
	[super dealloc];
}

- (void)scanFolderMusic:(NSString*)path
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
	NSString *path1 = [NSHomeDirectory() stringByAppendingPathComponent:  @"Music/mp3"];
	NSArray *paths = [NSArray arrayWithObjects:path1,nil];
	[[MediaFileManager shareMediaFileManager] serachMusic:paths];
	
	//NSString *galleryPath = [NSHomeDirectory() stringByAppendingPathComponent:  @"Pictures"];
	NSString *galleryPath1 = [NSHomeDirectory() stringByAppendingPathComponent:  @"Pictures"];
	NSArray *galleryPaths = [NSArray arrayWithObjects:galleryPath1,nil];
	[[MediaFileManager shareMediaFileManager] serachGallery:galleryPaths];
	
	[self loadFinish:nil];
	
	[pool release];
}

@end
