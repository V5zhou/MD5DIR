//
//  MD5DIR.h
//  MD5DIR
//
//  Created by zmz on 2020/2/25.
//  Copyright © 2020 zmz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (md5)

- (NSString *)md5String;

@end

@interface NSDictionary (jsonString)

- (NSString *)jsonString;

@end

@interface MD5DIR : NSObject

@property (nonatomic, assign) BOOL isAllFile;

- (NSDictionary *)MD5DIR:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
