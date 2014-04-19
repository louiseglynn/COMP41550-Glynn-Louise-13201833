//
//  BNRImageStore.h
//  Homepwner
//
//  Created by CSI Student on 18/04/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRImageStore : NSObject

+(instancetype)sharedStore;

-(void)setImage:(UIImage *)image forKey:(NSString * )key;
-(UIImage *)imageForKey:(NSString *)key;
-(void)deleteImageForKey:(NSString *)key;

@end
