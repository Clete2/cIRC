//
//  outputInterpreter.m
//  cIRC
//
//  Created by Clete R. Blackwell II on 8/11/10.
//

#import "outputInterpreter.h"


@implementation outputInterpreter

- (void) parseOutput:(NSString *)s
{
	separatedString = [[NSMutableArray alloc] init];
	[separatedString addObjectsFromArray:[s componentsSeparatedByString:@" "]];
	
	if([[separatedString objectAtIndex:0] isEqualToString:@"/"]){
		NSLog(@"Starts with /");
	}else{
		while([separatedString count] != 0 &&
			  ([[separatedString objectAtIndex:0] isEqualToString:@" "] ||
			   [[separatedString objectAtIndex:0] isEqualToString:@"	"])){
				  // Clearing out white space
				  [separatedString removeObjectAtIndex:0];
		}
	}
}

@end
