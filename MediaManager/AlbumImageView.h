//
//  AlbumImageView.h
//  MediaManager
//
//  Created by Arthur on 5/7/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol AlbumImageDelegate
- (void)mouseEntered:(NSEvent *)event;
- (void)mouseExited:(NSEvent *)event;
- (void)mouseDown:(NSEvent *)event;
- (void)mouseUp:(NSEvent *)event;
@end

@interface AlbumImageView : NSImageView 
{
	id<AlbumImageDelegate> delegate;
}

@property (nonatomic,retain) id delegate;
@end
