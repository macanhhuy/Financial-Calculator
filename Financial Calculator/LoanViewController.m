//
//  LoanViewController.m
//  Financial Calculator
//
//  Created by Shijia Qian on 23/09/12.
//  Copyright (c) 2012 UTAS. All rights reserved.
//

#import "LoanViewController.h"
#import "ResultViewController.h"

@interface LoanViewController ()
{
    float payment;
    float noOfPayments;
    float totalInterest;
    float apr;
}

@end

@implementation LoanViewController
@synthesize mortgageAmount;
@synthesize interestRate;
@synthesize extraCost;
@synthesize mortgageTerms;
@synthesize compoundFreqLabel;
@synthesize paymentFreqLabel;
@synthesize compoundFreq;
@synthesize paymentFreq;

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
    [self.compoundFreq addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    [self.paymentFreq addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
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

- (void)segmentChanged:(UISegmentedControl *)seg
{
    NSInteger index = seg.selectedSegmentIndex;
    if(seg.tag == 101)
    {
        switch (index) {
            case 0:
                self.compoundFreqLabel.text = [NSString stringWithFormat:@"Annually %@/Yr", [seg titleForSegmentAtIndex:index]];
                break;
            case 1:
                self.compoundFreqLabel.text = [NSString stringWithFormat:@"Semi-Annually %@/Yr", [seg titleForSegmentAtIndex:index]];
                break;
            case 2:
                self.compoundFreqLabel.text = [NSString stringWithFormat:@"Quarterly %@/Yr", [seg titleForSegmentAtIndex:index]];
                break;
            case 3:
                self.compoundFreqLabel.text = [NSString stringWithFormat:@"Monthly %@/Yr", [seg titleForSegmentAtIndex:index]];
                break;
            default:
                break;
        }
    }
    else
    {
        switch (index) {
            case 0:
                self.paymentFreqLabel.text = [NSString stringWithFormat:@"Monthly %@/Yr", [seg titleForSegmentAtIndex:index]];
                break;
            case 1:
                self.paymentFreqLabel.text = [NSString stringWithFormat:@"Bi-Weekly %@/Yr", [seg titleForSegmentAtIndex:index]];
                break;
            case 2:
                self.paymentFreqLabel.text = [NSString stringWithFormat:@"Weekly %@/Yr", [seg titleForSegmentAtIndex:index]];
                break;
            default:
                break;
        }
    }
}

- (IBAction)calculate
{
    if([self.mortgageAmount.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ERROR" message:@"Mortgage Amount is required!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 201;
        [alert show];
        return;
    }
    if([self.interestRate.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ERROR" message:@"Interest Rate is required!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 202;
        [alert show];
        return;
    }
    if([self.mortgageTerms.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ERROR" message:@"Mortgage Terms is required!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 203;
        [alert show];
        return;
    }
    
    NSString *regex = @"([0-9]+[.]{0,1}[0-9]*)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if(![pred evaluateWithObject:self.mortgageAmount.text])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ERROR" message:@"Mortgage Amount should be a valid number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 201;
        [alert show];
        return;
    }
    if(![pred evaluateWithObject:self.interestRate.text])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ERROR" message:@"Interest Rate should be a valid number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 202;
        [alert show];
        return;
    }
    if(![pred evaluateWithObject:self.mortgageTerms.text])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ERROR" message:@"Mortgage Terms should be a valid number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 203;
        [alert show];
        return;
    }
    
    float mortAmount = self.mortgageAmount.text.floatValue;
    float mortInterest = self.interestRate.text.floatValue;
    float mortTerms = self.mortgageTerms.text.floatValue;
    float extraCostAmount = self.extraCost.text.floatValue;
    
    float cf = [compoundFreq titleForSegmentAtIndex:compoundFreq.selectedSegmentIndex].floatValue;
    float pf = [paymentFreq titleForSegmentAtIndex:paymentFreq.selectedSegmentIndex].floatValue;
    noOfPayments = mortTerms * pf;
    float adjustedRate = pow((1 + mortInterest / 100 / cf), cf / pf) - 1;
    
    payment = ((mortAmount + extraCostAmount) * adjustedRate * pow((1 + adjustedRate), noOfPayments)) / (pow(1 + adjustedRate, noOfPayments) - 1);
    
    totalInterest = noOfPayments * payment - mortAmount;
    
    if(extraCostAmount != 0)
    {
        float aprRate = 0;
        for(float i = 0; i <= 500; i++)
        {
            if((mortInterest + i / 100) / (cf * 100) * pow(1 + (mortInterest + i / 100) / (cf * 100), noOfPayments) / (pow(1 + (mortInterest + i / 100) / (cf * 100), noOfPayments) - 1) - payment / mortAmount < 0)
            {
                if((mortInterest + (i + 1) / 100) / (cf * 100) * pow(1 + (mortInterest + (i + 1) / 100) / (cf * 100), noOfPayments) / (pow(1 + (mortInterest + (i + 1) / 100) / (cf * 100), noOfPayments) - 1) - payment / mortAmount > 0)
                {
                    break;
                }
            }
            aprRate++;
        }
        apr = mortInterest + aprRate / 100;
    }
    else
    {
        apr = mortInterest;
    }
    [self performSegueWithIdentifier:@"result" sender:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag) {
        case 201:
            self.mortgageAmount.text = @"";
            [self.mortgageAmount becomeFirstResponder];
            break;
        case 202:
            self.interestRate.text = @"";
            [self.interestRate becomeFirstResponder];
            break;
        case 203:
            self.mortgageTerms.text = @"";
            [self.mortgageTerms becomeFirstResponder];
            break;
        default:
            break;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.mortgageAmount resignFirstResponder];
    [self.mortgageTerms resignFirstResponder];
    [self.interestRate resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ((ResultViewController *)[segue destinationViewController]).payment = payment;
    ((ResultViewController *)[segue destinationViewController]).noOfPayments = noOfPayments;
    ((ResultViewController *)[segue destinationViewController]).totalInterest = totalInterest;
    ((ResultViewController *)[segue destinationViewController]).apr = apr;
}

@end
