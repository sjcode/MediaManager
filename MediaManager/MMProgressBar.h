//
//  MMProgressBar.h
//  MediaManager
//
//  Created by Arthur on 7/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

APPKIT_EXTERN NSString * MMProgressBarValueDidChangeNotify;
@interface MMProgressBar : NSProgressIndicator {
	BOOL isMouseDown;
	NSDate	*lastpostdate;
	
	NSImage *progressImage;
	NSImage *thumbImage;
	NSImage *knobImage;
	
	NSImage *progressImageLeft,*progressImageMiddle,*progressImageRight;
	NSImage *thumbImageLeft,*thumbImageMiddle,*thumbImageRight;
	BOOL isMouseEnter;
	BOOL isKnobRelease;
}

- (void) mouseDown:(NSEvent *)theEvent;
- (void) mouseDragged:(NSEvent *)theEvent;

- (void) drawRect:(NSRect)aRect;

@end
