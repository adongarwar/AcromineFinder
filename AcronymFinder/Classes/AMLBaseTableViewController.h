//
//  AMLBaseTableViewController.h
//  AcronymFinder
//
//  Created by Avinash Dongarwar on 4/6/16.
//  Copyright © 2016 Avinash Dongarwar. All rights reserved.
//


@import UIKit;

@class AMLongForm;
@class AMLongFormTableCell;

extern NSString *const kLongFormCellIdentifier;

@interface AMLBaseTableViewController : UITableViewController

- (void)configureCell:(AMLongFormTableCell *)cell forLongFormObject:(AMLongForm *)longFormObject;

@end
