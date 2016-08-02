//
//  MCDataCacheManager.h
//
// Copyright (c) 2016 czxghostyueqiu (http://blog.csdn.net/czxghostyueqiu)
//
//

#import <Foundation/Foundation.h>

@interface MCDataCacheManager : NSObject

+ (instancetype)shareInstance;
/*-------------------------------------写入-------------------------------------*/
/**
 *  设置默认过期时间
 */
- (void)MCsetDefautExpireTime:(double)time;
/**
 *  写入数据(默认过期时间为0)
 */
- (void)MCwriteNoDefautExpireData:(id)dict withFile:(NSString *)name;
/**
 *  写入数据(默认过期时间为0,则为5分钟)
 */
- (void)MCwriteNoDefautExpireData:(id)dict withFile:(NSString *)name withAccount:(NSString *)account;
/**
 *  写入数据(默认过期时间为设置时间:无设置或设置为0,则为5分钟)
 */
- (void)MCwriteDefautExpireData:(id)dict withFile:(NSString *)name;
/**
 *  写入数据(默认过期时间为设置时间:无设置或设置为0,则为5分钟,独立文件夹)
 */
- (void)MCwriteDefautExpireData:(id)dict withFile:(NSString *)name withAccount:(NSString *)account;
/**
 *  写入数据(自定义过期时间)
 */
- (void)MCwriteData:(id)dict withFile:(NSString *)name withExpireTime:(double)time;
/**
 *  写入数据(自定义过期时间,独立文件夹)
 */
- (void)MCwriteData:(id)dict withFile:(NSString *)name withAccount:(NSString *)account withExpireTime:(double)time;
/*-------------------------------------读取-------------------------------------*/
/**
 *  读取数据NSDictionary
 */
- (id)MCreadData:(NSString *)name;
/**
 *  读取数据NSDictionary,独立文件夹
 */
- (id)MCreadData:(NSString *)name withAccount:(NSString *)account;
/**
 *  读取数据JSON
 */
- (id)MCreadJSONData:(NSString *)name;
/**
 *  读取数据JSON,独立文件夹
 */
- (id)MCreadJSONData:(NSString *)name withAccount:(NSString *)account;
/**
 *  检查时间是否过期
 */
- (BOOL)MCcheckExpireFile:(NSString *)name;
/**
 *  检查时间是否过期,独立文件夹
 */
- (BOOL)MCcheckExpireFile:(NSString *)name withAccount:(NSString *)account;
/*-------------------------------------删除-------------------------------------*/
/**
 *  删除单条缓存数据
 */
- (void)MCremoveData:(NSString *)name;
/**
 *  删除单条缓存数据,独立文件夹
 */
- (void)MCremoveData:(NSString *)name withAccount:(NSString *)account;
/**
 *  删除全部缓存数据
 */
- (void)MCremoveAllData;
/**
 *  删除单个文件夹
 */
- (void)MCremoveAllAccount:(NSString *)account;
/*-------------------------------------其他-------------------------------------*/
/**
 *  获取缓存路径
 */
- (NSString *)MCGetPath;
+ (NSString *)MCGetPath;
@end
