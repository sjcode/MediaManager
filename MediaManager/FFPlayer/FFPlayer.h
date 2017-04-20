//
//  FFPlayer.h
//  PlayMp3WithFFMPEG
//
//  Created by Arthur on 5/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#include <libavcodec/avcodec.h>    // required headers
#include <libavformat/avformat.h>
#include "ffplay.h"

enum  {
	AV_AUDIO,
	AV_VIDEO
};

enum  {
	AV_START,
	AV_RUNNING,
	AV_END
};

@protocol FFPlayerDelegate;
@interface FFPlayer : NSObject 
{
	id context;
	id<FFPlayerDelegate> delegate;
}
@property (nonatomic,retain) id delegate;
@property (nonatomic,copy)NSString *mediaFile;
@property (nonatomic,assign) int duration;
@property (nonatomic,assign) int codec;
@property (nonatomic,assign) int mediaType;


- (id)initWithPathOfFile:(NSString*)path;

- (BOOL)play;
- (void)pause;
- (void)seekframe:(double)second;
- (void)stop;
- (void)moveback;
- (void)forward;
- (void)changeVolume:(int)value;
@end

@protocol FFPlayerDelegate
- (void)ffplayer:(FFPlayer *)fp playcallbackstatus:(int)status currenttime:(double)current totaltime:(double)total;
- (void)needDispalyVideoData:(NSImage*)image;
@end
