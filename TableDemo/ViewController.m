//
//  ViewController.m
//  TableDemo
//
//  Created by mahong on 17/3/20.
//  Copyright © 2017年 mahong. All rights reserved.
//

#import "ViewController.h"
#import "ChildViewController.h"
#import "YBDataBaseHandler.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *mainTable;
@property (strong, nonatomic) UIImageView *topView;
@property (assign, nonatomic) BOOL scrollStatus;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor cyanColor];
    self.navigationItem.title = @"main";
    [self.view addSubview:self.mainTable];
    [self.view addSubview:self.topView];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"销毁" style:UIBarButtonItemStylePlain target:self action:@selector(invalidateList)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"查询" style:UIBarButtonItemStylePlain target:self action:@selector(queryList)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld组 - 第%ld行",(long)indexPath.section,(long)indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) return 0.1f;
    return 10.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *path = [NSString stringWithFormat:@"100%ld%ld",(long)indexPath.section,(long)indexPath.row];
    BOOL result = [[YBDataBaseHandler shareManager] executeSql:[NSString stringWithFormat:@"insert into app_exam_lx (sqh,drivetype,tikuid) values (%ld,'xc','kmy')",(long)path.integerValue]];
    if (!result) {
        NSLog(@"插入数据失败");
    }
    
    
    ChildViewController *child = [ChildViewController new];
    ExamType type = ExamType1;
    if (indexPath.section == 1) type = ExamType2;
    if (indexPath.section == 2) type = ExamType3;
    child.examType = type;
    [self.navigationController pushViewController:child animated:YES];
}

#pragma mark -  Action
- (void)invalidateList
{
    [YBDataBaseHandler invalidate];
}

- (void)queryList
{
    NSInteger count = [[YBDataBaseHandler shareManager] queryData];
    NSLog(@"数据库记录个数 == %ld",(long)count);
}

- (void)hideTopView:(UIGestureRecognizer *)recognizer
{
    UIView *view = recognizer.view;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        view.frame = CGRectZero;
        weakSelf.mainTable.contentInset = UIEdgeInsetsZero;
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.scrollStatus) {
        CGFloat top = -scrollView.contentOffset.y -100;
        self.topView.frame = CGRectMake(0, top, self.view.frame.size.width, 100);
    }
    else{
        CGFloat height = -scrollView.contentOffset.y;
        self.topView.frame = CGRectMake(0, 0, self.view.frame.size.width, height);
    }
    
}

#pragma mark -  Lazy init
- (UITableView *)mainTable
{
    if (!_mainTable) {
        _mainTable = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _mainTable.delegate = self;
        _mainTable.dataSource = self;
        _mainTable.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
        _mainTable.showsVerticalScrollIndicator = NO;
        [_mainTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellid"];
    }
    return _mainTable;
}

- (UIView *)topView
{
    if (!_topView) {
        _topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
//        _topView.backgroundColor = [UIColor redColor];
        _topView.image = [UIImage imageNamed:@"test"];
        _topView.userInteractionEnabled = YES;
        [_topView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideTopView:)]];
    }
    return _topView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
