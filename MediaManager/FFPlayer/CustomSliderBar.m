//
//  CustomSliderBar.m
//  FFMediaPlayer
//
//  Created by Arthur on 5/17/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomSliderBar.h"


@implementation CustomSliderBar
@synthesize delegate;
- (void) mouseDown: (NSEvent *)theEvent
{
	if(delegate && [self.delegate respondsToSelector:@selector(customSliderMouseDown:)])
	{
		[delegate customSliderMouseDown:theEvent];
	}
	[super mouseDown:theEvent];
}

@end
