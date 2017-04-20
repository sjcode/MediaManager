//
//  MMSharedOperationQueue.h
//  MediaManager
//
//  Created by Arthur on 6/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface MMSharedOperationQueue : NSObject {
	NSOperationQueue *_operationQueue;
}
@property (nonatomic,retain)NSOperationQueue *_operationQueue;

+ (MMSharedOperationQueue*)shareOperationQueue;
- (NSOperationQueue*)instance;
@end
