//
//  AMLongFormTableCell.h
//  AcronymFinder
//
//  Created by Avinash Dongarwar on 4/6/16.
//  Copyright © 2016 Avinash Dongarwar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AMLongForm;

@interface AMLongFormTableCell : UITableViewCell

- (void)configureCellForLongFormObject:(AMLongForm *)longFormObject;

@end
