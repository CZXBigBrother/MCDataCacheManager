//
//  MCDataCacheManager.h
//
// Copyright (c) 2016 czxghostyueqiu (http://blog.csdn.net/czxghostyueqiu)
//
//

#import "MCDataCacheManager.h"

#define MC_CONFIG_FILE @"MCConfig.plist"
#define MC_PARAM_NAME_KEY @"MCfileName"
#define MC_PARAM_EXTIME_KEY @"MCfileExTime"
#define MC_FILE_PATH [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory,  NSUserDomainMask,YES) lastObject] stringByAppendingPathComponent:@"MCDATA"]
@interface MCDataCacheManager()

@property(nonatomic, strong)NSMutableArray *fileList;

@property(nonatomic, assign)double defautTime;

@end

@implementation MCDataCacheManager


static MCDataCacheManager *_instance;

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}
+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}
- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}
- (id)init
{
    self = [super init];
    if (self) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [self createInitConfig];
        });
    }
    return self;
}
/*-------------------------------------写入-----------------------------------------------------------*/
/**
 *  设置默认过期时间
 */
- (void)MCsetDefautExpireTime:(double)time {
    self.defautTime = time;
}
/**
 *  写入数据(默认过期时间为0)
 */
- (void)MCwriteNoDefautExpireData:(id)dict withFile:(NSString *)name {
    [self MCwriteData:dict withFile:name withExpireTime:0];
}
- (void)MCwriteNoDefautExpireData:(id)dict withFile:(NSString *)name withAccount:(NSString *)account{
    [self MCwriteData:dict withFile:name withAccount:account withExpireTime:0];
}
/**
 *  写入数据(默认过期时间为设置时间:无设置或设置为0,则为5分钟)
 */
- (void)MCwriteDefautExpireData:(id)dict withFile:(NSString *)name {
    [self MCwriteData:dict withFile:name withExpireTime:self.defautTime == 0 ? 60 * 5 : self.defautTime];
}
- (void)MCwriteDefautExpireData:(id)dict withFile:(NSString *)name withAccount:(NSString *)account{
    [self MCwriteData:dict withFile:name withAccount:account withExpireTime:self.defautTime == 0 ? 60 * 5 : self.defautTime];
}
/**
 *  写入数据(自定义过期时间)
 */
- (void)MCwriteData:(id)dict withFile:(NSString *)name withExpireTime:(double)time {
    [self writeData:dict withFile:name];
    [self writeConfigExpireTime:time withName:name];
}
- (void)MCwriteData:(id)dict withFile:(NSString *)name withAccount:(NSString *)account withExpireTime:(double)time{
    [self writeData:dict withFile:name withAccount:account];
    [self writeConfigExpireTime:time withName:[account stringByAppendingPathComponent:name]];
}
/*-------------------------------------读取-----------------------------------------------------------*/
/**
 *  读取数据NSDictionary
 */
- (id)MCreadData:(NSString *)name {
    if ([self readFile:name]) {
        return [NSDictionary dictionaryWithContentsOfFile:[self readFile:name]];
    }else {
        return nil;
    }
}
- (id)MCreadData:(NSString *)name withAccount:(NSString *)account {
    if ([self readFile:[account stringByAppendingPathComponent:name]]) {
        return [NSDictionary dictionaryWithContentsOfFile:[self readFile:[account stringByAppendingPathComponent:name]]];
    }else {
        return nil;
    }
}
/**
 *  读取数据JSON
 */
- (id)MCreadJSONData:(NSString *)name {
    if ([self readFile:name]) {
        return [NSString stringWithContentsOfFile:[self readFile:name] encoding:NSUTF8StringEncoding error:nil];
    }else {
        return nil;
    }
}
- (id)MCreadJSONData:(NSString *)name withAccount:(NSString *)account{
    if ([self readFile:[account stringByAppendingPathComponent:name]]) {
        return [NSString stringWithContentsOfFile:[self readFile:[account stringByAppendingPathComponent:name]] encoding:NSUTF8StringEncoding error:nil];
    }else {
        return nil;
    }
}
/**
 *  检查时间是否过期
 */
- (BOOL)MCcheckExpireFile:(NSString *)name {
    __block BOOL isEx = YES;
    [self.fileList enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj[MC_PARAM_NAME_KEY] isEqualToString:name]) {
            isEx = [obj[MC_PARAM_EXTIME_KEY]doubleValue] > [self getLocationTime] ? NO : YES;
            *stop = YES;
        }
    }];
    return isEx;
}
- (BOOL)MCcheckExpireFile:(NSString *)name withAccount:(NSString *)account{
    __block BOOL isEx = YES;
    [self.fileList enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj[MC_PARAM_NAME_KEY] isEqualToString:[account stringByAppendingPathComponent:name]]) {
            isEx = [obj[MC_PARAM_EXTIME_KEY]doubleValue] > [self getLocationTime] ? NO : YES;
            *stop = YES;
        }
    }];
    return isEx;
}

/*-------------------------------------删除-----------------------------------------------------------*/
- (void)MCremoveData:(NSString *)name {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString * filepath = MC_FILE_PATH;
    filepath = [filepath stringByAppendingPathComponent:name];
    NSError *error;
    if ([fileManager removeItemAtPath:filepath error:&error] != YES)
        NSLog(@"Unable to delete file: %@", [error localizedDescription]);
    [self deleteConfigName:name];
}
- (void)MCremoveData:(NSString *)name withAccount:(NSString *)account{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString * filepath = MC_FILE_PATH;
    filepath = [[filepath stringByAppendingPathComponent:account]stringByAppendingPathComponent:name];
    NSError *error;
    if ([fileManager removeItemAtPath:filepath error:&error] != YES)
        NSLog(@"Unable to delete file: %@", [error localizedDescription]);
    [self deleteConfigName:[account stringByAppendingPathComponent:name]];
}
- (void)MCremoveAllData {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString * filepath = MC_FILE_PATH;
    NSError *error;
    if ([fileManager removeItemAtPath:filepath error:&error] != YES)
        NSLog(@"Unable to delete file: %@", [error localizedDescription]);
}
- (void)MCremoveAllAccount:(NSString *)account {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString * filepath = [MC_FILE_PATH stringByAppendingPathComponent:account];
    NSError *error;
    if ([fileManager removeItemAtPath:filepath error:&error] != YES)
        NSLog(@"Unable to delete file: %@", [error localizedDescription]);
    [self deleteConfigAccount:account];
}
#pragma mark -配置参数
- (NSMutableArray *)fileList {
    if (_fileList == nil) {
        _fileList = [NSMutableArray array];
    }
    return _fileList;
}
/**
 *  初始化配置文件
 */
- (void)createInitConfig {
    if (![self readFile:MC_CONFIG_FILE]) {
        [self writeData:@[] withFile:MC_CONFIG_FILE];
    }else {
        self.fileList = [self readConfig];
    }
}
/**
 *  读取配置参数
 */
- (id)readConfig{
    if ([self readFile:MC_CONFIG_FILE]) {
        return [NSMutableArray arrayWithContentsOfFile:[self readFile:MC_CONFIG_FILE]];
    }else {
        return nil;
    }
}
/**
 *  记录写入的时间戳
 */
- (void)writeConfigExpireTime:(double)time withName:(NSString *)name{
    
    NSDictionary * param = @{MC_PARAM_NAME_KEY : name
                            ,MC_PARAM_EXTIME_KEY : @(([self getLocationTime] + time))};
    
    __block BOOL isEx = NO;
    [self.fileList enumerateObjectsUsingBlock:^(NSDictionary * data, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([data[MC_PARAM_NAME_KEY] isEqualToString:param[MC_PARAM_NAME_KEY]]) {
            [self.fileList replaceObjectAtIndex:idx withObject:[param copy]];
            isEx = YES;
            *stop = YES;
        }
    }];
    if (isEx == NO) {
        [self.fileList addObject:param];
    }
    [self writeData:self.fileList withFile:MC_CONFIG_FILE];
}
/**
 *  删除记录
 */
- (void)deleteConfigName:(NSString *)name{
    __block BOOL isEx = NO;
    [self.fileList enumerateObjectsUsingBlock:^(NSDictionary * data, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([data[MC_PARAM_NAME_KEY] isEqualToString:name]) {
            [self.fileList removeObject:data];
            isEx = YES;
            *stop = YES;
        }
    }];
    [self writeData:self.fileList withFile:MC_CONFIG_FILE];
}
- (void)deleteConfigAccount:(NSString *)account{
    __block BOOL isEx = NO;
    NSMutableArray * removeArray = [NSMutableArray array];
    [self.fileList enumerateObjectsUsingBlock:^(NSDictionary * data, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString * name = [[data[MC_PARAM_NAME_KEY] componentsSeparatedByString:@"/"]firstObject];
        if ([name isEqualToString:account]) {
//            [self.fileList removeObject:data];
            isEx = YES;
            [removeArray addObject:data];
//            *stop = YES;
        }
    }];
    [self.fileList removeObjectsInArray:removeArray];
    [self writeData:self.fileList withFile:MC_CONFIG_FILE];
}
#pragma mark -原生方法
/**
 *  单独账户独立文件写入
 */
- (void)writeData:(id)param withFile:(NSString *)name withAccount:(NSString *)Account {
    NSString * docPath = [MC_FILE_PATH stringByAppendingPathComponent:Account];
    NSFileManager * mgr=[NSFileManager defaultManager];
    BOOL dir=NO;
    BOOL exists =[mgr fileExistsAtPath:docPath isDirectory:&dir];
    NSString *filepath = [docPath stringByAppendingPathComponent:name];
    if (exists) {
        [param writeToFile:filepath atomically:YES];
    }else {
        NSError * error;
        [mgr createDirectoryAtPath:docPath withIntermediateDirectories:YES attributes:nil error:&error];
        if (error==nil) {
            [param writeToFile:filepath atomically:YES];
        }else {
            NSLog(@"添加失败 %@",error);
        }
    }
}
/**
 *  写入文件初始方法
 */
- (void)writeData:(id)param withFile:(NSString *)name {
    NSString * docPath = MC_FILE_PATH;
    NSFileManager * mgr=[NSFileManager defaultManager];
    BOOL dir=NO;
    BOOL exists =[mgr fileExistsAtPath:docPath isDirectory:&dir];
    NSString *filepath = [docPath stringByAppendingPathComponent:name];
    if (exists) {
        [param writeToFile:filepath atomically:YES];
    }else {
        NSError * error;
        [mgr createDirectoryAtPath:docPath withIntermediateDirectories:YES attributes:nil error:&error];
        if (error==nil) {
            [param writeToFile:filepath atomically:YES];
        }else {
            NSLog(@"添加失败 %@",error);
        }
    }
}
/**
 *  获取文件初始方法
 */
- (NSString *)readFile:(NSString *)name {
    NSString * filepath = MC_FILE_PATH;
    filepath = [filepath stringByAppendingPathComponent:name];
    NSFileManager * mgr=[NSFileManager defaultManager];
    BOOL dir=NO;
    BOOL exists =[mgr fileExistsAtPath:filepath isDirectory:&dir];
    if (exists) {
        return filepath;
    }else {
        NSLog(@"没有找到数据");
        return nil;
    }
}
- (NSTimeInterval)getLocationTime {
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval aDate=[date timeIntervalSince1970];
    return aDate;
}
/**
 *  获取缓存路径
 */
- (NSString *)MCGetPath {
    return MC_FILE_PATH;
}
+ (NSString *)MCGetPath {
    return MC_FILE_PATH;
}
@end
