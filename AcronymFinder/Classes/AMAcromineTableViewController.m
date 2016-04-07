//
//  AMAcromineTableViewController.m
//  AcronymFinder
//
//  Created by Avinash Dongarwar on 4/6/16.
//  Copyright © 2016 Avinash Dongarwar. All rights reserved.
//

#import "AMAcromineTableViewController.h"
#import "AMLongFormTableCell.h"
#import "AMWSGetAcromines.h"
#import "AMAcromines.h"
#import "AMVariationTableViewController.h"
#import "MBProgressHUD.h"

static NSString * const kGetAcrominesRESTServiceURLString = @"software/acromine/dictionary.py";

@interface AMAcromineTableViewController ()  <UISearchBarDelegate>

@property (nonatomic, strong) NSArray* acrominesArray;
@property (weak) IBOutlet UISearchBar * searchBar;

@property (nonatomic, strong) MBProgressHUD* progressHUD;

@end

@implementation AMAcromineTableViewController

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
    return 72.0;
}


- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section >= [[self acrominesArray] count])
        return 0;
    
    AMAcromine *acromine = [[self acrominesArray] objectAtIndex:section];
    
    return [acromine shortForm];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [[self acrominesArray] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section >= [[self acrominesArray] count])
        return 0;
    
    AMAcromine *acromine = [[self acrominesArray] objectAtIndex:section];
    return [[acromine longForms] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    AMLongFormTableCell * cell = [tableView dequeueReusableCellWithIdentifier:kLongFormCellIdentifier
                                                                 forIndexPath:indexPath];
    
    if ([indexPath section] >= [[self acrominesArray] count])
        return 0;
    
    AMAcromine *acromine = [[self acrominesArray] objectAtIndex:[indexPath section]];
    
    if ([indexPath row] >= [[acromine longForms] count])
        return 0;
    
   
    AMLongForm *longform = [[acromine longForms] objectAtIndex:[indexPath row]];
    
    [self configureCell:cell forLongFormObject:longform];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"pushVariationList" sender:self];
}



#pragma mark - Search Bar Delegates


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {

    [self setAcrominesArray:nil];
    [[self view] endEditing:YES];
    
    [self progressHUD].progress = 0.0;
    [[self progressHUD] show:YES];
    
    __weak id weakSelf = self;
    
    [AMWSGetAcromines getAcrominesWithUrl:kGetAcrominesRESTServiceURLString
                             forShortForm:[[searchBar text] stringByTrimmingCharactersInSet:
                                                    [NSCharacterSet whitespaceAndNewlineCharacterSet]]
                          completionBlock:^(NSArray *responseArray) {
                             
                              [weakSelf progressHUD].progress = 1.0;
                              [[weakSelf progressHUD] hide:YES];
                              
                              if (![responseArray count])
                              {
                                  [weakSelf showNoResultsAlert];
                              }
                              
                              [weakSelf setAcrominesArray:responseArray];
                              [[weakSelf tableView] reloadData];
                              
                          }
                                  failure:^(NSError *inError) {
                                      
                                      [weakSelf progressHUD].progress = 1.0;
                                      [[weakSelf progressHUD] hide:YES];
                                      
                                      [weakSelf showErrorAlert];
                                  }];
}



- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [[self searchBar] setText:@""];
    [self setAcrominesArray:nil];
    [[self view] endEditing:YES];
    [[self tableView] reloadData];
}


#pragma mark - Segue Handling

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    if([[segue identifier] isEqualToString:@"pushVariationList"]){
        NSIndexPath *selectedRowIndex = [[self tableView] indexPathForSelectedRow];
        
        if ([selectedRowIndex section] >= [[self acrominesArray] count])
            return;
        
        AMAcromine *acromine = [[self acrominesArray] objectAtIndex:[selectedRowIndex section]];
        
        if ([selectedRowIndex row] >= [[acromine longForms] count])
            return;
        
        
        AMLongForm *longform = [[acromine longForms] objectAtIndex:[selectedRowIndex row]];
 
        AMVariationTableViewController *vc = [segue destinationViewController];
        [vc populateVariationData:[longform longFormVariables]];
    }
    
}


#pragma mark Getters - Setters - lazy initializers

- (NSArray *)acrominesArray
{
    
    if (!_acrominesArray)
    {
        _acrominesArray = [NSArray array];
    }
    
    return _acrominesArray;
}


- (MBProgressHUD *)progressHUD
{
    if (!_progressHUD)
    {
        _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:_progressHUD];
        _progressHUD.labelText = @"Loading...";
        _progressHUD.mode = MBProgressHUDModeDeterminateHorizontalBar;
    }
    
    return _progressHUD;
}

#pragma mark --Helpers

- (void) showErrorAlert
{
    @autoreleasepool {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error!"
                                                                        message:@"Search Failed"
                                                                 preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* cancelButton = [UIAlertAction actionWithTitle:@"Cancel"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action)
                                       {
                                          
                                           
                                       }];
        
        [alert addAction:cancelButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}


- (void) showNoResultsAlert
{
    @autoreleasepool {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@""
                                                                        message:@"No Results"
                                                                 preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* cancelButton = [UIAlertAction actionWithTitle:@"Cancel"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action)
                                       {
                                        
                                       }];
        
        [alert addAction:cancelButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}



@end
