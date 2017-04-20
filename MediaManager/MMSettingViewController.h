//
//  MMSettingViewController.h
//  MediaManager
//
//  Created by Arthur on 7/27/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MMSimpleComboBox.h"
#import "MMStyleWindow.h"

@interface MMSettingViewController : NSViewController 
{
	IBOutlet NSBox *contentViewBox;
	IBOutlet NSView *musicLibraryView;
	IBOutlet NSView *galleryLibraryView;
	IBOutlet NSView *videoView;
	IBOutlet NSView *importCDView;
	
	//music setting
	NSImage *divideLine;
	IBOutlet NSBox *musicSimpleComboBox;
	IBOutlet NSScrollView *myScrollView;
	IBOutlet NSTableView *myTable;
	IBOutlet NSArrayController *musicFolderArray;
	
	
	//import window
	IBOutlet NSView *importView;
	double progressStep;
	double progressMax;
	NSString *sreachFilename;
}

- (IBAction)toggleView:(id)sender;
- (IBAction)addMusic:(id)sender;

@property (nonatomic,assign,readonly)NSInteger categroyFontSize;
@property (nonatomic,retain,readonly)NSColor *textColor;
@property (assign)double progressStep;
@property (assign)double progressMax;
@property (nonatomic,retain)NSString *sreachFilename;
@end

