//
//  ChildViewController.m
//  TableDemo
//
//  Created by mahong on 17/3/20.
//  Copyright © 2017年 mahong. All rights reserved.
//

#import "ChildViewController.h"
#import "ExamType1Handler.h"
#import "ExamType2Handler.h"
#import "ExamType3Handler.h"

@interface ChildViewController ()
@property (strong, nonatomic) UITableView *mainTable;
@end

@implementation ChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationItem.title = @"child";
    [self.view addSubview:self.mainTable];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"更新" style:UIBarButtonItemStylePlain target:self action:@selector(updateData)];
}

- (void)updateData
{
    [ExamType1Handler shareManager].dataSource = [NSMutableArray arrayWithArray:@[@"更新1",@"更新23",@"更新sdfds"]];
    [self.mainTable reloadData];
}

#pragma mark -  Lazy init
- (UITableView *)mainTable
{
    if (!_mainTable) {
        _mainTable = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        switch (self.examType) {
            case ExamType1:
            {
                _mainTable.delegate = [ExamType1Handler shareManager];
                _mainTable.dataSource = [ExamType1Handler shareManager];
                [ExamType1Handler shareManager].dataSource = [NSMutableArray arrayWithArray:@[@"1",@"23",@"sdfds"]];
                [_mainTable registerClass:[UITableViewCell class] forCellReuseIdentifier:kExamType1Cell];
            }
                break;
            case ExamType2:
            {
                _mainTable.delegate = [ExamType2Handler shareManager];
                _mainTable.dataSource = [ExamType2Handler shareManager];
                [_mainTable registerClass:[UITableViewCell class] forCellReuseIdentifier:kExamType2Cell];
            }
                break;
            case ExamType3:
            {
                _mainTable.delegate = [ExamType3Handler shareManager];
                _mainTable.dataSource = [ExamType3Handler shareManager];
                [_mainTable registerClass:[UITableViewCell class] forCellReuseIdentifier:kExamType3Cell];
            }
                break;
        }
        _mainTable.showsVerticalScrollIndicator = NO;
        
    }
    return _mainTable;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
