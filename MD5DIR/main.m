//
//  main.m
//  MD5DIR
//
//  Created by zmz on 2020/2/25.
//  Copyright © 2020 zmz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MD5DIR.h"


void PSPrintLine(NSString *format, ...) {
    va_list args;
    va_start(args, format);
    NSString *string = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    fprintf(stdout, "%s\n", [string UTF8String]);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray *args = [[NSProcessInfo processInfo] arguments];
        NSString *path = nil; // 输入路径
        NSString *outPath = nil; // 输出路径
        BOOL isALL = NO; // 是否包含隐藏文件
        
//        NSData *data = [@"/** * @Author: carl * @Date: 2018-06-05T10:19:40+08:00 * @Last modified by: yuanjielong * @Last modified time: 2018-09-30T11:14:10+08:00 */ import theme from './theme' import i18n from './i18n' const module = { screens: { MessageListScreen: () => require('./containers/MessageListScreen').default, MessageWebScreen: () => require('./containers/MessageWebScreen').default }, theme, i18n } export default module" dataUsingEncoding:NSUTF8StringEncoding];
//        NSLog(@"%@", [data md5String]);
        
        // 未输入参数
        if (args.count == 1) {
             PSPrintLine(@"请输入参数，如：-path xxx/xxxx"); return 0;
        }
        
        // help
        NSUInteger idx = [args indexOfObject:@"-h"]; // HELP
        if (idx != NSNotFound) {
             PSPrintLine(@"暂无帮助信息，未编写"); return 0;
        }
        
        // path
        idx = [args indexOfObject:@"-p"]; //PATH
        if (idx == NSNotFound || idx == args.count - 1) {
             PSPrintLine(@"请输入文件夹路径，如：-path xxx/xxxx"); return 0;
        } else {
            path = args[idx + 1];
        }
        
        // 是否包含隐藏文件
        idx = [args indexOfObject:@"-a"]; //ALL
        if (idx != NSNotFound) {
            isALL = YES;
        }
        
        // 输出路径
        idx = [args indexOfObject:@"-o"]; //output
        if (idx != NSNotFound && idx < args.count - 1) {
            outPath = args[idx + 1];
        }
        
//        path = @"/Users/zmz/beeline_ios/flutter";
        MD5DIR *md = [[MD5DIR alloc] init];
        md.isAllFile = isALL;
        NSString *result = [[md MD5DIR:path] jsonString];
        if (outPath) {
            [result writeToFile:outPath atomically:true encoding:NSUTF8StringEncoding error:nil];
        } else {
            PSPrintLine(@"%@", result);
        }
    }
    return 0;
}
