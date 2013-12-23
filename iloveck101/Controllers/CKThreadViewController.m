//
//  CKThreadViewController.m
//  iloveck101
//
//  Created by Chong Francis on 13年12月24日.
//  Copyright (c) 2013年 Ignition Soft. All rights reserved.
//

#import "CKThreadViewController.h"
#import "UIAlertView+AFNetworking.h"
#import "UIActivityIndicatorView+AFNetworking.h"

#import "CKThread.h"
#import "CKThreadDetail.h"
#import "CKThreadCell.h"

#import "DACircularProgressView.h"
#import "CKThreadDetailPhotoModel.h"

@interface CKThreadViewController ()
@property (nonatomic, strong) NSArray* threads;
@property (nonatomic, strong) CKThreadDetailPhotoModel* detailPhotoModel;
@end

@implementation CKThreadViewController

- (void)reload:(__unused id)sender {
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    NSURLSessionTask *task = [CKThread listThreadWithURL:@"/" block:^(NSArray *threads, NSError *error) {
        if (!error) {
            self.threads = threads;
            [self.tableView reloadData];
        }
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }];

    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
    UIActivityIndicatorView *activityIndicatorView = (UIActivityIndicatorView *)self.navigationItem.leftBarButtonItem.customView;
    [activityIndicatorView setAnimatingWithStateOfTask:task];
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"ck101";

    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:activityIndicatorView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reload:)];
    self.tableView.rowHeight = 70.0f;
    [self reload:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return (NSInteger)[self.threads count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    CKThreadCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[CKThreadCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.thread = [self.threads objectAtIndex:(NSUInteger)indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    CKThread* thread = [self.threads objectAtIndex:(NSUInteger)indexPath.row];
    [self loadThreadDetail:thread];
}

#pragma mark - Private

- (void) loadThreadDetail:(CKThread*)thread {
    [CKThreadDetail getThreadDetailWithURL:thread.url.absoluteString
                                     block:^(CKThreadDetail *threadDetail, NSError *error) {
                                         if (!error) {
                                             self.detailPhotoModel = [[CKThreadDetailPhotoModel alloc] initWithThreadDetail:threadDetail];
                                             MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self.detailPhotoModel];
                                             [self.navigationController pushViewController:browser animated:YES];
                                         } else {
                                             UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error loading images"
                                                                                             message:[NSString stringWithFormat:@"%@", error.description]
                                                                                            delegate:nil
                                                                                   cancelButtonTitle:@"OK"
                                                                                   otherButtonTitles:nil];
                                             [alert show];
                                         }
                                     }];
}

@end
