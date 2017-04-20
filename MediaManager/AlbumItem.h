//
//  AlbumItem.h
//  MediaManager
//
//  Created by Arthur on 5/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AlbumItem : NSObject 
{
	NSInteger index;
	NSString *title;
	NSString *albumName;
	NSImage *coverImage;
	
	id context;
}
- (id)initWithTitle:(NSString*)albumOftitle;
- (id)initWithTitleAndImage:(NSString *)albumOftitle albumImage:(NSImage*)albumImage;

@property (nonatomic,assign)NSInteger index;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *albumName;
@property (nonatomic,retain)NSImage *coverImage;
@property (nonatomic,retain)id context;
@end
