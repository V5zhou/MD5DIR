//
//  MD5DIR.h
//  MD5DIR
//
//  Created by zmz on 2020/2/25.
//  Copyright © 2020 zmz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MD5DIR_OUTTYPE) {
    MD5DIR_OUTTYPE_JSON_Steep = 0, /// 陡峭JSON
    MD5DIR_OUTTYPE_JSON_Flat  = 1  /// 平坦JSON
};

@interface NSData (md5)

- (NSString *)md5String;

@end

@interface NSDictionary (jsonString)

- (NSString *)jsonString;

@end

@interface MD5DIR : NSObject

@property (nonatomic, assign) BOOL isAllFile;         /// 是否包含隐藏文件
@property (nonatomic, assign) MD5DIR_OUTTYPE outType; /// 输出文件类型

- (NSString *)MD5DIR:(NSString *)dir_path;

@end

NS_ASSUME_NONNULL_END
