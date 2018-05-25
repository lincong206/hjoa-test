//
//  DataBaseManager.m
//  hjoa
//
//  Created by 华剑 on 2017/3/22.
//  Copyright © 2017年 huajian. All rights reserved.
//

#import "DataBaseManager.h"
#import "FMDatabase.h"

@interface DataBaseManager ()
@property (nonatomic, strong) FMDatabase *db;
@end

@implementation DataBaseManager

+ (DataBaseManager *)shareDataBase
{
    static DataBaseManager *dataBase = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        dataBase = [[DataBaseManager alloc] init];
//        NSLog(@"%@", kLibraryPath);
        dataBase.db = [[FMDatabase alloc] initWithPath:
                       [kLibraryPath stringByAppendingString:@"/dataBase.sqlite3"]];
        [dataBase.db open];
        /*
         uiId           用户id
         uiAccount      账号
         uiName         用户名
         psId           部门id
         uiPsname         部门名
         uiHeadimage    头像
         uiMobile       手机号码
         */
        if ([dataBase.db executeUpdate:@"CREATE TABLE IF NOT EXISTS appAddressTabel1(uiId text PRIMARY KEY NOT NULL,uiAccount text NOT NULL,uiName text,psId text,uiPsname text,uiHeadimage text,uiMobile text)"] == NO) {
            NSLog(@"创建表失败");
        }
        [dataBase.db close];
    });
    return dataBase;
}

- (void)insertData:(addressModel *)model
{
    [self.db open];
    if ([self.db executeUpdate:@"INSERT INTO appAddressTabel1 (uiId, uiAccount, uiName, psId, uiPsname, uiHeadimage, uiMobile) VALUES (?, ?, ?, ?, ?, ?, ?)", model.uiId, model.uiAccount,model.uiName,model.psId,model.uiPsname,model.uiHeadimage,model.uiMobile] == NO) {
        NSLog(@"增加数据失败");
    }
    [self.db close];
}

- (void)deleteAllData
{
    [self.db open];
    if ([self.db executeUpdate:@"DELETE FROM appAddressTabel1"] == NO) {
        NSLog(@"删除失败");
    }
    [self.db close];
}

- (NSMutableArray *)searchAllData
{
    [self.db open];
    NSMutableArray *dataM = [[NSMutableArray alloc] init];
    FMResultSet *set = [self.db executeQuery:@"SELECT * FROM appAddressTabel1"];
    while ([set next] == YES) {
        addressModel *a = [[addressModel alloc] init];
        a.uiId = [set stringForColumn:@"uiId"];
        a.uiAccount = [set stringForColumn:@"uiAccount"];
        a.uiName = [set stringForColumn:@"uiName"];
        a.psId = [set stringForColumn:@"psId"];
        a.uiPsname = [set stringForColumn:@"uiPsname"];
        a.uiHeadimage = [set stringForColumn:@"uiHeadimage"];
        a.uiMobile = [set stringForColumn:@"uiMobile"];
        [dataM addObject:a];
    }
    [self.db close];
    return dataM;
}

@end
