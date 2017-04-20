//
//  MMStyleWindow.h
//  MediaManager
//
//  Created by Arthur on 7/10/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface MMStyleWindow : NSWindow {
	BOOL customShadow;
}

- (id)initWithContentRect:(NSRect)contentRect withView:(NSView*)view;
- (void)setCustomShadow:(BOOL)s;

@end
