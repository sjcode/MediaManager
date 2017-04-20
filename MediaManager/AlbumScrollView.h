//
//  AlbumScrollView.h
//  MediaManager
//
//  Created by Arthur on 5/17/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol AlbumScrollViewDelegate
- (void)albumScrollWheel:(NSEvent *)theEvent;
@end


@interface AlbumScrollView : NSScrollView {
	id<AlbumScrollViewDelegate> delegate;
}

@property (nonatomic,retain)id delegate;
@end
