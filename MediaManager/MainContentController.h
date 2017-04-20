//
//  SJContentController.h
//  MediaManager
//
//  Created by jian su on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CategoryView.h"
#import "MusicRecentViewController.h"
#import "MusicLibraryViewController.h"
#import "MusicPlaylistViewController.h"
#import "GalleryRecentViewController.h"
#import "GalleryAblumViewController.h"
#import "GalleryTimeViewController.h"
#import "DeviceViewController.h"
//#import "FFPlayer.h"
#import "PlayControllerDelegate.h"
#import "AlbumWrapper.h"
#import "MediaProgressBar.h"
#import "VolumeControllerBar.h"
#import "CustomImageButtonCell.h"
#import "MediaFileManager.h"
#import "GalleryVideoCanvas.h"
#import "GalleryPictureListView.h"
#import "MMSettingViewController.h"

@interface MainContentController : NSWindowController </*FFPlayerDelegate,*/PlayControllerDelegate>
{
	//head
	IBOutlet NSButton *backButton,*musicButton,*galleryButton,*deviceButton,*settingButton;
	
	//neck
	IBOutlet NSButton *recentGalleryButton,*ablumButton,*timeButton;
	IBOutlet NSButton *recentMusicButton,*libraryButton,*playlistButton;
	IBOutlet CategoryView *musicCategoryView,*galleryCategoryView,*deviceCategoryView;
	IBOutlet NSView *moduleListContentView;
	NSInteger currentCategoryViewTag;
	NSInteger currentMusicViewTag,currentGalleryViewTag;
	
	IBOutlet CustomImageButton *GridStyleButton;
	IBOutlet CustomImageButton *ListStyleButton;
	
	//body
	IBOutlet NSView *currentContentView;
	NSView *previousView;
    NSViewController *myTargetViewController;
	IBOutlet NSButton *clickButton;
	
	MusicRecentViewController *musicRecentViewController;
	MusicLibraryViewController *musicLibraryViewController;
	MusicPlaylistViewController *musicPlaylistViewController;
	
	GalleryRecentViewController *galleryRecentViewController;
	GalleryAblumViewController *galleryAblumViewController;
	GalleryTimeViewController *galleryTimeViewController;
	
	DeviceViewController *deviceViewController;
	
	//FFPlayer *ffplayer;
	
	//foot
	IBOutlet CustomImageButton *bt1;
    IBOutlet CustomImageButton *bt2;
	IBOutlet CustomImageButton *movebackButton;
    IBOutlet CustomImageButton *playButton;
	IBOutlet CustomImageButton *pauseButton;
    IBOutlet CustomImageButton *forwardButton;
    
    IBOutlet CustomImageButton *volumeButton;
	IBOutlet VolumeControllerBar * volumeBar;
	int volumeValue,lastVolueValue;
	IBOutlet CustomImageButton *moreButton,*addtoAblumButton,*sendtophoneButton;
	IBOutlet MediaProgressBar *playProgressBar;
	IBOutlet NSImageView *albumImageView;

	BOOL bPlaying,bPaused;
	int sliderBarNum;
	double pts;
	
	//
	NSString *lastPlayMediaFile;
	
	//NSView *videoCanvas;
	IBOutlet GalleryVideoCanvas *galleryVideoCanvas;
	IBOutlet GalleryPictureListView *galleryPictureListView;
	IBOutlet NSImageView *pictureOverview;
	
	//setting view
	IBOutlet NSView *settingView;
	MMSettingViewController *settingViewController;

}
- (IBAction)switchCategoryView:(id)sender;

- (IBAction)backButton:(id)sender;
- (void)swichModule:(NSInteger)tag;
- (IBAction)chooseModule:(id)sender;

- (IBAction)hello:(id)sender;

- (void)createCategoryView;

- (IBAction)switchContentView:(id)sender;
- (void)createContentView;
- (void)switchContentViewController:(NSInteger)tag;

- (IBAction)addAlbum:(id)sender;

- (IBAction)sliderBarClick:(id)sender;

- (IBAction)movebackButton:(id)sender;
- (IBAction)playButton:(id)sender;
- (IBAction)pauseButton:(id)sender;
- (IBAction)forwardButton:(id)sender;

- (IBAction)volumeButtonAction:(id)sender;

- (IBAction)albumDisplayModeAction:(id)sender;

- (IBAction)settingAction:(id)sender;

@property (nonatomic,retain)NSString *title;
@property (nonatomic,retain)NSString *albumname;
@property (nonatomic,retain)NSString *beginTime;
@property (nonatomic,retain)NSString *endTime;

@property (nonatomic,assign)int volumeValue;
@end
