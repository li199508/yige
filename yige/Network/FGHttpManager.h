//
//  FGHttpManager.h
//  jingpai
//
//  Created by qiuxiaofeng on 2018/5/30.
//  Copyright © 2018年 JP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "FGResponseModel.h"
@class YLLShopCartItemModel;



@interface FGHttpManager : NSObject

+ (AFHTTPSessionManager *)manager;

+ (void)getWithPath:(NSString *)path
         parameters:(NSDictionary *)parameters
            success:(void (^)(id responseObject))success
            failure:(void (^)(NSString *error))failure;
+ (void)postWithPath:(NSString *)path
          parameters:(NSDictionary *)parameters
             success:(void (^)(id responseObject))success
             failure:(void (^)(NSString *error))failure;
+ (void)patchWithPath:(NSString *)path
          parameters:(NSDictionary *)parameters
             success:(void (^)(id responseObject))success
             failure:(void (^)(NSString *error))failure;
+ (void)deleteWithPath:(NSString *)path
          parameters:(NSDictionary *)parameters
             success:(void (^)(id responseObject))success
             failure:(void (^)(NSString *error))failure;



@end
