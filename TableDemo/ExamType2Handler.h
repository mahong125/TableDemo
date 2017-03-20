//
//  ExamType2Handler.h
//  TableDemo
//
//  Created by mahong on 17/3/20.
//  Copyright © 2017年 mahong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static NSString * const kExamType2Cell = @"kExamType2Cell";
@interface ExamType2Handler : NSObject<UITableViewDataSource,UITableViewDelegate>
+ (instancetype)shareManager;
@end
