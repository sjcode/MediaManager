//
//  MMAlertBoxController.h
//  MediaManager
//
//  Created by Arthur on 8/8/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface MMAlertBoxController : NSWindowController 
{
	IBOutlet NSTextField *alertTitle;
	IBOutlet NSTextField *alertMessage;
	IBOutlet NSButton *okButton;
	NSString *title;
	NSString *message;
}

+ (void)alertBox:(NSString*)title message:(NSString*)msg;
- (IBAction)okAction:(id)sender;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *message;
@end
