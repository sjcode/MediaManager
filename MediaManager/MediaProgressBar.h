//
//  MediaProgressBar.h
//  CustomSliderBar
//
//  Created by Arthur on 5/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

APPKIT_EXTERN NSString * MediaProgressBarValueDidChangeNotify;

@interface MediaProgressBar : NSProgressIndicator
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
