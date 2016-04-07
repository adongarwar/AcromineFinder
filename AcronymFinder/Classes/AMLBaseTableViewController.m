//
//  AMLBaseTableViewController.m
//  AcronymFinder
//
//  Created by Avinash Dongarwar on 4/6/16.
//  Copyright © 2016 Avinash Dongarwar. All rights reserved.
//

#import "AMLBaseTableViewController.h"
#import "AMLongFormTableCell.h"

NSString *const kLongFormCellIdentifier = @"longFormcellID";
NSString *const kAMLongFormTableCellNibName = @"AMLongFormTableCell";

@implementation AMLBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // we use a nib which contains the cell's view and this class as the files owner
    [self.tableView registerNib:[UINib nibWithNibName:kAMLongFormTableCellNibName bundle:nil]
         forCellReuseIdentifier:kLongFormCellIdentifier];
}

- (void)configureCell:(AMLongFormTableCell *)cell forLongFormObject:(AMLongForm *)longFormObject
{
    [cell configureCellForLongFormObject:longFormObject];
   
}

@end

