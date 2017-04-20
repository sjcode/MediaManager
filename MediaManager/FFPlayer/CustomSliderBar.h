//
//  CustomSliderBar.h
//  FFMediaPlayer
//
//  Created by Arthur on 5/17/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol CustomSliderBarDelegate
- (void)customSliderMouseDown:(id)sender;
@end


@interface CustomSliderBar : NSSlider 
{
	id<CustomSliderBarDelegate> delegate;
}
@property (nonatomic,retain) id delegate;
@end
