//
//  AMVariationTableViewController.m
//  AcronymFinder
//
//  Created by Avinash Dongarwar on 4/7/16.
//  Copyright © 2016 Avinash Dongarwar. All rights reserved.
//

#import "AMVariationTableViewController.h"
#import "AMLongFormTableCell.h"
#import "AMAcromines.h"

@interface AMVariationTableViewController ()

@property (nonatomic, strong) NSArray* variationsArray;

@end

@implementation AMVariationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source and delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [[self variationsArray] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    AMLongFormTableCell * cell = [tableView dequeueReusableCellWithIdentifier:kLongFormCellIdentifier
                                                                 forIndexPath:indexPath];
    
    if ([indexPath row] >= [[self variationsArray] count])
        return 0;
    
    AMLongForm *longFormObj = [[self variationsArray] objectAtIndex:[indexPath row]];
    
    [self configureCell:cell forLongFormObject:longFormObj];
    
    return cell;
}


- (void) populateVariationData:(NSArray *)variations
{
    [self setVariationsArray:variations];
}


#pragma mark Getters - Setters - lazy initializers

- (NSArray *)variationsArray
{
    if (!_variationsArray)
    {
        _variationsArray = [NSArray array];
    }
    
    return _variationsArray;
}


@end
