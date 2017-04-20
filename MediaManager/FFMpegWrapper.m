//
//  FFMpegWrapper.m
//  MediaManager
//
//  Created by Arthur on 5/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "FFMpegWrapper.h"
//#include <libavcodec/avcodec.h>    // required headers
//#include <libavformat/avformat.h>

@implementation FFMpegWrapper
@synthesize duration;
- (id)initWithPath:(NSString*)path
{
	if(self = [super init])
	{
		file = [[NSString alloc] initWithString:path];
        /*
		AVFormatContext *pFormatCtx = NULL;
		AVCodecContext *pCodecCtx;
		AVCodec         *pCodec;
		
		if(av_open_input_file(&pFormatCtx, [file cStringUsingEncoding:NSUTF8StringEncoding], NULL, 0, NULL)==0)
		{
			if(av_find_stream_info(pFormatCtx)==0)
			{
				
				self.duration = pFormatCtx->streams[0]->duration*pFormatCtx->streams[0]->time_base.num/pFormatCtx->streams[0]->time_base.den; 
			}
		}
		
		// Close the video file
		if (pFormatCtx) av_close_input_file(pFormatCtx);
		*/
	}
	return self;
}

- (void)dealloc
{
	[file release];
	[super dealloc];
}


@end
