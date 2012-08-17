//
//  UnitsTransViewController.h
//  Financial Calculator
//
//  Created by Shijia Qian on 28/03/12.
//  Copyright (c) 2012 UTAS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UnitsTransViewController : UIViewController <UIPickerViewDelegate, UITextFieldDelegate>
{
    UIPickerView *pickerFrom;
    UIPickerView *pickerTo;
    NSDictionary *pickerContent;
    UIScrollView *scroll;
    UITextField *text;
    int fromRow, toRow;
}

@property (nonatomic, retain) IBOutlet UIPickerView *pickerFrom;
@property (nonatomic, retain) IBOutlet UIPickerView *pickerTo;
@property (nonatomic, retain) IBOutlet UIScrollView *scroll;
@property (nonatomic, retain) IBOutlet UITextField *text;

- (void)convert;

@end
