//
//  CustomImageButtonCell.h
//  MediaManager
//
//  Created by jian su on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface NSButton (CustomButton)
- (NSColor *)textColor;
- (void)setTextColor:(NSColor *)textColor;
- (void)setHoverImage:(NSImage *)image;
- (void)setNormalImage:(NSImage *)image;
- (void)setDownImage:(NSImage *)image;
- (void)setDisableImage:(NSImage *)image;
@end


@interface CustomImageButton : NSButton
@end

@interface CustomImageButtonCell : NSButtonCell
{
    NSImage *_oldImage;
    NSImage *normalImage;
    NSImage *hoverImage;
    NSImage *downImage;
	NSImage *disableImage;
    
}

- (void)setHoverImage:(NSImage*)image;
- (void)setNormalImage:(NSImage*)image;
- (void)setDownImage:(NSImage*)image;
- (void)setDisableImage:(NSImage*)image;

@end
