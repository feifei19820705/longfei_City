//
//  MBResource.h
//  iNaviCore
//
//  Created by delon on 13-4-23.
//  Copyright (c) 2013年 Mapbar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBResource : NSObject
@property(nonatomic,retain) NSString *relativePath;

+ (MBResource *)sharedResoure;

- (UIImage *)universalImageForName:(NSString *)name;
- (NSString *)universalImageFilePath:(NSString *)name;
- (UIImage *)imageForName:(NSString *)name;
- (NSString *)imageFilePath:(NSString *)name;

- (id)universalObjectForName:(NSString *)name;
- (id)objectForName:(NSString *)name;

@end
