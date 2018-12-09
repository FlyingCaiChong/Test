//
//  ViewController.m
//  Test
//
//  Created by 方恒 on 2018/12/9.
//  Copyright © 2018年 Caichong. All rights reserved.
//

#import "ViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "CommentModel.h"
#import "CommentCell.h"

static NSString * const kCellIdentifier = @"CommentCell";

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, CommentCellDelegate>

@property (nonatomic, copy) NSArray *dataArr;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.s
    [self configData];
    
    [self.view addSubview:self.tableView];
}

- (void)configData {
    CommentModel *model1 = [[CommentModel alloc] init];
    model1.isShow = NO;
    model1.comment = @"完成到这一步，我们仍然没有发现上述两个问题是应该怎么解释。但是我们知道了，一个Object-C 对象的指针，和它的成员变量的指针肯定是连续的。这就为接下来我们的分析提供了一些思路。";
    
    CommentModel *model2 = [[CommentModel alloc] init];
    model2.isShow = NO;
    model2.comment = @"为啥要增加这行代码呢，这步是经过深(瞎)思(J)熟(B)虑(试)，主要是考虑到函数内部的参数生成必然会需要地方存储，但这部分存储地址，我们是不知晓的，它的实现是被系统隐藏的。而我们的代码又没有明显的设置相关代码，那么必然是由这些条件实现的。所以当我们增加了这一行代码后，不出意外的，打印结果变了";
    
    CommentModel *model3 = [[CommentModel alloc] init];
    model3.isShow = NO;
    model3.comment = @"这类问题，考察的东西很深，并且结合了很多知识点。但是当我们拿到面试题并且能进行思索的时候一定要好好的考虑，我对这道题的想法，也是在不断的试验中逐渐的完善，并且尝试了很多。其实找面试题为什么是这个答案的过程和，找代码找bug的流程都是类似的，都是排除变量，逐步探索，最终将探索过程和概念结合";
    
    CommentModel *model4 = [[CommentModel alloc] init];
    model4.isShow = NO;
    model4.comment = @"我对这道题的想法，也是在不断的试验中逐渐的完善";
    
    
    self.dataArr = @[model1, model2, model3, model4];
}

- (void)commentCell:(CommentCell *)cell didClickShowMoreView:(UIView *)view {
    NSLog(@"delegate response did click show more");
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    [self configCell:cell atIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:kCellIdentifier configuration:^(id cell) {
        [self configCell:cell atIndexPath:indexPath];
    }];
}

- (void)configCell:(CommentCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    [cell configDataWithModel:self.dataArr[indexPath.row]];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.fd_debugLogEnabled = YES;
        [_tableView registerClass:[CommentCell class] forCellReuseIdentifier:kCellIdentifier];
    }
    return _tableView;
}

@end
