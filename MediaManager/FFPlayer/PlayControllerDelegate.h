//
//  PlayControllerDelegate.h
//  MediaManager
//
//  Created by Arthur on 5/18/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AlbumWrapper.h"

@protocol PlayControllerDelegate
- (BOOL)needPlayMusic:(NSMutableDictionary*)song;
- (BOOL)needPlayVideoInCanvas:(NSMutableDictionary*)video;
- (BOOL)needOpenImageInArray:(NSString*)picture;
@end
