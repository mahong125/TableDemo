//
//  YBDataBaseHandler.m
//  TableDemo
//
//  Created by mahong on 17/3/20.
//  Copyright © 2017年 mahong. All rights reserved.
//

#import "YBDataBaseHandler.h"

@interface YBDataBaseHandler ()
@property (strong, nonatomic) FMDatabaseQueue *fmdb;
@end

@implementation YBDataBaseHandler

+ (instancetype)shareManager
{
    static YBDataBaseHandler *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[YBDataBaseHandler alloc] init];
    });
    return manager;
}

- (FMDatabaseQueue *)fmdb
{
    if (!_fmdb) {
        /** 创建临时数据库
          文件路径有三种情况
         （1）具体文件路径 如果不存在会自动创建
         （2）空字符串@"" 会在临时目录创建一个空的数据库 当FMDatabase连接关闭时，数据库文件也被删除
         （3）nil 会创建一个内存中临时数据库，当FMDatabase连接关闭时，数据库会被销毁
         */
        _fmdb = [FMDatabaseQueue databaseQueueWithPath:@""];
        /** 创建临时数据表 */
        [_fmdb inTransaction:^(FMDatabase *db, BOOL *rollback) {
           
            NSString *sql =
            @"create table if not exists app_exam_lx (id integer PRIMARY KEY AUTOINCREMENT, SQH int DEFAULT(0),DriveType varchar(20),TikuID varchar(10),SortID varchar,BaseID varchar(10),BaseDa varchar(20),UserDa varchar(20));"
            "CREATE INDEX lx_tiku_index ON app_exam_lx (TikuID ASC);"
            "CREATE INDEX lx_sort_index ON app_exam_lx (SortID ASC);"
            "CREATE INDEX lx_drive_index ON app_exam_lx (DriveType ASC);";
            
//            /** 事务回滚 */
//            *rollback = YES;
//            NSLog(@"rollback  %d",*rollback);

            BOOL result = [db executeStatements:sql];
            if (!result) NSLog(@"创建表失败");
        }];
        
//        [_fmdb inDatabase:^(FMDatabase *db) {
//            NSString *sql = @"create table if not exists app_exam_lx (\r\n  id integer PRIMARY KEY AUTOINCREMENT,\r\n  SQH int DEFAULT(0),\r\n  DriveType varchar(20),\r\n  TikuID varchar(10),\r\n  SortID varchar,\r\n  BaseID varchar(10),\r\n  BaseDa varchar(20),\r\n  UserDa varchar(20)\r\n);\nCREATE INDEX lx_tiku_index ON app_exam_lx (TikuID ASC);\r\nCREATE INDEX lx_sort_index ON app_exam_lx (SortID ASC);\r\nCREATE INDEX lx_drive_index ON app_exam_lx (DriveType ASC);";
//            
//            BOOL result = [db executeStatements:sql];
//            if (!result) NSLog(@"创建表失败");
//        }];
    }
    return _fmdb;
}

- (BOOL)executeSql:(NSString *)sql
{
    __block BOOL result = NO;
    [self.fmdb inDatabase:^(FMDatabase *db) {
        result = [db executeUpdate:sql];
    }];
    return result;
}

- (NSInteger )queryData
{
    __block NSInteger count = 0;
    [self.fmdb inDatabase:^(FMDatabase *db) {
        NSString *sql = @"select count(1) as total from app_exam_lx";
        FMResultSet *rs = [db executeQuery:sql];
        if ([rs next]) {
            count = [rs intForColumn:@"total"];
        }
        [rs close];
    }];
    return count;
}

+ (void)invalidate
{
    [[YBDataBaseHandler shareManager].fmdb close];
    [YBDataBaseHandler shareManager].fmdb = nil;
}

@end
