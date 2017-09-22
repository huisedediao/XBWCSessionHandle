//
//  XBWCSessionHandle.h
//  WatchTest
//
//  Created by xxb on 2017/2/14.
//  Copyright © 2017年 xxb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBWCSessionHandle : NSObject
+(_Nonnull instancetype)shareXBWCSessionHandle;
-(void)setupWCSession;
-(void)sendMsg:(NSDictionary * _Nonnull)message replyHandler:(void (^ _Nonnull)(NSDictionary<NSString *,id> * _Nonnull resultDic))replyHandler errorHandler:(void(^ _Nonnull)(NSError * _Nonnull error))errorHandler;
@end
