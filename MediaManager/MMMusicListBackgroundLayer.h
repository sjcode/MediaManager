//
//  MMMusicListBackgroundLayer.h
//  MediaManager
//
//  Created by Arthur on 7/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

@interface MMMusicListBackgroundLayer : CALayer 
{
	IKImageBrowserView *owner;
}
@property (assign) IKImageBrowserView *owner;

@end
