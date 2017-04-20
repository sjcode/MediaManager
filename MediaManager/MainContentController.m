//
//  SJContentController.m
//  MediaManager
//
//  Created by jian su on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainContentController.h"
#import "CustomImageButtonCell.h"
#import "ColorTextButton.h"

@implementation MainContentController
@synthesize title,albumname,beginTime,endTime;
-(id)init 
{
    self = [super initWithWindowNibName:@"MainWindow"];
    return self;
}

- (void)dealloc
{
	[super dealloc];
}

- (void)createCategoryView
{
	[musicCategoryView setFrame:[moduleListContentView bounds]];
	
	[galleryCategoryView setFrame:[moduleListContentView bounds]];
	[deviceCategoryView setFrame:[moduleListContentView bounds]];
	
	[moduleListContentView addSubview: deviceCategoryView];
	[moduleListContentView addSubview: galleryCategoryView];
	[moduleListContentView addSubview: musicCategoryView];
	
	currentCategoryViewTag = 10;
}

- (void)createVideoCanvas
{
	[currentContentView addSubview:galleryVideoCanvas];
	[galleryVideoCanvas setFrame:[currentContentView bounds]];
	previousView = galleryVideoCanvas;
}

- (void)createPictureView
{
	[currentContentView addSubview:galleryPictureListView];
	[galleryPictureListView setFrame:[currentContentView bounds]];
	previousView = galleryPictureListView;
}

- (void)awakeFromNib
{	
    [backButton setHoverImage:[NSImage imageNamed:@"icon_back_hover"]];
    [backButton setNormalImage:[NSImage imageNamed:@"icon_back_normal"]];
	
    [settingButton setHoverImage:[NSImage imageNamed:@"icon_setting_button"]];
    [settingButton setNormalImage:[NSImage imageNamed:@"icon_setting_button"]];
	
    [clickButton setHoverImage:[NSImage imageNamed:@"icon_butn_hover"]];
    [clickButton setDownImage:[NSImage imageNamed:@"icon_butn_push"]];
    [clickButton setDisableImage:[NSImage imageNamed:@"icon_butn_disable"]];
    [clickButton setNormalImage:[NSImage imageNamed:@"icon_butn_normal"]];
    [clickButton setTextColor:[NSColor whiteColor]];
    
    [movebackButton setHoverImage:[NSImage imageNamed:@"icon_player_back_hover"]];
    [movebackButton setDownImage:[NSImage imageNamed:@"icon_player_back_down"]];
    [movebackButton setNormalImage:[NSImage imageNamed:@"icon_player_back_normal"]];
    
    [playButton setHoverImage:[NSImage imageNamed:@"icon_player_play_hover"]];
    [playButton setDownImage:[NSImage imageNamed:@"icon_player_play_down"]];
    [playButton setNormalImage:[NSImage imageNamed:@"icon_player_play_normal"]];
	
	[pauseButton setHoverImage:[NSImage imageNamed:@"icon_player_pause_hover"]];
    [pauseButton setDownImage:[NSImage imageNamed:@"icon_player_pause_down"]];
    [pauseButton setNormalImage:[NSImage imageNamed:@"icon_player_pause_normal"]];
    
    [forwardButton setHoverImage:[NSImage imageNamed:@"icon_player_forward_hover"]];
    [forwardButton setDownImage:[NSImage imageNamed:@"icon_player_forward_down"]];
    [forwardButton setNormalImage:[NSImage imageNamed:@"icon_player_forward_normal"]];
    
    [volumeButton setNormalImage:[NSImage imageNamed:@"Volume_3"]];
    
    [bt1 setHoverImage:[NSImage imageNamed:@"icon_shuffle_on"]];
    [bt1 setNormalImage:[NSImage imageNamed:@"icon_shuffle_off"]];
    
    [bt2 setHoverImage:[NSImage imageNamed:@"icon_player_repeat_on"]];
    [bt2 setNormalImage:[NSImage imageNamed:@"icon_player_repeat_off"]];
    
    [moreButton setHoverImage:[NSImage imageNamed:@"icon_player_more_hover"]];
    [moreButton setDownImage:[NSImage imageNamed:@"icon_player_more_down"]];
    [moreButton setNormalImage:[NSImage imageNamed:@"icon_player_more_normal"]];
    
    [addtoAblumButton setHoverImage:[NSImage imageNamed:@"icon_player_tag_hover"]];
    [addtoAblumButton setDownImage:[NSImage imageNamed:@"icon_player_tag_down"]];
    [addtoAblumButton setNormalImage:[NSImage imageNamed:@"icon_player_tag_normal"]];
    
    [sendtophoneButton setHoverImage:[NSImage imageNamed:@"icon_player_phone_hover"]];
    [sendtophoneButton setDownImage:[NSImage imageNamed:@"icon_player_phone_down"]];
    [sendtophoneButton setNormalImage:[NSImage imageNamed:@"icon_player_phone_normal"]];

    [musicButton setHoverColor:[NSColor colorWithDeviceRed:0.5059 green:0.7451 blue:0.1961 alpha:1]];
    [musicButton setPushColor:[NSColor colorWithDeviceRed:0.5059 green:0.7451 blue:0.1961 alpha:1]];
    [musicButton setNormalColor:[NSColor colorWithDeviceRed:0.2471 green:0.2471 blue:0.2471 alpha:1]];

    
    [galleryButton setHoverColor:[NSColor colorWithDeviceRed:0.5059 green:0.7451 blue:0.1961 alpha:1]];
    [galleryButton setPushColor:[NSColor colorWithDeviceRed:0.5059 green:0.7451 blue:0.1961 alpha:1]];
    [galleryButton setNormalColor:[NSColor colorWithDeviceRed:0.2471 green:0.2471 blue:0.2471 alpha:1]];
    
    [deviceButton setHoverColor:[NSColor colorWithDeviceRed:0.5059 green:0.7451 blue:0.1961 alpha:1]];
    [deviceButton setPushColor:[NSColor colorWithDeviceRed:0.5059 green:0.7451 blue:0.1961 alpha:1]];
    [deviceButton setNormalColor:[NSColor colorWithDeviceRed:0.2471 green:0.2471 blue:0.2471 alpha:1]];
	
	[recentMusicButton setNormalColor:[NSColor colorWithDeviceRed:0.2471 green:0.2471 blue:0.2471 alpha:1]];
    [recentMusicButton setHoverColor:[NSColor colorWithDeviceRed:0.5059 green:0.7451 blue:0.1961 alpha:1]];
    [recentMusicButton setPushColor:[NSColor colorWithDeviceRed:0.5059 green:0.7451 blue:0.1961 alpha:1]];
    
    [libraryButton setNormalColor:[NSColor colorWithDeviceRed:0.2471 green:0.2471 blue:0.2471 alpha:1]];
    [libraryButton setHoverColor:[NSColor colorWithDeviceRed:0.5059 green:0.7451 blue:0.1961 alpha:1]];
    [libraryButton setPushColor:[NSColor colorWithDeviceRed:0.5059 green:0.7451 blue:0.1961 alpha:1]];
    
    [playlistButton setNormalColor:[NSColor colorWithDeviceRed:0.2471 green:0.2471 blue:0.2471 alpha:1]];
    [playlistButton setHoverColor:[NSColor colorWithDeviceRed:0.5059 green:0.7451 blue:0.1961 alpha:1]];
    [playlistButton setPushColor:[NSColor colorWithDeviceRed:0.5059 green:0.7451 blue:0.1961 alpha:1]];
	
	[recentGalleryButton setNormalColor:[NSColor colorWithDeviceRed:0.2471 green:0.2471 blue:0.2471 alpha:1]];
    [recentGalleryButton setHoverColor:[NSColor colorWithDeviceRed:0.5059 green:0.7451 blue:0.1961 alpha:1]];
    [recentGalleryButton setPushColor:[NSColor colorWithDeviceRed:0.5059 green:0.7451 blue:0.1961 alpha:1]];
    
    [ablumButton setNormalColor:[NSColor colorWithDeviceRed:0.2471 green:0.2471 blue:0.2471 alpha:1]];
    [ablumButton setHoverColor:[NSColor colorWithDeviceRed:0.5059 green:0.7451 blue:0.1961 alpha:1]];
    [ablumButton setPushColor:[NSColor colorWithDeviceRed:0.5059 green:0.7451 blue:0.1961 alpha:1]];
    
    [timeButton setNormalColor:[NSColor colorWithDeviceRed:0.2471 green:0.2471 blue:0.2471 alpha:1]];
    [timeButton setHoverColor:[NSColor colorWithDeviceRed:0.5059 green:0.7451 blue:0.1961 alpha:1]];
    [timeButton setPushColor:[NSColor colorWithDeviceRed:0.5059 green:0.7451 blue:0.1961 alpha:1]];
	
	[GridStyleButton setNormalImage:[NSImage imageNamed:@"grid_checked"]];
	[ListStyleButton setNormalImage:[NSImage imageNamed:@"list_normal"]];
    
    [musicButton setHeightLight:YES];
	[recentMusicButton setHeightLight:YES];
    [recentGalleryButton setHeightLight:YES];
	
	[playButton setHidden:NO];
	[pauseButton setHidden:YES];
	
	[volumeButton setHidden:NO];
	[GridStyleButton setHidden:YES];
	[ListStyleButton setHidden:YES];
    
    [self swichModule:10];
    [self createCategoryView];
	[self createVideoCanvas];
	[self createPictureView];
	[self createContentView];
	
	currentMusicViewTag = 11;
	currentGalleryViewTag = 21;
	
	[playProgressBar setHidden:YES];
	
	self.volumeValue = 64;
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mediaProgressValueDidChange:) name:MediaProgressBarValueDidChangeNotify object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(volumeBarValueDidChange:) name:VolumeControllerBarValueDidChangeNotify object:nil];
}

- (void)createContentView
{	
	musicRecentViewController = [[MusicRecentViewController alloc]initWithNibName:@"MusicRecentViewController" bundle:nil];
	
	musicLibraryViewController = [[MusicLibraryViewController alloc]initWithNibName:@"MusicLibraryViewController" bundle:nil];
	musicLibraryViewController.delegate = self;
	
	musicPlaylistViewController = [[MusicPlaylistViewController alloc]initWithNibName:@"MusicPlaylistViewController" bundle:nil];
	
	galleryRecentViewController = [[GalleryRecentViewController alloc]initWithNibName:@"GalleryRecentViewController" bundle:nil];
	
	galleryAblumViewController = [[GalleryAblumViewController alloc]initWithNibName:@"GalleryAblumViewController" bundle:nil];
	galleryAblumViewController.delegate = self;
	
	galleryTimeViewController = [[GalleryTimeViewController alloc]initWithNibName:@"GalleryTimeViewController" bundle:nil];
	
	deviceViewController = [[DeviceViewController alloc] initWithNibName:@"DeviceViewController" bundle:nil];
	
	settingViewController = [[MMSettingViewController alloc]initWithNibName:@"MMSettingViewController" bundle:nil];
	
	//default music recent
	[currentContentView addSubview: [musicRecentViewController view]];
	
	[[musicRecentViewController view] setFrame: [currentContentView bounds]];
	
	previousView = [musicRecentViewController view];
}

-(NSView *)categoryViewForTag:(NSInteger)tag 
{
    NSView *view = nil;
    switch(tag) 
	{
		case 10: 
			view = musicCategoryView; 
			break;
		case 20: 
			view = galleryCategoryView; 
			break;
		case 30:
			view = deviceCategoryView;
			break;
		default:
			break;
    }
    return view;
}

- (void)heightModuleButton:(NSInteger)tag
{
	switch (tag) 
	{
		case 10:
			[musicButton setHeightLight:YES];
			[galleryButton setHeightLight:NO];
			[deviceButton setHeightLight:NO];
			break;
		case 20:
			[musicButton setHeightLight:NO];
			[galleryButton setHeightLight:YES];
			[deviceButton setHeightLight:NO];
			break;
		case 30:
			[musicButton setHeightLight:NO];
			[galleryButton setHeightLight:NO];
			[deviceButton setHeightLight:YES];
			break;
		default:
			break;
	}
}

- (void)heightContentButton:(NSInteger)tag
{
	switch (tag)
	{
		case 11:
			[recentMusicButton setHeightLight:YES];
			[libraryButton setHeightLight:NO];
			[playlistButton setHeightLight:NO];
			break;
		case 12:
			[recentMusicButton setHeightLight:NO];
			[libraryButton setHeightLight:YES];
			[playlistButton setHeightLight:NO];
			break;
		case 13:
			[recentMusicButton setHeightLight:NO];
			[libraryButton setHeightLight:NO];
			[playlistButton setHeightLight:YES];
			break;
		case 21:
			[recentGalleryButton setHeightLight:YES];
			[ablumButton setHeightLight:NO];
			[timeButton setHeightLight:NO];
			break;
		case 22:
			[recentGalleryButton setHeightLight:NO];
			[ablumButton setHeightLight:YES];
			[timeButton setHeightLight:NO];
			break;
		case 23:
			[recentGalleryButton setHeightLight:NO];
			[ablumButton setHeightLight:NO];
			[timeButton setHeightLight:YES];
			break;
		default:
			break;
	}
}

-(NSView *)contentViewForTag:(NSInteger)tag 
{
	return nil;
}


- (IBAction)switchContentView:(id)sender
{
	NSInteger tag = [sender tag];
	[self heightContentButton:tag];

	if(tag>10 && tag<20)
	{
		currentMusicViewTag = tag;
	}
	else if(tag>20 && tag<30)
	{
		currentGalleryViewTag = tag;
	}
	else
	{
		
	}

	[self switchContentViewController:tag];
}

- (void)switchContentViewController:(NSInteger)tag
{
	[GridStyleButton setHidden:YES];
	[ListStyleButton setHidden:YES];
	switch (tag) 
	{
		case 11:
			myTargetViewController = musicRecentViewController;
			break;
		case 12:
			myTargetViewController = musicLibraryViewController;
			[GridStyleButton setHidden:NO];
			[ListStyleButton setHidden:NO];
			break;
		case 13:
			myTargetViewController = musicPlaylistViewController;
			break;
		case 21:
			myTargetViewController = galleryRecentViewController;
			break;
		case 22:
			myTargetViewController = galleryAblumViewController;
			[GridStyleButton setHidden:NO];
			[ListStyleButton setHidden:NO];
			break;
		case 23:
			myTargetViewController = galleryTimeViewController;
			[GridStyleButton setHidden:NO];
			[ListStyleButton setHidden:NO];
			break;
		case 30:
			myTargetViewController = deviceViewController;
			break;
		default:
			break;
	}
	[currentContentView replaceSubview:previousView with:[myTargetViewController view]];
	NSRect bounds = [currentContentView bounds];
	[[myTargetViewController view] setFrame: bounds];
	previousView = [myTargetViewController view];
	
	//NSWindow *window = [self window];
	//[window makeFirstResponder:[myTargetViewController view]];
}

- (IBAction)switchCategoryView:(id)sender 
{
	NSInteger tag = [sender tag];
	[self heightModuleButton:tag];
	NSView *view = [self categoryViewForTag:tag];
	NSView *previous = [self categoryViewForTag: currentCategoryViewTag];
	currentCategoryViewTag = tag;
	
	//NSRect newFrame = [view bounds];
	
	//[NSAnimationContext beginGrouping];
	
	// With the shift key down, do slow-mo animation
	//if ([[NSApp currentEvent] modifierFlags] & NSShiftKeyMask)
	  //  [[NSAnimationContext currentContext] setDuration:1.0];
	
	// Call the animator instead of the view / window directly
	[moduleListContentView replaceSubview:previous with:view];
	//[[[self window] animator] setFrame:newFrame display:YES];
	
	//[NSAnimationContext endGrouping];

	switch (tag) 
	{
		case 10:
			[self switchContentViewController:currentMusicViewTag];
			break;
		case 20:
			[self switchContentViewController:currentGalleryViewTag];
			break;
		case 30:
			[self switchContentViewController:30];
			break;
		default:
			break;
	}
}

- (IBAction)backButton:(id)sender
{
    NSRunAlertPanel(@"MediaManager", @"backButton", nil, nil, nil);
}


/*
- (void)drawRect:(NSRect)rect {
    
    NSRect bounds = self.bounds;
    
    // Draw background gradient
    NSGradient *gradient = [[NSGradient alloc] initWithColorsAndLocations:
                            [NSColor colorWithDeviceWhite:0.15f alpha:1.0f], 0.0f, 
                            [NSColor colorWithDeviceWhite:0.19f alpha:1.0f], 0.5f, 
                            [NSColor colorWithDeviceWhite:0.20f alpha:1.0f], 0.5f, 
                            [NSColor colorWithDeviceWhite:0.25f alpha:1.0f], 1.0f, 
                            nil];
    
    [gradient drawInRect:bounds angle:90.0f];
    [gradient release];
    
    // Stroke bounds
    [[NSColor blackColor] setStroke];
    [NSBezierPath strokeRect:bounds];
}*/



- (void)swichModule:(NSInteger)tag
{
//    if(moduleListContentViewController)
//    {
//        if ([moduleListContentViewController view] != nil)
//            [[moduleListContentViewController view] removeFromSuperview];	// remove the current view
//        
//        if (moduleListContentViewController != nil)
//        {
//            [moduleListContentViewController release];
//            moduleListContentViewController = nil;
//        }
//    }
//    		// remove the current view controller
//    switch (tag) 
//    {
//        case 10:
//        {
//            MMMusicItemController *viewController = [[MMMusicItemController alloc] initWithNibName:@"MMMusicItemController" bundle:nil];
//			if (viewController != nil)
//			{
//				moduleListContentViewController = viewController;	// keep track of the current view controller
//			}
//            [musicButton setHeightLight:YES];
//            [galleryButton setHeightLight:NO];
//            [deviceButton setHeightLight:NO];
//            break;
//        }
//        case 20:
//        {
//            MMGalleryItemController *viewController = [[MMGalleryItemController alloc] initWithNibName:@"MMGalleryItemController" bundle:nil];
//			if (viewController != nil)
//			{
//				
//				moduleListContentViewController = viewController;	// keep track of the current view controller
//			}
//            [musicButton setHeightLight:NO];
//            [galleryButton setHeightLight:YES];
//            [deviceButton setHeightLight:NO];
//            break;
//        }
//        case 30:
//        {
//            [musicButton setHeightLight:NO];
//            [galleryButton setHeightLight:NO];
//            [deviceButton setHeightLight:YES];
//            return;
//        }
//        default:
//            break;
//    }
//    //NSView *v = [moduleListContentViewController view];
//    //[v setAlphaValue:0];
//    
//    // embed the current view to our host view
//    [moduleListContentView addSubview: [moduleListContentViewController view]];
//    // make sure we automatically resize the controller's view to the current window size
//    [[moduleListContentViewController view] setFrame: [moduleListContentView bounds]];
}

- (IBAction)chooseModule:(id)sender
{
	
    //NSButton *b = (NSButton*)sender;
//    if(b)
//    {
//        [self swichModule:[b tag]];
//    }
    
}

- (IBAction)hello:(id)sender
{
    NSLog(@"hello\n");
}

- (IBAction)addAlbum:(id)sender
{
	//[musicRecentViewController addAlbum];
}

- (BOOL)needPlayMusic:(NSMutableDictionary*)song
{
        /*
	NSLog(@"needPlayAlbum path=%@",[song valueForKey:kMusicPathDataKey]);
	NSLog(@"startPlay");
	lastPlayMediaFile = [song valueForKey:kMusicPathDataKey];
	[albumImageView setImage:[song valueForKey:kMusicImageDataKey]];
	self.title = [song valueForKey:kMusicTitleDataKey];
	self.albumname = [song valueForKey:kMusicAlbumDataKey];
 	if(ffplayer)
	{
		[ffplayer stop];
		[ffplayer release];
		ffplayer = nil;
	}
	
	ffplayer = [[FFPlayer alloc]initWithPathOfFile:[song valueForKey:kMusicPathDataKey]];
	if(ffplayer == nil)
		return NO;
	
	ffplayer.delegate = self;
	[ffplayer changeVolume:self.volumeValue];
	NSLog(@"duration == %d",ffplayer.duration);
	[ffplayer play];
	[playProgressBar setHidden:NO];
     */
	return YES;
}

- (BOOL)needPlayVideoInCanvas:(NSMutableDictionary*)video
{
    /*
	[currentContentView replaceSubview:previousView with:galleryVideoCanvas];
	NSRect bounds = [currentContentView bounds];
	[galleryVideoCanvas setFrame: bounds];
	previousView = galleryVideoCanvas;
	
	lastPlayMediaFile = [video valueForKey:kGalleryPathDataKey];
	[albumImageView setImage:[video valueForKey:kGalleryImageDataKey]];
	self.title = [video valueForKey:kGalleryTitleDataKey];	
	if(ffplayer)
	{
		[ffplayer stop];
		[ffplayer release];
		ffplayer = nil;
	}
	ffplayer = [[FFPlayer alloc]initWithPathOfFile:[video valueForKey:kGalleryPathDataKey]];
	if(ffplayer == nil)
		return NO;
	
	ffplayer.delegate = self;
	[ffplayer changeVolume:self.volumeValue];
	NSLog(@"duration == %d",ffplayer.duration);
	[ffplayer play];
	[playProgressBar setHidden:NO];
	*/
	return YES;
}

- (BOOL)needOpenImageInArray:(NSString*)picture
{
	[currentContentView replaceSubview:previousView with:galleryPictureListView];
	NSRect bounds = [currentContentView bounds];
	[galleryPictureListView setFrame: bounds];
	previousView = galleryPictureListView;
	NSImage *image = [[NSImage alloc]initWithContentsOfFile:picture];
	[pictureOverview setImage:image];
	[image release];
	return YES;
}
/*
- (void)ffplayer:(FFPlayer *)fp playcallbackstatus:(int)status currenttime:(double)current totaltime:(double)total;
{
	switch(status)
	{
		case AV_START:
		{
			[playButton setHidden:YES];
			[pauseButton setHidden:NO];
			{
				self.beginTime = [NSString stringWithFormat:@"00:00:00"];
				
				int hours, mins, secs;
				secs = ffplayer.duration;
				mins = secs / 60;
				secs %= 60;
				hours = mins / 60;
				mins %= 60;
				self.endTime = [NSString stringWithFormat:@"-%02d:%02d:%02d",hours,mins,secs ];
			}
			
			bPlaying = YES;
		}
			break;
		case AV_RUNNING:
		{
			float nCurTime = current*100/total;
			[playProgressBar setDoubleValue:nCurTime];
			{
				int hours, mins, secs;
				secs = current;
				mins = secs / 60;
				secs %= 60;
				hours = mins / 60;
				mins %= 60;
				self.beginTime = [NSString stringWithFormat:@"%02d:%02d:%02d",hours,mins,secs ];
			}
			{
				int end = total - current;
				int hours, mins, secs;
				secs = end;
				mins = secs / 60;
				secs %= 60;
				hours = mins / 60;
				mins %= 60;
				self.endTime = [NSString stringWithFormat:@"-%02d:%02d:%02d",hours,mins,secs ];
			}
			pts = current;
		}
			break;
		case AV_END:
		{
			[pauseButton setHidden:YES];
			[playButton setHidden:NO];
			[playProgressBar setDoubleValue:100.00];
			bPlaying = NO;
			
			if(ffplayer)
			{
				//[ffplayer stop];
				[ffplayer release];
				ffplayer = nil;
			}
		}
			break;
		default:
			break;
	}
}*/

- (void)needDispalyVideoData:(NSImage*)image
{
	[galleryVideoCanvas updateView:image];
}

- (IBAction)playButton:(id)sender
{
    /*
	if(!bPlaying)
	{
		if(ffplayer)
		{
			[ffplayer stop];
			[ffplayer release];
			ffplayer = nil;
		}
		if(lastPlayMediaFile!=nil)
		{
			ffplayer = [[FFPlayer alloc]initWithPathOfFile:lastPlayMediaFile];
			if(ffplayer == nil)
				return;
			
			ffplayer.delegate = self;
			[ffplayer changeVolume:self.volumeValue];
			[ffplayer play];
			//[playButton setTitle:@"Pause"];
			[playButton setHidden:YES];
			[pauseButton setHidden:NO];
			bPlaying = YES;
		}
	}
	else
	{
		[ffplayer pause];
		if(!bPaused)
		{
			//[playButton setTitle:@"Play"];
			[playButton setHidden:NO];
			[pauseButton setHidden:YES];
		}
		else 
		{
			//[playButton setTitle:@"Pause"];
			[playButton setHidden:YES];
			[pauseButton setHidden:NO];
		}
		bPaused = !bPaused;
	}
     */
}

- (IBAction)pauseButton:(id)sender
{
	//[ffplayer pause];
	if(!bPaused)
	{
		//[playButton setTitle:@"Play"];
		[playButton setHidden:NO];
		[pauseButton setHidden:YES];
	}
	else 
	{
		//[playButton setTitle:@"Pause"];
		[playButton setHidden:YES];
		[pauseButton setHidden:NO];
	}
	bPaused = !bPaused;
}

- (IBAction)movebackButton:(id)sender
{
	//[ffplayer moveback];
}

- (IBAction)forwardButton:(id)sender
{
	//[ffplayer forward];
}

- (void)mediaProgressValueDidChange:(NSNotification *)aNotification 
{
    /*
	if(playProgressBar == [aNotification object])
	{
		NSNumber *progress=[[aNotification userInfo] objectForKey:@"ProgressBarValue"];
		[ffplayer pause];
		
		double second = ([progress intValue] * ffplayer.duration)/100;
		[ffplayer seekframe:second  - pts];
		[ffplayer pause];
	}*/
	//[progressField setStringValue:[NSString stringWithFormat:@"%f",[progress floatValue]]];
}

- (void)volumeBarValueDidChange:(NSNotification *)aNotification
{
	if(volumeBar == [aNotification object])
	{
		NSNumber *value=[[aNotification userInfo] objectForKey:@"VolumeBarValue"];
		self.volumeValue = [value intValue];
		if([value intValue]>=98)
		{
			//full volume
			[volumeButton setNormalImage:[NSImage imageNamed:@"Volume_4"]];
		}
		else if([value intValue]>= 48 && [value intValue]<98)
		{
			//middle volume
			[volumeButton setNormalImage:[NSImage imageNamed:@"Volume_3"]];
		}
		else if([value intValue]> 0 && [value intValue]<48){
			//small volume
			[volumeButton setNormalImage:[NSImage imageNamed:@"Volume_2"]];
		}
		else {
			[volumeButton setNormalImage:[NSImage imageNamed:@"Volume_1"]];
		}

	}
}

- (void)setVolumeValue:(int)value
{
    /*
	if(ffplayer)
		[ffplayer changeVolume:value];
	lastVolueValue = volumeValue;
	volumeValue = value;
     */
}

- (int)volumeValue
{
	return volumeValue;
}

- (IBAction)volumeButtonAction:(id)sender
{
	//[volumeButton setHidden:YES];
	//[muteButton setHidden:NO];
    /*
	if(self.volumeValue > 0)
	{
		[volumeButton setNormalImage:[NSImage imageNamed:@"Volume_1"]];
		self.volumeValue = 0;
		[ffplayer changeVolume:self.volumeValue];
	}
	else {
		self.volumeValue = lastVolueValue;
		[ffplayer changeVolume:self.volumeValue];
		if(self.volumeValue>=98)
		{
			//full volume
			[volumeButton setNormalImage:[NSImage imageNamed:@"Volume_4"]];
		}
		else if(self.volumeValue>= 48 && self.volumeValue<98)
		{
			//middle volume
			[volumeButton setNormalImage:[NSImage imageNamed:@"Volume_3"]];
		}
		else if(self.volumeValue> 0 && self.volumeValue<48){
			//small volume
			[volumeButton setNormalImage:[NSImage imageNamed:@"Volume_2"]];
		}
		else {
			[volumeButton setNormalImage:[NSImage imageNamed:@"Volume_1"]];
		}
	}*/
}

- (IBAction)albumDisplayModeAction:(id)sender
{
	NSButton *bt = (NSButton*)sender;
	if(bt.tag==101)
	{
		[GridStyleButton setNormalImage:[NSImage imageNamed:@"grid_normal"]];
		[ListStyleButton setNormalImage:[NSImage imageNamed:@"list_checked"]];
		[musicLibraryViewController toggleShowMode:TableListView];
	}
	else 
	{
		[GridStyleButton setNormalImage:[NSImage imageNamed:@"grid_checked"]];
		[ListStyleButton setNormalImage:[NSImage imageNamed:@"list_normal"]];
		[musicLibraryViewController toggleShowMode:GridListView];
	}
}
/*
 [GridStyleButton setNormalImage:[NSImage imageNamed:@"grid_checked"]];
 [ListStyleButton setNormalImage:[NSImage imageNamed:@"list_normal"]];
 */

- (IBAction)settingAction:(id)sender
{
	[GridStyleButton setHidden:YES];
	[ListStyleButton setHidden:YES];
	myTargetViewController = settingViewController;
	[currentContentView replaceSubview:previousView with:[myTargetViewController view]];
	NSRect bounds = [currentContentView bounds];
	[[myTargetViewController view] setFrame: bounds];
	previousView = [myTargetViewController view];
}

@end
