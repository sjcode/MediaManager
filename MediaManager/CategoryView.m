//
//  CategoryView.m
//  MediaManager
//
//  Created by jian su on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CategoryView.h"

@implementation CategoryView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        backgroundImage = [NSImage imageNamed:@"icon_divide"];
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    //[backgroundImage drawInRect:[self bounds]
//                       fromRect:NSMakeRect(0.0f, 0.0f, backgroundImage.size.width, backgroundImage.size.height)
//                      operation:NSCompositeSourceAtop
//                       fraction:1.0f];
    
    [[NSColor whiteColor] set];  //设置颜色
	NSRectFill(dirtyRect);
}

@end
