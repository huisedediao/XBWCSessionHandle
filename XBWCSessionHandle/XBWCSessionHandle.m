//
//  XBWCSessionHandle.m
//  WatchTest
//
//  Created by xxb on 2017/2/14.
//  Copyright © 2017年 xxb. All rights reserved.
//

#import "XBWCSessionHandle.h"
#import <WatchConnectivity/WatchConnectivity.h>
#import <WatchKit/WatchKit.h>
#import "XBWCHeader.h"

@interface XBWCSessionHandle ()<WCSessionDelegate>
{
    WCSession *xbSession;
}

@end


@implementation XBWCSessionHandle


#pragma mark - 生命周期

+(instancetype)shareXBWCSessionHandle
{
    return [XBWCSessionHandle new];
}
-(instancetype)init
{
    if (self=[super init])
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [self addNotice];
        });
    }
    return self;
}
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static XBWCSessionHandle *handle=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handle=[super allocWithZone:zone];
    });
    return handle;
}

-(void)dealloc
{
    [self removeNotice];
}

#pragma mark - 成员方法

-(void)addNotice
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleReturnNotice:) name:k_notice_public_return object:nil];
}

-(void)removeNotice
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:k_notice_public_return object:nil];
}

-(void)handleReturnNotice:(NSNotification *)noti
{
    NSDictionary *dic = noti.object;
    NSString *action = dic[xb_str_action];
    
    if ([action isEqualToString:xb_str_setMode])
    {
        NSString *currentAction = dic[xb_str_msg][xb_str_currentAction];
        //直接发送修改按钮状态的消息
        [self sendMsg:@{xb_str_action:xb_str_setBtnState,xb_str_currentAction:currentAction} replyHandler:^(NSDictionary<NSString *,id> * _Nonnull resultDic) {
            
        } errorHandler:^(NSError * _Nonnull error) {
            
        }];
    }
}

-(void)sendMsg:(NSDictionary *)message replyHandler:(void (^)(NSDictionary<NSString *,id> * _Nonnull resultDic))replyHandler errorHandler:(void(^)(NSError * _Nonnull error))errorHandler
{
    [xbSession sendMessage:message replyHandler:replyHandler errorHandler:errorHandler];
}

-(void)setupWCSession
{
    if (WCSession.isSupported)
    {
        xbSession = WCSession.defaultSession;
        xbSession.delegate=self;
        [xbSession activateSession];
    }
    else
    {
        NSLog(@"wcsession不支持");
    }
}



#pragma mark - WCSession 代理

-(void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *,id> *)message replyHandler:(void (^)(NSDictionary<NSString *,id> * _Nonnull))replyHandler
{
    [[NSNotificationCenter defaultCenter] postNotificationName:k_notice_public_action object:message];
    replyHandler(@{});
}

-(void)sessionDidBecomeInactive:(WCSession *)session
{
    
}
-(void)sessionDidDeactivate:(WCSession *)session
{
    
}
-(void)session:(WCSession *)session activationDidCompleteWithState:(WCSessionActivationState)activationState error:(NSError *)error
{
    
}

@end
