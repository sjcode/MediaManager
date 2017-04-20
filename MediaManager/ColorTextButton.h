//
//  ColorTextButton.h
//  MediaManager
//
//  Created by Arthur on 5/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSButton (ColorButton)
- (void)setHoverColor:(NSColor *)textColor;
- (void)setNormalColor:(NSColor *)textColor;
- (void)setPushColor:(NSColor *)textColor;
- (void)setDisableColor:(NSColor *)textColor;
- (void)setHeightLight:(BOOL)b;
@end

@interface CustomButton : NSButton
@end

@interface ColorButtonCell : NSButtonCell
{
    BOOL bClick;
}
@property (nonatomic,retain) NSColor *normal;
@property (nonatomic,retain) NSColor *hover;
@property (nonatomic,retain) NSColor *push;
@property (nonatomic,retain) NSColor *disable;
@end

