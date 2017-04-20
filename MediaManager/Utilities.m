#import "Utilities.h"

CGImageRef createImageWithName(NSString * imageName)
{
	CGImageRef returnValue = NULL;
	
	NSString *path = [[NSBundle mainBundle] pathForResource:[imageName stringByDeletingPathExtension] ofType:[imageName pathExtension]];
	if(path){
		CGImageSourceRef imageSource = CGImageSourceCreateWithURL((CFURLRef)[NSURL fileURLWithPath:path], NULL);
		
		if(imageSource){
			returnValue = CGImageSourceCreateImageAtIndex(imageSource, 0, NULL);
		}
	}
	
	return returnValue;
}

CGImageRef createshadowImage()
{
	CGImageRef returnValue = NULL;
	NSImage *playImage = [NSImage imageNamed:@"musicoverplay"];
	
	NSImage *image = [[NSImage alloc]initWithSize:NSMakeSize(130, 130)];
	[image lockFocus];
	[[NSColor colorWithDeviceRed:0.1490 green:0.1490 blue:0.1490 alpha:0.5]set];
	NSRectFill(NSMakeRect(0, 0, 130, 130));
	[playImage drawAtPoint:NSMakePoint(0, 0) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1];
	[image unlockFocus];
	
	NSData * imageData = [image TIFFRepresentation];
    if(imageData)
    {
        CGImageSourceRef imageSource = 
		CGImageSourceCreateWithData(
									(CFDataRef)imageData,  NULL);
		
        returnValue = CGImageSourceCreateImageAtIndex(
													  imageSource, 0, NULL);
    }
	[image release];
	return returnValue;
}