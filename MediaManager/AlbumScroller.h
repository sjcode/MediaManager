//
//  AlbumScroller.h
//  MediaManager
//
//  Created by Arthur on 5/7/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSScroller (CustomWidthScroller)
+(CGFloat)scrollerWidth;
@end

@interface AlbumScroller : NSScroller 
{

}

@end
