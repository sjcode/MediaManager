//
//  MMAlertBox.h
//  MediaManager
//
//  Created by Arthur on 8/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#define ALERTBOXWIDTH 400
#define ALERTBOXHEIGHT 250

NSColor * backgroundColor(NSRect frame);

@interface MMAlertBox : NSWindow 
{

}

+ (void)alertBox:(NSString*)title message:(NSString*)msg;
- (IBAction)okButtonAction:(id)sender;


@end
