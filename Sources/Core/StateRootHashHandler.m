#import "SamplePackageToCallCasperSDKObjectiveC/StateRootHashHandler.h"
@import CasperSDKObjectiveC_CommonClasses;
@import CasperSDKObjectiveC_GetStateRootHash;
@implementation StateRootHashHandler
int counterStateRootHash = 0;
int maxCounter = 50;
-(void)onTick:(NSTimer *)timer {
    GetStateRootHashRPC * item = [[timer userInfo] objectForKey:@"param1"];
    NSString * callID = [[timer userInfo] objectForKey:@"param2"];
    if([item.valueDict[callID] isEqualToString:RPC_VALUE_NOT_SET]) {
    } else if([item.valueDict[callID] isEqualToString:RPC_VALUE_ERROR_OBJECT]) {
        NSLog(@"Get state root hash error");
        [timer invalidate];
        timer = nil;
    }else {
        NSLog(@"Find state root hash:%@",item.valueDict[callID]);
        self.stateRootHash = item.valueDict[callID];
        [timer invalidate];
        timer = nil;
    }
    counterStateRootHash ++;
    if(counterStateRootHash == maxCounter) {
        [timer invalidate];
        timer = nil;
    }
}
-(void) getStateRootHashWithCallID:(NSString*) callID {
    BlockIdentifier * bi = [[BlockIdentifier alloc] init];
    bi.blockType = USE_NONE;
    GetStateRootHashRPC * item = [[GetStateRootHashRPC alloc] init];
    [item initializeWithRPCURL:URL_TEST_NET];
    NSString * jsonString = [bi toJsonStringWithMethodName:CASPER_RPC_METHOD_GET_STATE_ROOT_HASH];
    [item getStateRootHashWithJsonParam:jsonString];
    //NSString * callID = @"getStateRootHash1";
    [item getStateRootHashWithJsonParam2:jsonString andCallID:callID];
    NSTimer * t = [NSTimer scheduledTimerWithTimeInterval: 1.0
                          target: self
                          selector:@selector(onTick:)
                                                 userInfo: @{@"param1":item,@"param2":callID} repeats:YES];
}

@end
