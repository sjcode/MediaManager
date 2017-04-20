//
//  VolumeControllerBar.h
//  MediaManager
//
//  Created by Arthur on 5/21/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

APPKIT_EXTERN NSString * VolumeControllerBarValueDidChangeNotify;

@interface VolumeControllerBar : NSProgressIndicator 
{
	BOOL isMouseDown;
	NSDate	*lastpostdate;
	
	NSImage *progressImage;
	NSImage *thumbImage;
	NSImage *knobImage;
	BOOL isMouseEnter;
	BOOL isKnobRelease;
}

- (void) mouseDown:(NSEvent *)theEvent;
- (void) mouseDragged:(NSEvent *)theEvent;
- (void) drawRect:(NSRect)aRect;

@end
