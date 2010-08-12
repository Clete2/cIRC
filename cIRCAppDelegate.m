//
//  cIRCAppDelegate.m
//  cIRC
//
//  Created by Clete R. Blackwell II on 8/3/10.
//

#import "cIRCAppDelegate.h"

@implementation cIRCAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	debug = TRUE;
	[NSStream getStreamsToHost:[NSHost hostWithName:@"130.239.18.172"] port:6667 
				   inputStream:&inputStream 
				  outputStream:&outputStream];
	[self openStreams];
}

- (void)openStreams {
	[inputStream setDelegate:self];
	[outputStream setDelegate:self];
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream open];
    [outputStream open];
}

- (void)closeStreams {
    [inputStream close];
    [outputStream close];
    [inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream setDelegate:nil];
    [outputStream setDelegate:nil];
	inputStream = nil;
	outputStream = nil;
}

- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)event {
	switch(event) {
		case NSStreamEventHasSpaceAvailable: {
			if(stream == outputStream) {
				debug ? NSLog(@"outputStream is ready.") : nil; 
			}
			break;
		}
		case NSStreamEventHasBytesAvailable: {
			if(stream == inputStream) {
				debug ? NSLog(@"inputStream is ready.") : nil; 
				
				uint8_t buf[1024];
				unsigned int len = 0;
				
				len = [inputStream read:buf maxLength:1024];
				
				if(len > 0) {
					NSMutableData *data=[[NSMutableData alloc] initWithLength:0];
					
					[data appendBytes: (const void *)buf length:len];
					
					NSString *s = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
					
					[self readIn:s];
					
					[data release];
				}
			} 
			break;
		}
		default: {
			debug ? NSLog(@"Stream is sending an Event: %i", event) : nil;
			break;
		}
	}
}

- (void)readIn:(NSString *)s {
	debug ? NSLog(@"Reading in the following:") : nil;
	debug ? NSLog(@"%@", s) : nil;

	newString = [NSString stringWithFormat:@"%@%@", [[chatLog  textStorage] string], s];
	
	[chatLog insertText:newString];
}

- (IBAction)writeOut:(id)sender {
	uint8_t *buf = (uint8_t *)[[NSString stringWithFormat:@"%@\r\n", [sendString stringValue]] UTF8String];
	
	[outputStream write:buf maxLength:strlen((char *)buf)];
	
	debug ? NSLog(@"Writing out the following:") : nil;
	debug ? NSLog(@"%@", [sendString stringValue]) : nil;

	oi = [[outputInterpreter alloc] init];
	[oi parseOutput:[sendString stringValue]];
	
	[sendString setStringValue:@""];
}

@end
