# MCDataCacheManager
MCDataCacheManager:A Simple Data Cache Framework


 *  设置默认过期时间
 */
- (void)MCsetDefautExpireTime:(double)time;
/**
 *  写入数据(默认过期时间为0)
 */
- (void)MCwriteNoDefautExpireData:(id)dict withFile:(NSString *)name;
/**
 *  写入数据(默认过期时间为设置时间:无设置或设置为0,则为5分钟)
 */
- (void)MCwriteDefautExpireData:(id)dict withFile:(NSString *)name;
/**
 *  写入数据(自定义过期时间)
 */
- (void)MCwriteData:(id)dict withFile:(NSString *)name withExpireTime:(double)time;
/**
 *  读取数据
 */
- (id)MCreadData:(NSString *)name;
/**
 *  检查时间是否过期
 */
- (BOOL)MCcheckExpireFile:(NSString *)name;
/**
 *  删除单条缓存数据
 */
- (void)MCremoveData:(NSString *)name;
/**
 *  删除全部缓存数据
 */
- (void)MCremoveAllData;
