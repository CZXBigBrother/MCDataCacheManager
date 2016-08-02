//
//  ViewController.m
//  MCCacheManager
//
// Copyright (c) 2016 czxghostyueqiu (http://blog.csdn.net/czxghostyueqiu)
//
//

#import "ViewController.h"
#import "MCDataCacheManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MCDataCacheManager * cache = [MCDataCacheManager shareInstance];
    [cache MCAccordingToTheVersionStore:YES];
    [cache MCwriteData:@"dasdasdsadsadsa" withFile:@"2233" withAccount:@"czx1" withExpireTime:0];
        NSLog(@"%lf",[cache folderSize]);
    NSLog(@"%@",[cache MCGetPath]);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    NSLog(@"TOUCH");
//    NSLog(@"%@",[MCDataCacheManager MCGetPath]);



//    [cache MCsetmaxCacheSize:2];
//    for (NSInteger i = 0; i < 3000; i++) {
//        [cache MCwriteData:@"dasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsadasdasdsadsadsa" withFile:[NSString stringWithFormat:@"%zd",i] withAccount:@"czx" withExpireTime:0];
//    }
//    [cache MCwriteData:@"dasdasdsadsadsa" withFile:@"3" withAccount:@"czx" withExpireTime:0];
//    [cache MCwriteData:@"dasdasdsadsadsa" withFile:@"4" withAccount:@"czx" withExpireTime:0];
//    [cache MCwriteData:@"dasdasdsadsadsa" withFile:@"4" withAccount:@"czx" withExpireTime:0];
//    [cache MCwriteData:@"dasdasdsadsadsa" withFile:@"5" withAccount:@"czx" withExpireTime:0];
//    [cache MCwriteData:@"dasdasdsadsadsa" withFile:@"6" withAccount:@"czx" withExpireTime:0];
//    [cache MCwriteData:@"dasdasdsadsadsa" withFile:@"7" withAccount:@"czx" withExpireTime:0];

//    [cache MCremoveData:@"1" withAccount:@"czx"];
//    [cache MCremoveAllAccount:@"czx"];
//    [cache MCwriteData:@"dasdasdsadsadsa" withFile:@"dasdsadQWEQWEWQEWQEQWEWQE" withAccount:@"czx" withExpireTime:0];
//    NSLog(@"withAccount === %@",[cache MCreadJSONData:@"dasdsad" withAccount:@"czx"]);

    /**
     *  设定默认时间
     */
//    [cache MCsetDefautExpireTime:5];
//    
//    if ([cache MCcheckExpireFile:@"mc"]) {
//        NSLog(@"数据已过期 result = %@",[cache MCreadData:@"mc"]);
//
//        /**
//         *  这个地方写网络加载
//         */
//        NSMutableDictionary * testParam=[NSMutableDictionary dictionary];
//                [testParam setObject:@"test1" forKey:@"mc1"];
//                [testParam setObject:@"test2" forKey:@"mc2"];
//                [testParam setObject:@"test2" forKey:@"mc3"];
//
//        NSLog(@"数据过期,插入新数据 result = %@",testParam);
//        /**
//         *  使用默认时间
//         */
//        [cache MCwriteDefautExpireData:@"312321" withFile:@"mc"];
//    [cache MCremoveData:@"mc"];
//
//        /**
//         * 使用自定义时间
//         */
////        [cache MCwriteData:testParam withFile:@"TEST" withExpireTime:30];
//        /**
//         *  不使用缓存
//         */
////        [cache MCwriteNoDefautExpireData:testParam withFile:@"TEST"];
//    }else {
//        NSLog(@"数据未过期 result = %@",[cache MCreadData:@"mc"]);
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
