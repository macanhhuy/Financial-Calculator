//
//  ResultViewController.h
//  Financial Calculator
//
//  Created by Shijia Qian on 23/09/12.
//  Copyright (c) 2012 UTAS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultViewController : UIViewController

@property (nonatomic) float payment;
@property (nonatomic) float totalInterest;
@property (nonatomic) float apr;
@property (nonatomic) int noOfPayments;
@property (nonatomic, strong) IBOutlet UILabel *paymentLabel;
@property (nonatomic, strong) IBOutlet UILabel *noOfPaymentsLabel;
@property (nonatomic, strong) IBOutlet UILabel *totalPaymentLabel;
@property (nonatomic, strong) IBOutlet UILabel *totalInterestLabel;
@property (nonatomic, strong) IBOutlet UILabel *aprLabel;

@end
