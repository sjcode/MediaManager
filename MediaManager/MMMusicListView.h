//
//  MMMusicListView.h
//  MediaManager
//
//  Created by Arthur on 7/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>
#import "MMMusicListCell.h"

@interface MMMusicListView : IKImageBrowserView 
{
	NSRect lastVisibleRect;
	MMMusicListCell *lastHoverMouseCell;
	NSRect mouseHoverRect;
}
@property (nonatomic,assign)NSRect mouseHoverRect;
@end
