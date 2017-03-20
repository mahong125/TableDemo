//
//  ExamType1Handler.h
//  TableDemo
//
//  Created by mahong on 17/3/20.
//  Copyright © 2017年 mahong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static NSString * const kExamType1Cell = @"kExamType1Cell";

@interface ExamType1Handler : NSObject<UITableViewDataSource,UITableViewDelegate>
+ (instancetype)shareManager;

@property (strong, nonatomic) NSMutableArray *dataSource;
@end
