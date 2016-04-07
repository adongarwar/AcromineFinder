//
//  AMLongFormTableCell.m
//  AcronymFinder
//
//  Created by Avinash Dongarwar on 4/6/16.
//  Copyright © 2016 Avinash Dongarwar. All rights reserved.
//

#import "AMLongFormTableCell.h"
#import "AMAcromines.h"

@interface AMLongFormTableCell()

@property (weak) IBOutlet UILabel * longFormLabel;
@property (weak) IBOutlet UILabel * variableCountLabel;
@property (weak) IBOutlet UILabel * sinceLabel;
@property (weak) IBOutlet UILabel * freqLabel;


@end

@implementation AMLongFormTableCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)configureCellForLongFormObject:(AMLongForm *)longFormObject
{
    [[self longFormLabel] setText:[longFormObject longForm]];
    
    [[self variableCountLabel] setText: [longFormObject longFormVariables] ?
                                            [NSString stringWithFormat:@"%lu",
                                                    (unsigned long)[[longFormObject longFormVariables] count]] : @""];
    
    
    
    [[self sinceLabel] setText:[NSString stringWithFormat:@"Since %@",
                                            [[longFormObject since] stringValue]]];
    
    [[self freqLabel] setText:[NSString stringWithFormat:@"Frequency: %@",
                                        [[longFormObject frequency] stringValue]]];
    
    if (![[longFormObject longFormVariables] count])
        self.accessoryType = UITableViewCellAccessoryNone;
    
}

@end
