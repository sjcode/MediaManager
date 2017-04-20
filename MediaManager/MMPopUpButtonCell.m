//
//  MMPopUpButtonCell.m
//  MediaManager
//
//  Created by Arthur on 6/1/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MMPopUpButtonCell.h"


@implementation MMPopUpButtonCell



-(id)init {
	
	self = [super init];
	
	if(self) {
		
	}
	
	return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
	
	self = [super initWithCoder: aDecoder];
	
	if(self) {
		
	}
	
	return self;
}

-(void)encodeWithCoder: (NSCoder *)coder {
	
	[super encodeWithCoder: coder];
}

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
	
	NSMutableAttributedString *aTitle = [[NSMutableAttributedString alloc] initWithAttributedString: [self attributedTitle]];
	[aTitle addAttribute: NSForegroundColorAttributeName
				   value:[NSColor whiteColor]
				   range: NSMakeRange(0, [aTitle length])];
	[super drawTitle: aTitle withFrame: cellFrame inView: controlView];
	

}

- (void)drawArrowsInRect:(NSRect) frame {
	
	
}

#pragma mark -
#pragma mark Helper Methods

-(void)dealloc {
	
	[super dealloc];
}

#pragma mark -


@end
