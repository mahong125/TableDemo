//
//  ChildViewController.h
//  TableDemo
//
//  Created by mahong on 17/3/20.
//  Copyright © 2017年 mahong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,ExamType){
    ExamType1,
    ExamType2,
    ExamType3
};

@interface ChildViewController : UIViewController
@property (assign, nonatomic) ExamType examType;
@end
