//
//  cIRCAppDelegate.h
//  cIRC
//
//  Created by Clete R. Blackwell II on 8/3/10.
//

#import <Cocoa/Cocoa.h>
#include "outputInterpreter.h"

@interface cIRCAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
	NSInputStream *inputStream;
	NSOutputStream *outputStream;
	NSMutableData *dataBuffer;
	NSMutableData *_data;
	NSNumber *bytesRead;
	NSString *newString;
	
	outputInterpreter *oi;
	
	IBOutlet NSTextView *chatLog;
	IBOutlet NSTextField *sendString;
	
	bool debug;
}

- (void)openStreams;
- (void)closeStreams;
- (IBAction)writeOut:(id)sender;
- (void)readIn:(NSString *)s;

@property (assign) IBOutlet NSWindow *window;

@end
