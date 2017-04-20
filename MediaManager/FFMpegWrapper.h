//
//  FFMpegWrapper.h
//  MediaManager
//
//  Created by Arthur on 5/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface FFMpegWrapper : NSObject 
{
	NSString *file;
}
@property (nonatomic,assign)int duration;

@end
