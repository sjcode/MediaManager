//
//  GalleryVideoCanvas.h
//  MediaManager
//
//  Created by Arthur on 6/10/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface GalleryVideoCanvas : NSImageView {
	NSImage *frameImage;
}

@property (nonatomic, retain)NSImage *frameImage;
- (void)updateView:(NSImage*)image;

@end
