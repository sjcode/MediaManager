//
//  MusicRecentViewController.m
//  MediaManager
//
//  Created by jian su on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MusicRecentViewController.h"
//#import "TagLib.h"


#pragma mark - MusicRecentViewController

@implementation MusicRecentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
		
	return self;
}

- (void)dealloc
{
	[super dealloc];
}

- (void)awakeFromNib
{	
	[importPicAndVideoButton setHoverImage:[NSImage imageNamed:@"icon_butn_hover"]];
    [importPicAndVideoButton setDownImage:[NSImage imageNamed:@"icon_butn_push"]];
    [importPicAndVideoButton setDisableImage:[NSImage imageNamed:@"icon_butn_disable"]];
    [importPicAndVideoButton setNormalImage:[NSImage imageNamed:@"icon_butn_normal"]];
    [importPicAndVideoButton setTextColor:[NSColor whiteColor]];
}


- (void)mainWindowChanged:(NSNotification *)notification
{

	NSLog(@"mainWindowChanged\n");
	
}

- (void)loadView
{
	[super loadView];
	
}


@end
