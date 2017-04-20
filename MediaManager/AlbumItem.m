//
//  AlbumItem.m
//  MediaManager
//
//  Created by Arthur on 5/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AlbumItem.h"


@implementation AlbumItem
@synthesize index,title,albumName,coverImage,context;

- (id)initWithTitle:(NSString*)albumOftitle
{
	if(self = [super init])
	{
		self.title = albumOftitle;
	}
	return self;
}

- (id)initWithTitleAndImage:(NSString *)albumOftitle albumImage:(NSImage*)albumImage
{
	if(self = [super init])
	{
		self.title = albumOftitle;
		self.coverImage = albumImage;
	}
	return self;
}

- (void)dealloc
{
	[title release];
	[albumName release];
	[coverImage release];
}

@end
