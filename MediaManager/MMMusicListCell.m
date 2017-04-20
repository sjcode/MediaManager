//
//  MMMusicListCell.m
//  MediaManager
//
//  Created by Arthur on 7/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MMMusicListCell.h"
#import "Utilities.h"

static CGImageRef shadowImage()
{
	static CGImageRef image = NULL;
	if(image == NULL)
		image = createshadowImage();
	
	return image;
}

static CGImageRef defaultMusicImage()
{
	static CGImageRef image = NULL;
	if(image == NULL)
		image = createImageWithName(@"icon_music_thumbnail.png");
	return image;
}

@implementation MMMusicListCell

- (NSRect) myBackgroundFrame
{
	NSRect imgFrame = [self imageFrame];
	NSRect frame = [self frame];
	
	imgFrame.size.height += 18;
	imgFrame.origin.y -= 10;
	imgFrame.size.width = frame.size.width;
	imgFrame.origin.x = frame.origin.x;
	
	return imgFrame;
}

- (CALayer *) layerForType:(NSString*) type
{
	CGColorRef color;
	
	//retrieve some usefull rects
	NSRect frame = [self frame];
	NSRect imageFrame = [self imageFrame];
	NSRect relativeImageFrame = NSMakeRect(imageFrame.origin.x - frame.origin.x, imageFrame.origin.y - frame.origin.y, imageFrame.size.width, imageFrame.size.height);
	
	/* place holder layer */
	if(type == IKImageBrowserCellPlaceHolderLayer){
		//create a place holder layer
		CALayer *layer = [CALayer layer];
		layer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
		

		CALayer *defaultMusicLayer = [CALayer layer];
		[defaultMusicLayer setContents:(id)defaultMusicImage()];
		defaultMusicLayer.frame = *(CGRect*) &relativeImageFrame;
		[layer addSublayer:defaultMusicLayer];
		
		return layer;
	}
	
	/* foreground layer */
	if(type == IKImageBrowserCellForegroundLayer){
		//no foreground layer on place holders
		if([self cellState] != IKImageStateReady)
			return nil;
		if(bMovehover)
		{
			//create a foreground layer that will contain several childs layer
			CALayer *layer = [CALayer layer];
			layer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
			
			NSRect imageContainerFrame = [self imageContainerFrame];
			NSRect relativeImageContainerFrame = NSMakeRect(imageContainerFrame.origin.x - frame.origin.x, imageContainerFrame.origin.y - frame.origin.y, imageContainerFrame.size.width, imageContainerFrame.size.height);
			
			//add a glossy overlay
			CALayer *glossyLayer = [CALayer layer];
			glossyLayer.frame = *(CGRect*) &relativeImageContainerFrame;
			[glossyLayer setContents:(id)shadowImage()];
			[layer addSublayer:glossyLayer];
			
			return layer;
		}
		
		return nil;
		
	}
	
	/* selection layer */
	if(type == IKImageBrowserCellSelectionLayer){
		
		//create a selection layer
		CALayer *selectionLayer = [CALayer layer];
		NSRect selectionFrame = [self imageFrame];
		selectionFrame = NSInsetRect(selectionFrame, -15, -15);
		selectionLayer.frame = *(CGRect*) &selectionFrame;
		
		
		CGFloat fillComponents[4] = {0.5059, 0.7451, 0.1961, 1};
		CGFloat strokeComponents[4] = {0.5059, 0.7451, 0.1961, 1};
		
		//set a background color
		CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
		color = CGColorCreate(colorSpace, fillComponents);
		//[selectionLayer setBackgroundColor:color];
		CFRelease(color);
		
		//set a border color
		color = CGColorCreate(colorSpace, strokeComponents);
		[selectionLayer setBorderColor:color];
		CFRelease(color);
		
		[selectionLayer setBorderWidth:2.0];
		[selectionLayer setCornerRadius:5];
		
		return selectionLayer;
	}
	
	/* background layer */
	if(type == IKImageBrowserCellBackgroundLayer){
		//no background layer on place holders
		if([self cellState] != IKImageStateReady)
			return nil;
		
		CALayer *layer = [CALayer layer];
		layer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height-20);
		
		NSRect backgroundRect = NSMakeRect(0, 0, frame.size.width, frame.size.height);		
		
		CALayer *photoBackgroundLayer = [CALayer layer];
		photoBackgroundLayer.frame = *(CGRect*) &backgroundRect;
		
		CGFloat fillComponents[4] = {0.95, 0.95, 0.95, 1.0};
		CGFloat strokeComponents[4] = {0.2, 0.2, 0.2, 0.5};
		
		CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
		
		color = CGColorCreate(colorSpace, fillComponents);
		//[photoBackgroundLayer setBackgroundColor:color];
		CFRelease(color);
		
		color = CGColorCreate(colorSpace, strokeComponents);
		//[photoBackgroundLayer setBorderColor:color];
		CFRelease(color);
		
		//[photoBackgroundLayer setBorderWidth:1.0];
		//[photoBackgroundLayer setShadowOpacity:0.5];
		//[photoBackgroundLayer setCornerRadius:3];
		
		CFRelease(colorSpace);
		
		//[layer addSublayer:photoBackgroundLayer];
		
		return layer;
	}
	
	return nil;
}

- (NSRect) imageFrame
{
	//get default imageFrame and aspect ratio
	NSRect imageFrame = [super imageFrame];
	//return imageFrame;
	if(imageFrame.size.height == 0 || imageFrame.size.width == 0) return NSZeroRect;
	
	float aspectRatio =  imageFrame.size.width / imageFrame.size.height;
	
	// compute the rectangle included in container with a margin of at least 10 pixel at the bottom, 5 pixel at the top and keep a correct  aspect ratio
	NSRect container = [self imageContainerFrame];
	//container = NSInsetRect(container, 8, 8);
	
	if(container.size.height <= 0) return NSZeroRect;
	
	float containerAspectRatio = container.size.width / container.size.height;
	
	if(containerAspectRatio > aspectRatio){
		imageFrame.size.height = container.size.height;
		imageFrame.origin.y = container.origin.y;
		imageFrame.size.width = imageFrame.size.height * aspectRatio;
		imageFrame.origin.x = container.origin.x + (container.size.width - imageFrame.size.width)*0.5;
	}
	else{
		imageFrame.size.width = container.size.width;
		imageFrame.origin.x = container.origin.x;		
		imageFrame.size.height = imageFrame.size.width / aspectRatio;
		imageFrame.origin.y = container.origin.y + container.size.height - imageFrame.size.height;
	}
	
	//round it
	imageFrame.origin.x = floorf(imageFrame.origin.x);
	imageFrame.origin.y = floorf(imageFrame.origin.y);
	imageFrame.size.width = ceilf(imageFrame.size.width);
	imageFrame.size.height = ceilf(imageFrame.size.height);
	
	return imageFrame;
}


//---------------------------------------------------------------------------------
// imageContainerFrame
//
// override the default image container frame
//---------------------------------------------------------------------------------
- (NSRect) imageContainerFrame
{
	NSRect container = [super imageContainerFrame];
	
	//make the image container 15 pixels up
	container.origin.y += 15;
	container.size.height -= 15;
	
	return container;
}

//---------------------------------------------------------------------------------
// titleFrame
//
// override the default frame for the title
//---------------------------------------------------------------------------------
- (NSRect) titleFrame
{
	//get the default frame for the title
	NSRect titleFrame = [super titleFrame];
	
	//move the title inside the 'photo' background image
	NSRect container = [self frame];
	titleFrame.origin.y = container.origin.y + 3;
	
	//make sure the title has a 7px margin with the left/right borders
	float margin = titleFrame.origin.x - (container.origin.x + 7);
	if(margin < 0)
		titleFrame = NSInsetRect(titleFrame, -margin, 0);
	
	return titleFrame;
}

- (NSRect)subtitleFrame
{
	NSRect subtitleFrame = [super subtitleFrame];
	NSRect container = [self frame];
	subtitleFrame.origin.y = container.origin.y + 13;
	
	//make sure the title has a 7px margin with the left/right borders
	float margin = subtitleFrame.origin.x - (subtitleFrame.origin.x + 7);
	if(margin < 0)
		subtitleFrame = NSInsetRect(subtitleFrame, -margin, 0);
	
	return subtitleFrame;
}

- (NSRect) frame
{
	return [super frame];
	//	if(!bMovehover)
	//		return [super frame];
	//	else
	//	{
	//		NSRect frame = [super frame];
	//		frame.origin.y -= 50;
	//		frame.size.height += 50;
	//		return frame;
	//	}
}

//---------------------------------------------------------------------------------
// selectionFrame
//
// make the selection frame a little bit larger than the default one
//---------------------------------------------------------------------------------
//- (NSRect) selectionFrame
//{
//	NSRect selectionFrame = [super selectionFrame];
//	selectionFrame = NSInsetRect(selectionFrame, 2, 2);
//	return selectionFrame;//NSInsetRect([self myBackgroundFrame], -2, -2);
//}
@synthesize bMovehover;
@end
