//
//  MBResource.m
//  iNaviCore
//
//  Created by delon on 13-4-23.
//  Copyright (c) 2013年 Mapbar. All rights reserved.
//

#import "MBResource.h"
#define RESOURCE_BUNDLE_NAME    @"Resources.bundle"
#define RESOURCE_IMAGE_FOLDER   @"images"

static MBResource *MBResource_instance = nil;
@implementation MBResource
{
    NSString *_filePath;
    NSMutableDictionary *_values;
}

+ (MBResource *)sharedResoure
{
    if (!MBResource_instance)
    {
        MBResource_instance = [[MBResource alloc] init];
    }
    
    return MBResource_instance;
}

- (void)setupValues
{
    //比例尺在大地图黑夜下的颜色
    [_values setObject:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0] forKey:@"resource.map.scale.night.color"];
    //比例尺在大地图黑夜下的边框颜色
    [_values setObject:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0] forKey:@"resource.map.scale.night.outlinecolor"];
    //比例尺在大地图白天下的颜色
    [_values setObject:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0] forKey:@"resource.map.scale.day.color"];
    //比例尺在大地图白天下的边框颜色
    [_values setObject:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0] forKey:@"resource.map.scale.day.outlinecolor"];
    //游标在大地图黑夜下的颜色
    [_values setObject:[UIColor colorWithRed:0.6 green:0.74 blue:0.996 alpha:1.0] forKey:@"resource.map.auxiliaryline.night.color"];
    //游标线条在大地图黑夜下的边框颜色
    [_values setObject:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0] forKey:@"resource.map.auxiliaryline.night.outlinecolor"];
    //游标标签在大地图黑夜下的绘画颜色
    [_values setObject:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0] forKey:@"resource.map.auxiliarylabel.night.strokecolor"];
    [_values setObject:[UIColor colorWithRed:0.6 green:0.74 blue:0.996 alpha:1.0] forKey:@"resource.map.auxiliarylabel.night.color"];
    
    [_values setObject:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0] forKey:@"resource.map.auxiliaryline.day.outlinecolor"];
    [_values setObject:[UIColor colorWithRed:0.41 green:0.53 blue:0.61 alpha:1.0] forKey:@"resource.map.auxiliaryline.day.color"];
    [_values setObject:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0] forKey:@"resource.map.auxiliarylabel.day.strokecolor"];
    [_values setObject:[UIColor colorWithRed:0.41 green:0.53 blue:0.61 alpha:1.0] forKey:@"resource.map.auxiliarylabel.day.color"];
    /*
    [_values setObject:[UIColor colorWithRed:0xbb/255.0f green:0x25/255.0f blue:0xae/255.0f alpha:1.0] forKey:@"resource.map.route.outlinecolor.0"];
    [_values setObject:[UIColor colorWithRed:0x5d/255.0f green:0x27/255.0f blue:0x86/255.0f alpha:1.0] forKey:@"resource.map.route.outlinecolor.1"];
    [_values setObject:[UIColor colorWithRed:0x23/255.0f green:0x5d/255.0f blue:0x85/255.0f alpha:1.0] forKey:@"resource.map.route.outlinecolor.2"];
    [_values setObject:[UIColor colorWithRed:0x00/255.0f green:0x78/255.0f blue:0xff/255.0f alpha:1.0] forKey:@"resource.map.route.outlinecolor.3"];
    
    [_values setObject:[UIColor colorWithRed:0x03/255.0f green:0x7F/255.0f blue:0xD6/255.0f alpha:1.0] forKey:@"resource.map.route.selectedColor.0"];
    [_values setObject:[UIColor colorWithRed:0xB3/255.0f green:0x00/255.0f blue:0x00/255.0f alpha:1.0] forKey:@"resource.map.route.selectedColor.1"];
    [_values setObject:[UIColor colorWithRed:0x16/255.0f green:0x9F/255.0f blue:0x0C/255.0f alpha:1.0] forKey:@"resource.map.route.selectedColor.2"];
    
    [_values setObject:[UIColor colorWithRed:0x52/255.0f green:0xB7/255.0f blue:0xFD/255.0f alpha:1.0] forKey:@"resource.map.route.unselectedColor.0"];
    [_values setObject:[UIColor colorWithRed:0xF6/255.0f green:0x5A/255.0f blue:0x5B/255.0f alpha:1.0] forKey:@"resource.map.route.unselectedColor.1"];
    [_values setObject:[UIColor colorWithRed:0x18/255.0f green:0xE6/255.0f blue:0x83/255.0f alpha:1.0] forKey:@"resource.map.route.unselectedColor.2"];
    */
    [_values setObject:[UIFont systemFontOfSize:10] forKey:@"resource.iphone.map.scale.textfont"];
    [_values setObject:[UIFont systemFontOfSize:16] forKey:@"resource.ipad.map.scale.textfont"];
    
    [_values setObject:[UIFont systemFontOfSize:14] forKey:@"resource.iphone.map.auxiliarylabel.font"];
    [_values setObject:[UIFont systemFontOfSize:18] forKey:@"resource.ipad.map.auxiliarylabel.font"];
    
    [_values setObject:[NSNumber numberWithFloat:10] forKey:@"resource.iphone.map.layout.maxmargin"];
    [_values setObject:[NSNumber numberWithFloat:20] forKey:@"resource.ipad.map.layout.maxmargin"];
    
    [_values setObject:[NSNumber numberWithFloat:5] forKey:@"resource.iphone.map.layout.tinymargin"];
    [_values setObject:[NSNumber numberWithFloat:10] forKey:@"resource.ipad.map.layout.tinymargin"];
    
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self->_filePath = [[[NSBundle mainBundle] resourcePath] retain];
        self->_values = [[NSMutableDictionary alloc] init];
        
        [self setupValues];
    }
    
    return self;
}

- (void)dealloc
{
    [_filePath release];
    [_values release];
    self.relativePath = nil;
    [super dealloc];
}

- (UIImage *)universalImageForName:(NSString *)name
{
    return self.relativePath ? [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@/images/%@",self.relativePath,RESOURCE_BUNDLE_NAME,name,nil]]:[UIImage imageNamed:[NSString stringWithFormat:@"%@/images/%@",RESOURCE_BUNDLE_NAME,name,nil]];
}

- (NSString *)universalImageFilePath:(NSString *)name
{
    return self.relativePath ?[NSString stringWithFormat:@"%@/%@/images/%@",self.relativePath,RESOURCE_BUNDLE_NAME,name,nil]:[NSString stringWithFormat:@"%@/images/%@",RESOURCE_BUNDLE_NAME,name,nil];
}

- (UIImage *)imageForName:(NSString *)name
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        return self.relativePath ? [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@/images/iphone/%@",self.relativePath,RESOURCE_BUNDLE_NAME,name,nil]]:[UIImage imageNamed:[NSString stringWithFormat:@"%@/images/iphone/%@",RESOURCE_BUNDLE_NAME,name,nil]];
    }
    
    return self.relativePath ? [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@/images/ipad/%@",self.relativePath,RESOURCE_BUNDLE_NAME,name,nil]]:[UIImage imageNamed:[NSString stringWithFormat:@"%@/images/ipad/%@",RESOURCE_BUNDLE_NAME,name,nil]];
}

- (NSString *)imageFilePath:(NSString *)name
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        return self.relativePath ? [NSString stringWithFormat:@"%@/%@/images/iphone/%@",self.relativePath,RESOURCE_BUNDLE_NAME,name,nil]:[NSString stringWithFormat:@"%@/images/iphone/%@", RESOURCE_BUNDLE_NAME,name,nil];
    }
    
    return self.relativePath ? [NSString stringWithFormat:@"%@/%@/images/ipad/%@",self.relativePath,RESOURCE_BUNDLE_NAME,name,nil]:[NSString stringWithFormat:@"%@/images/ipad/%@", RESOURCE_BUNDLE_NAME,name,nil];
}

- (id)universalObjectForName:(NSString *)name
{
    return [_values objectForKey:[NSString stringWithFormat:@"resource.%@",name,nil]];
}

- (id)objectForName:(NSString *)name
{
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? [_values objectForKey:[NSString stringWithFormat:@"resource.iphone.%@",name,nil]] : [_values objectForKey:[NSString stringWithFormat:@"resource.ipad.%@",name,nil]];
}

@end
