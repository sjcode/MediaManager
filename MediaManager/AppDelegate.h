//
//  AppDelegate.h
//  MediaManager
//
//  Created by jian su on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MainContentController.h"

@interface AppDelegate : NSObject<NSWindowDelegate>
{
    MainContentController *mainContentController;
	NSWindowController *splashWindowController;
	
	IBOutlet MediaFileManager *fileManager;
}

- (void)loadFinish:(id)obj;
@property (nonatomic,retain)MediaFileManager *fileManager;

@end
