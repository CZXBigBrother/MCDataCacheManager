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
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    MCDataCacheManager * cache = [MCDataCacheManager shareInstance];
    
    /**
     *  设定默认时间
     */
    [cache MCsetDefautExpireTime:15];
    
    if ([cache MCcheckExpireFile:@"mc"]) {
        /**
         *  这个地方写网络加载
         */
        NSMutableDictionary * testParam=[NSMutableDictionary dictionary];
                [testParam setObject:@"test1" forKey:@"mc1"];
                [testParam setObject:@"test2" forKey:@"mc2"];
        NSLog(@"数据过期,插入新数据 result = %@",testParam);
        /**
         *  使用默认时间
         */
        [cache MCwriteDefautExpireData:testParam withFile:@"mc"];
        
        
        /**
         * 使用自定义时间
         */
//        [cache MCwriteData:testParam withFile:@"TEST" withExpireTime:30];
        /**
         *  不使用缓存
         */
//        [cache MCwriteNoDefautExpireData:testParam withFile:@"TEST"];
    }else {
        NSLog(@"数据未过期 result = %@",[cache MCreadData:@"mc"]);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
