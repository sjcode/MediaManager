//
//  SongCategory.h
//  MediaManager
//
//  Created by Arthur on 5/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface SongCategory : NSObject 
{
	NSString *name;
	NSMutableArray *array;
}

- (id)initWithName:(NSString*)s;

@property (nonatomic,copy) NSString *name;
@property (nonatomic,retain) NSMutableArray *array;

@end
