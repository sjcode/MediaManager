//
//  MMMusicListCell.h
//  MediaManager
//
//  Created by Arthur on 7/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

@interface MMMusicListCell : IKImageBrowserCell 
{
	BOOL bMovehover;
}

@property (nonatomic, assign)BOOL bMovehover;
@end
