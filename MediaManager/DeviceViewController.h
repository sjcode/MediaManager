//
//  DeviceViewController.h
//  MediaManager
//
//  Created by Arthur on 6/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DeviceOverView.h"
#import "CustomImageButtonCell.h"
#import "MMStyleWindow.h"
@interface DeviceViewController : NSViewController 
{
	NSView *previousView;
	IBOutlet ContentView *deviceListView;
	IBOutlet DeviceOverView *deviceOverView;
	IBOutlet NSButton *deviceButton;
	NSInteger categoryFont;
	
	IBOutlet NSBox *contentViewBox;
	IBOutlet NSBox *subViewBox;
	IBOutlet NSView *deviceView;
	IBOutlet NSView *syncView;
	IBOutlet NSView *editView;
	IBOutlet NSButton *syncNowButton;
	IBOutlet NSButton *isAutoSyncCheckBoxBtn;
	IBOutlet NSComboBox *storageCombo;
	
	IBOutlet NSView *musicConfigureView;
	IBOutlet NSView *galleryConfigureView;
	IBOutlet NSView *peopleConfigureView;
	IBOutlet NSView *calendarConfigureView;
	IBOutlet NSView *documentConfigureView;
	IBOutlet NSView *bookmarkConfigureView;
	
	IBOutlet NSButton *galleryDoneBtn;
	IBOutlet NSButton *musicDoneBtn;
	IBOutlet NSButton *peopleDoneBtn;
	IBOutlet NSButton *calendarDoneBtn;
	IBOutlet NSButton *documentDoneBtn;
	IBOutlet NSButton *bookmarksDoneBtn;
	
	//IBOutlet NSPanel *mSettingsPanel;
	
	IBOutlet NSView *view1;
	double progressStep;
}

- (IBAction)toggleDevice:(id)sender;
- (IBAction)toggleView:(id)sender;
- (IBAction)toggleConfigureView:(id)sender;
- (IBAction)doneConfigureView:(id)sender;

- (IBAction)startSync:(id)sender;

@property (assign,readonly)NSInteger entryFontSize;
@property (nonatomic,assign,readonly)NSInteger categoryFontSize;
@property (nonatomic,assign,readonly)NSInteger deviceModelFontSize;
@property (retain,readonly)NSColor * historyTextColor;
@property (retain,readonly)NSColor *textColor;
@property (assign)double progressStep;
@end
