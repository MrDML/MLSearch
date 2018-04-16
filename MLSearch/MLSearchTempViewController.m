//
//  MLSearchTempViewController.m
//  MLSearch
//
//  Created by 戴明亮 on 2018/4/16.
//  Copyright © 2018年 ML Day. All rights reserved.
//

#import "MLSearchTempViewController.h"
#import "MLSearchController.h"
#import "MLResultTableViewController.h"

@interface MLSearchTempViewController ()<UITableViewDelegate,UITableViewDataSource,MLSearchControllerDelegate,MLSearchBarDelegate,MLSearchResultsUpdating>
@property (nonatomic, strong) MLSearchController *searchController;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MLSearchTempViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:52/255.0 alpha:1];

    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height ) style:UITableViewStylePlain];
    
    self.tableView = tableView;
    
    tableView.rowHeight = 44;
    tableView.delegate = self;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    MLSearchController *searchController = [[MLSearchController alloc] initWithSearchResultsController:[[MLResultTableViewController alloc] init]];
    _searchController = searchController;
    _searchController.hidesNavigationBarDuringPresentation = YES;
    _searchController.delegate = self;
    _searchController.searchBar.delegate = self;
    _searchController.searchResultsUpdater = self;
    tableView.tableHeaderView = (UIView *)searchController.searchBar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifire"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"indentifire"];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    //[NSString stringWithFormat:@"%d",indexPath.row];
    //self.dataArray[indexPath.row];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
}

#pragma mark MLSearchResultsUpdating
- (void)updateSearchResultsForSearchController:(MLSearchController *)searchController
{
    NSString *text = searchController.searchBar.text;
    NSPredicate *Predicate =  [NSPredicate predicateWithFormat:@"(SELF CONTAINS %@)",text];
    MLResultTableViewController * ResultController  =(MLResultTableViewController *)searchController.searchResultsController;
    if (!(text.length > 0)) {
        ResultController.resultDataArray = @[];
    }else{
        NSArray *result =  [self.dataArray filteredArrayUsingPredicate:Predicate];
        ResultController.resultDataArray = result;
    }
    
    
    
    NSLog(@"%s",__func__);
}

#pragma mark MLSearchControllerDelegate
- (void)willPresentSearchController:(MLSearchController *)searchController
{
    NSLog(@"%s",__func__);
}

- (void)didPresentSearchController:(MLSearchController *)searchController
{
    NSLog(@"%s",__func__);
}

- (void)willDismissSearchController:(MLSearchController *)searchController
{
    NSLog(@"%s",__func__);
}

- (void)didDismissSearchController:(MLSearchController *)searchController
{
    NSLog(@"%s",__func__);
}


#pragma mark MLSearchBarDelegate
- (void)searchBarDidBeginEditing:(MLSearchBar *)searchBar
{
    NSLog(@"%s",__func__);
}

- (void)searchBarTextDidEndEditing:(MLSearchBar *)searchBar
{
    NSLog(@"%s",__func__);
}

- (void)searchBar:(MLSearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"%s",__func__);
}


#pragma mark lazy
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"country" ofType:@"txt"];
        NSError *error;
        NSString *string = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
        if (!error) {
            NSArray *array = [string componentsSeparatedByString:@"\n"];
            _dataArray = [array copy];
        }
    }
    return _dataArray;
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
