//
//  MD5DIR.m
//  MD5DIR
//
//  Created by zmz on 2020/2/25.
//  Copyright © 2020 zmz. All rights reserved.
//

#import "MD5DIR.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSData (md5)

// Returns the SHA1 hash of a data as a string
- (NSString *)md5String {
    uint8_t digest[CC_MD5_DIGEST_LENGTH];
    //使用对应的CC_SHA256,CC_SHA384,CC_SHA512
    CC_MD5(self.bytes, self.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) [output appendFormat:@"%02x", digest[i]];
    return output;
}

@end

@implementation NSDictionary (jsonString)

- (NSString *)jsonString {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];

    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }

    // 去掉空格与换行符
    NSString *result = [jsonString stringByReplacingOccurrencesOfString:@" \n" withString:@""];
    return result;
}

@end

@interface MD5DIR ()

@property (nonatomic, strong) NSFileManager *fm;

@end

@implementation MD5DIR

- (NSDictionary *)MD5DIR:(NSString *)path {
    BOOL isDir = NO;
    // 跳过隐藏文件
    if ([[path lastPathComponent] hasPrefix:@"."] && !_isAllFile) { return @{}; }
    if ([self.fm fileExistsAtPath:path isDirectory:&isDir]) {
        if (isDir) {
            NSMutableDictionary *result = [NSMutableDictionary dictionary];
            NSError *error              = nil;
            NSArray *list               = [self.fm contentsOfDirectoryAtPath:path error:&error];
            if (error) {
                NSLog(@"%ld:%@", error.code, error.localizedDescription);
                return nil;
            }
            for (NSString *subName in list) {
                NSString *subPath = [path stringByAppendingPathComponent:subName];
                BOOL isSubDir     = NO;
                if ([self.fm fileExistsAtPath:subPath isDirectory:&isSubDir]) {
                    // 跳过隐藏文件
                    if ([subName hasPrefix:@"."] && !_isAllFile) { continue; }
                    if (isSubDir) {
                        result[subName] = [self MD5DIR:subPath];
                    } else {
                        NSData *data = [[NSData alloc] initWithContentsOfFile:subPath];
                        if (data.length > 0) {
                            result[subName] = [data md5String];
                        } else {
                            NSLog(@"空文件跳过MD5：%@", subPath);
                        }
                    }
                }
            }
            return result;
        }
    } else {
        NSLog(@"文件不存在：%@", path);
    }
    return nil;
}

- (NSFileManager *)fm {
    if (!_fm) { _fm = [NSFileManager defaultManager]; }
    return _fm;
}

@end
