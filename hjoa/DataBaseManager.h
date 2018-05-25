//
//  DataBaseManager.h
//  hjoa
//
//  Created by 华剑 on 2017/3/22.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "addressModel.h"

#define kLibraryPath [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]

@interface DataBaseManager : NSObject

+ (DataBaseManager *)shareDataBase;

- (void)insertData:(addressModel *)model;

- (NSMutableArray *)searchAllData;

- (void)deleteAllData;

@end
