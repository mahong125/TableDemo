//
//  ExamType3Handler.h
//  TableDemo
//
//  Created by mahong on 17/3/20.
//  Copyright © 2017年 mahong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static NSString * const kExamType3Cell = @"kExamType3Cell";

@interface ExamType3Handler : NSObject<UITableViewDelegate,UITableViewDataSource>
+ (instancetype)shareManager;
@end
