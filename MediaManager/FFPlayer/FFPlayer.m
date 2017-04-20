//
//  FFPlayer.m
//  PlayMp3WithFFMPEG
//
//  Created by Arthur on 5/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "FFPlayer.h"
void ffplaycallback(void *ref,int status,double cursec,double totalsec);
void videocallback(AVPicture *pic,int width,int height);
@interface FFPlayer(Private)
- (BOOL)initializePlayer;
@end

FFPlayer *ffplayer;

@implementation FFPlayer


@synthesize duration,mediaFile,delegate,codec,mediaType;
	
- (id)initWithPathOfFile:(NSString*)path
{	
	if(self = [super init] )
	{
		self.mediaFile = path;
		if(![self initializePlayer])
			return nil;
		ffplayer = self;
	}
	return self;
}

- (BOOL)play
{
	if(startplay(context)!=0)
	{
		return NO;
	}
	return YES;
}
	
- (void)pause
{
	pauseplay(context);
}
	
- (void)seekframe:(double)second
{
	if(context)
		seek_newtime(context,second);
}
	
- (void)stop
{
	stopplay(context);
}

- (void)moveback
{
	if(context)
	seek_newtime(context,-10);
}

- (void)forward
{
	if(context)
		seek_newtime(context,10);
}

#pragma mark - FFPlayer Private

- (BOOL)initializePlayer
{
	AVFormatContext *pFormatCtx = NULL;
	BOOL bRet = NO;
	av_register_all();
	
	do {
		if (av_open_input_file(&pFormatCtx, [mediaFile cStringUsingEncoding:NSUTF8StringEncoding], NULL, 0, NULL) != 0)
			break;
		
		if (av_find_stream_info(pFormatCtx) < 0)
			break;
		
		int hours, mins, secs, us;
		secs = pFormatCtx->duration / AV_TIME_BASE;
		us = pFormatCtx->duration % AV_TIME_BASE;
		mins = secs / 60;
		secs %= 60;
		hours = mins / 60;
		mins %= 60;
		NSLog(@"play time = %02d:%02d:%02d",hours,mins,secs);
		
		self.duration = pFormatCtx->duration / AV_TIME_BASE;
		
		context = initplayer([mediaFile cStringUsingEncoding:NSUTF8StringEncoding],ffplaycallback,videocallback);
//		VideoState *is = (VideoState *)context;
//		if(!is)
//			break;
//		if(is->video_st && is->audio_st)
//		{
//			mediaType = AV_VIDEO;
//		}
//		else if(is->audio_st)
//		{
//			mediaType = AV_AUDIO;
//		}
//		else {
//			break;
//		}

		bRet = YES;
		
	} while (NO);
	if (pFormatCtx) 
		av_close_input_file(pFormatCtx);
	
	return bRet;
}

#pragma mark ffcallback
void ffplaycallback(void *ref,int status,double cursec,double totalsec)
{
	NSAutoreleasePool	*pool = [[NSAutoreleasePool alloc] init];
	
	if(ffplayer.delegate && 
	   [ffplayer.delegate respondsToSelector:@selector(ffplayer:playcallbackstatus:currenttime:totaltime:)])
	{
		[ffplayer.delegate ffplayer:ffplayer playcallbackstatus:status currenttime:cursec totaltime:totalsec];
	}
	[pool release];	
}

void videocallback(AVPicture *pic,int width,int height)
{	
	NSAutoreleasePool	*pool = [[NSAutoreleasePool alloc] init];
	if(ffplayer.delegate && 
	   [ffplayer.delegate respondsToSelector:@selector(needDispalyVideoData:)])
	{
		CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
		CFDataRef data = CFDataCreateWithBytesNoCopy(kCFAllocatorDefault, pic->data[0], pic->linesize[0]*height,kCFAllocatorNull);
		CGDataProviderRef provider = CGDataProviderCreateWithCFData(data);
		CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
		CGImageRef cgImage = CGImageCreate(width, 
										   height, 
										   8, 
										   24, 
										   pic->linesize[0], 
										   colorSpace, 
										   bitmapInfo, 
										   provider, 
										   NULL, 
										   NO, 
										   kCGRenderingIntentDefault);
		CGColorSpaceRelease(colorSpace);
		NSImage* image = [[[NSImage alloc]initWithCGImage:cgImage 
													 size:CGSizeMake(width,height)]autorelease];
		
		CGImageRelease(cgImage);
		CGDataProviderRelease(provider);
		CFRelease(data);
		
		[ffplayer.delegate needDispalyVideoData:image];
	}
	[pool release];	
}

- (void)changeVolume:(int)value
{
	if(context)
	changeVolume(context,value);
}

@end
