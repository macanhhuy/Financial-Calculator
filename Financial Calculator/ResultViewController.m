//
//  ResultViewController.m
//  Financial Calculator
//
//  Created by Shijia Qian on 23/09/12.
//  Copyright (c) 2012 UTAS. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()

@end

@implementation ResultViewController
@synthesize payment;
@synthesize noOfPayments;
@synthesize apr;
@synthesize totalInterest;
@synthesize totalInterestLabel;
@synthesize totalPaymentLabel;
@synthesize paymentLabel;
@synthesize noOfPaymentsLabel;
@synthesize aprLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.paymentLabel.text = [NSString stringWithFormat:@"$%.2f", payment];
    self.noOfPaymentsLabel.text = [NSString stringWithFormat:@"%d", noOfPayments];
    self.totalPaymentLabel.text = [NSString stringWithFormat:@"$%.2f", payment * noOfPayments];
    self.totalInterestLabel.text = [NSString stringWithFormat:@"$%.2f", totalInterest];
    self.aprLabel.text = [NSString stringWithFormat:@"%.2f%@", apr, @"%"];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
