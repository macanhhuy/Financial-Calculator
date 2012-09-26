//
//  LoanViewController.h
//  Financial Calculator
//
//  Created by Shijia Qian on 23/09/12.
//  Copyright (c) 2012 UTAS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoanViewController : UIViewController<UITextFieldDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) IBOutlet UITextField *mortgageAmount;
@property (nonatomic, strong) IBOutlet UITextField *interestRate;
@property (nonatomic, strong) IBOutlet UITextField *mortgageTerms;
@property (nonatomic, strong) IBOutlet UITextField *extraCost;
@property (nonatomic, strong) IBOutlet UILabel *compoundFreqLabel;
@property (nonatomic, strong) IBOutlet UILabel *paymentFreqLabel;
@property (nonatomic, strong) IBOutlet UISegmentedControl *compoundFreq;
@property (nonatomic, strong) IBOutlet UISegmentedControl *paymentFreq;

-(IBAction)calculate;

@end
