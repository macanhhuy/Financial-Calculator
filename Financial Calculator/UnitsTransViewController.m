//
//  UnitsTransViewController.m
//  Financial Calculator
//
//  Created by Shijia Qian on 28/03/12.
//  Copyright (c) 2012 UTAS. All rights reserved.
//

#import "UnitsTransViewController.h"
#import "Constants.h"

@interface UnitsTransViewController ()

@end

@implementation UnitsTransViewController

@synthesize pickerFrom;
@synthesize pickerTo;
@synthesize scroll;
@synthesize text;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    fromRow = 0;
    toRow = 0;
    [super loadView];
}

- (void)viewDidLoad
{
    self.pickerFrom.delegate = self;
    self.pickerTo.delegate = self;
    
    self.pickerFrom.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.pickerFrom.frame = CGRectMake(10, 140, 150, 200);
    self.pickerTo.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.pickerTo.frame = CGRectMake(165, 140, 150, 200);
    
    self.text.returnKeyType = UIReturnKeyDone;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated
{
    if([Constants getWhat] == 0)
    {
        pickerContent = [Constants getUnits:@"length"];
    }
    else if([Constants getWhat] == 1)
    {
        pickerContent = [Constants getUnits:@"weight"];
    }
    else if([Constants getWhat] == 2)
    {
        pickerContent = [Constants getUnits:@"volume"];
    }
    else if([Constants getWhat] == 3)
    {
        pickerContent = [Constants getUnits:@"area"];
    }
    [super viewWillAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//**************************************
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [[pickerContent allKeys] count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [[pickerContent allKeys] objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(pickerView.tag == 101)
    {
        fromRow = row;
    }
    else
    {
        toRow = row;
    }
}
//**************************************

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.scroll setContentOffset:CGPointMake(0.0f, 65.0f) animated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.scroll setContentOffset:CGPointMake(0.0f, 0.0f) animated:YES];
}

- (IBAction)textFieldDoneEditing:(id)sender
{
    [sender resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString *regex = @"([0-9]+[.]{0,1}[0-9]*)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if([pred evaluateWithObject:textField.text])
    {
        [textField resignFirstResponder];
        [self convert];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ERROR" message:@"Please enter a valid number!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    return NO;
}

- (void)convert
{
    NSNumber *from = [pickerContent objectForKey:[[pickerContent allKeys] objectAtIndex:fromRow]];
    NSNumber *to = [pickerContent objectForKey:[[pickerContent allKeys] objectAtIndex:toRow]];
    
    double result = [text.text doubleValue] * ([from doubleValue] / [to doubleValue]);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"RESULT" message:[NSString stringWithFormat:@"%@ %@ equal %g %@", text.text, [[pickerContent allKeys] objectAtIndex:fromRow], result, [[pickerContent allKeys] objectAtIndex:toRow]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    text.text = @"";
}



@end
