//
//  YBDataBaseHandler.h
//  TableDemo
//
//  Created by mahong on 17/3/20.
//  Copyright © 2017年 mahong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>

@interface YBDataBaseHandler : NSObject
+ (instancetype)shareManager;

/** 销毁数据库 */
+ (void)invalidate;

- (BOOL)executeSql:(NSString *)sql;

- (NSInteger )queryData;
@end
