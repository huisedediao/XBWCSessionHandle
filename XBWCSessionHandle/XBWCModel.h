//
//  XBWCModel.h
//  WatchTest
//
//  Created by xxb on 2017/2/15.
//  Copyright © 2017年 xxb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBWCModel : NSObject
@property (nonatomic,copy) NSString * _Nonnull action;
@property (nonatomic,copy) void (^ _Nonnull replyHandler)(NSDictionary<NSString *,id> * _Nonnull resultDic);
//@property (nonatomic,copy) void(^ _Nonnull errorHandler)(NSError * _Nonnull error);
@end
