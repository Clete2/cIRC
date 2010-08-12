//
//  outputInterpreter.h
//  cIRC
//
//  Created by Clete R. Blackwell II on 8/11/10.
//

#import <Cocoa/Cocoa.h>


@interface outputInterpreter : NSObject {
	NSMutableArray *separatedString;
}

- (void)parseOutput:(NSString *)s;

@end
