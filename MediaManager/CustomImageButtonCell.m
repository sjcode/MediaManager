//
//  CustomImageButtonCell.m
//  MediaManager
//
//  Created by jian su on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomImageButtonCell.h"


@implementation NSButton (CustomButton)

- (NSColor *)textColor
{
    NSAttributedString *attrTitle = [self attributedTitle];
    NSUInteger len = [attrTitle length];
    NSRange range = NSMakeRange(0, MIN(len, 1)); // take color from first char
    NSDictionary *attrs = [attrTitle fontAttributesInRange:range];
    NSColor *textColor = [NSColor controlTextColor];
    if (attrs) {
        textColor = [attrs objectForKey:NSForegroundColorAttributeName];
    }
    return textColor;
}

- (void)setTextColor:(NSColor *)textColor
{
    NSMutableAttributedString *attrTitle = [[NSMutableAttributedString alloc] 
                                            initWithAttributedString:[self attributedTitle]];
    NSUInteger len = [attrTitle length];
    NSRange range = NSMakeRange(0, len);
    [attrTitle addAttribute:NSForegroundColorAttributeName 
                      value:textColor 
                      range:range];
    [attrTitle fixAttributesInRange:range];
    [self setAttributedTitle:attrTitle];
    [attrTitle release];
}

- (void)setHoverImage:(NSImage *)image
{
    [[self cell] setHoverImage:image];
}

- (void)setNormalImage:(NSImage *)image
{
    [[self cell] setNormalImage:image];
}

- (void)setDownImage:(NSImage *)image
{
    [[self cell] setDownImage:image];
}

- (void)setDisableImage:(NSImage *)image
{
    [[self cell] setDisableImage:image];
}

@end

@implementation CustomImageButton

- (void)mouseDown:(NSEvent *)theEvent
{
    [[self cell] mouseDown:theEvent];
    [super mouseDown:theEvent];
    [[self cell] mouseUp:theEvent]; 
}

@end


@interface NSButtonCell()
- (void)_updateMouseTracking;
@end

@implementation CustomImageButtonCell

- (void)awakeFromNib
{
    [self setBordered:NO];
    [self setButtonType:NSMomentaryChangeButton];
    [self setTitle:[self title]];
}


- (void)mouseDown:(NSEvent *)theEvent
{
	if (downImage != nil && [downImage isValid]) {
		_oldImage = [[(NSButton *)[self controlView] image] retain];
		[(NSButton *)[self controlView] setImage:downImage];
	}
}

- (void)mouseUp:(NSEvent *)theEvent
{
	if (hoverImage != nil && [hoverImage isValid]) {
		_oldImage = [[(NSButton *)[self controlView] image] retain];
		[(NSButton *)[self controlView] setImage:hoverImage];
	}
}

- (void)mouseEntered:(NSEvent *)event {
	if (hoverImage != nil && [hoverImage isValid]) {
		_oldImage = [[(NSButton *)[self controlView] image] retain];
		[(NSButton *)[self controlView] setImage:hoverImage];
	}
}

- (void)mouseExited:(NSEvent *)event {
	if (normalImage != nil && [normalImage isValid]) 
	{
		[(NSButton *)[self controlView] setImage:normalImage];
	}
}

- (void)_updateMouseTracking {
	[super _updateMouseTracking];
	if ([self controlView] != nil && [[self controlView] respondsToSelector:@selector(_setMouseTrackingForCell:)]) {
		[[self controlView] performSelector:@selector(_setMouseTrackingForCell:) withObject:self];
	}
}

- (void)setNormalImage:(NSImage *)image
{
    [image retain];
    [normalImage release];
    normalImage = image;
    [self setImage:normalImage];
    [[self controlView] setNeedsDisplay:YES];
}

- (void)setHoverImage:(NSImage *)newImage {
	[newImage retain];
	[hoverImage release];
	hoverImage = newImage;
    [self setImage:hoverImage];
	[[self controlView] setNeedsDisplay:YES];
}

- (void)setDownImage:(NSImage *)image
{
    [image retain];
    [downImage release];
    downImage = image;
    [self setAlternateImage:downImage];
    [[self controlView] setNeedsDisplay:YES];
}

- (void)setDisableImage:(NSImage *)image
{
    [image retain];
    [disableImage release];
    disableImage = image;
    [self setImage:disableImage];
    [[self controlView] setNeedsDisplay:YES];
}


- (void)dealloc {
	[_oldImage release];
    [normalImage release];
	[hoverImage release];
    [downImage release];
    [disableImage release];
	[super dealloc];
}


@end
