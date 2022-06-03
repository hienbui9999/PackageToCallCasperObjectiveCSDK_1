#ifndef StateRootHashHandler_h
#define StateRootHashHandler_h
#import <Foundation/Foundation.h>
@interface StateRootHashHandler:NSObject
@property NSString * stateRootHash;
-(void) getStateRootHashWithCallID:(NSString*) callID;
@end
#endif
