//
//  ViewController.m
//  Financial Calculator
//
//  Created by Shijia Qian on 1/03/12.
//  Copyright (c) 2012 UTAS. All rights reserved.
//

#import "ViewController.h"
#import "Math.h"

@implementation ViewController

@synthesize currentOperationLabel;
@synthesize mainLabel;
@synthesize valueSet;
@synthesize memoryData;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    readyToCpt = NO;
    valueSet = [[NSMutableDictionary alloc] init];
    pastNumbersAndOps = [[NSMutableDictionary alloc] init];
    cashFlows = [[NSMutableArray alloc] init];
    memoryData = 0;
    fromCalculate = NO;
    
    Operator *plus = [[Operator alloc] init];
    plus.operate = @"plus";
    plus.priority = 1;
    
    Operator *minus = [[Operator alloc] init];
    minus.operate = @"minus";
    minus.priority = 1;
    
    Operator *multiply = [[Operator alloc] init];
    multiply.operate = @"multiply";
    multiply.priority = 2;
    
    Operator *divide = [[Operator alloc] init];
    divide.operate = @"divide";
    divide.priority = 2;
    
    Operator *power = [[Operator alloc] init];
    power.operate = @"power";
    power.priority = 3;
    
    Operator *root = [[Operator alloc] init];
    root.operate = @"root";
    root.priority = 3;
    
    operatorArray = [[NSArray alloc] initWithObjects:plus, minus, multiply, divide, power, root, nil];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationLandscapeLeft && interfaceOrientation != UIInterfaceOrientationLandscapeRight);
}

- (IBAction)btnPressed:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) 
    {
        //normal operator btn pressed!
        case 101:
            if(calulateEnabled == YES)
            {
                if(currentCalculation != nil)
                {
                    if(currentCalculation.priority > 1)
                    {
                        mainLabel.text = [NSString stringWithFormat:@"%.10lg", [self calculatePastNumbers:currentCalculation]];
                        [pastNumbersAndOps removeAllObjects];
                    }
                    else
                    {
                        mainLabel.text = [NSString stringWithFormat:@"%.10lg", [self calculate:currentCalculation]];
                    }
                }
                lastNumber = [NSNumber numberWithDouble:[mainLabel.text doubleValue]];
            }
            currentCalculation = [operatorArray objectAtIndex:0];
            currentOperationLabel.text = @"+";
            clearMainScreen = YES;
            calulateEnabled = NO;
            break;  
        case 102:
            if(calulateEnabled == YES)
            {
                if(currentCalculation != nil)
                {
                    if(currentCalculation.priority > 1)
                    {
                        mainLabel.text = [NSString stringWithFormat:@"%.10lg", [self calculatePastNumbers:currentCalculation]];
                        [pastNumbersAndOps removeAllObjects];
                    }
                    else
                    {
                        mainLabel.text = [NSString stringWithFormat:@"%.10lg", [self calculate:currentCalculation]];
                    }
                }
                lastNumber = [NSNumber numberWithDouble:[mainLabel.text doubleValue]];
            }
            currentCalculation = [operatorArray objectAtIndex:1];
            currentOperationLabel.text = @"-";
            clearMainScreen = YES;
            calulateEnabled = NO;
            break;
        case 103:
            if(calulateEnabled == YES)
            {
                if(currentCalculation != nil)
                {
                    if(currentCalculation.priority < 2)
                    {
                        [pastNumbersAndOps setObject:[NSNumber numberWithDouble:[lastNumber doubleValue]] forKey:currentCalculation.operate];
                        NSLog(@"%d", [pastNumbersAndOps count]);
                    }   
                    else if(currentCalculation.priority > 2)
                    {
                        if([pastNumbersAndOps count] > 1)
                        {
                            if([[[pastNumbersAndOps allKeys] objectAtIndex:0] isEqualToString:@"multiply"] || [[[pastNumbersAndOps allKeys] objectAtIndex:0] isEqualToString:@"divide"])
                            {
                                mainLabel.text = [NSString stringWithFormat:@"%.10lg", [self calculatePastNumbers:currentCalculation]];
                                [pastNumbersAndOps removeAllObjects];
                            }
                            else
                            {
                                mainLabel.text = [NSString stringWithFormat:@"%.10lg", [self calculate:currentCalculation]];
                            }
                        }
                        else
                        {
                            mainLabel.text = [NSString stringWithFormat:@"%.10lg", [self calculate:currentCalculation]];
                        }
                    }
                    else
                    {
                        mainLabel.text = [NSString stringWithFormat:@"%.10lg", [self calculate:currentCalculation]];
                    }
                }
                lastNumber = [NSNumber numberWithDouble:[mainLabel.text doubleValue]];
            }
            currentCalculation = [operatorArray objectAtIndex:2];
            currentOperationLabel.text = @"x";
            clearMainScreen = YES;
            calulateEnabled = NO;
            break;
        case 104:
            if(calulateEnabled == YES)
            {
                if(currentCalculation != nil)
                {
                    if(currentCalculation.priority < 2)
                    {
                        [pastNumbersAndOps setObject:[NSNumber numberWithDouble:[lastNumber doubleValue]] forKey:currentCalculation.operate];
                        NSLog(@"%d", [pastNumbersAndOps count]);
                    }   
                    else if(currentCalculation.priority > 2)
                    {
                        if([[[pastNumbersAndOps allKeys] objectAtIndex:0] isEqualToString:@"multiply"] || [[[pastNumbersAndOps allKeys] objectAtIndex:0] isEqualToString:@"divide"])
                        {
                            mainLabel.text = [NSString stringWithFormat:@"%.10lg", [self calculatePastNumbers:currentCalculation]];
                            [pastNumbersAndOps removeAllObjects];
                        }
                        else
                        {
                            mainLabel.text = [NSString stringWithFormat:@"%.10lg", [self calculate:currentCalculation]];
                        }
                    }
                    else
                    {
                        mainLabel.text = [NSString stringWithFormat:@"%.10lg", [self calculate:currentCalculation]];
                    }
                }
                lastNumber = [NSNumber numberWithDouble:[mainLabel.text doubleValue]];
            }
            currentCalculation = [operatorArray objectAtIndex:3];
            currentOperationLabel.text = @"÷";
            clearMainScreen = YES;
            calulateEnabled = NO;
            break;
        case 105:
            readyToCpt = NO;
            clearMainScreen = NO;
            mainLabel.text = @"0";
            currentOperationLabel.text = @"";
            currentCalculation = nil;
            calulateEnabled = YES;
            currentOperationLabel.text = @"";
            lastNumber = nil;
            [valueSet removeAllObjects];
            [cashFlows removeAllObjects];
            [pastNumbersAndOps removeAllObjects];
            break;
        case 106:
            if(currentCalculation != nil)
            {
                if([pastNumbersAndOps count] == 0)
                {
                    mainLabel.text = [NSString stringWithFormat:@"%.10lg", [self calculate:currentCalculation]];
                }
                else
                {
                    mainLabel.text = [NSString stringWithFormat:@"%.10lg", [self calculatePastNumbers:currentCalculation]];
                }
            }
            currentCalculation = nil;
            [pastNumbersAndOps removeAllObjects];
            lastNumber = nil;
            calulateEnabled = YES;
            currentOperationLabel.text = @"";
            clearMainScreen = YES;
            break;
        case 107:
            if(calulateEnabled == YES)
            {
                if(currentCalculation != nil)
                {
                    if(currentCalculation.priority < 3)
                    {
                        [pastNumbersAndOps setObject:[NSNumber numberWithDouble:[lastNumber doubleValue]] forKey:currentCalculation.operate];
                        NSLog(@"%d", [pastNumbersAndOps count]);
                    }
                    else
                    {
                        [self calculate:currentCalculation];
                    }
                }
                lastNumber = [NSNumber numberWithDouble:[mainLabel.text doubleValue]];
            }
            currentCalculation = [operatorArray objectAtIndex:4];
            currentOperationLabel.text = @"y^x";
            clearMainScreen = YES;
            calulateEnabled = NO;
            break;
        case 108:
            mainLabel.text = [NSString stringWithFormat:@"%.6lg", pow([mainLabel.text doubleValue], 2)];
            clearMainScreen = YES;
            break;
        case 109:
            mainLabel.text = [NSString stringWithFormat:@"%.6lg", 1 / [mainLabel.text doubleValue]];
            clearMainScreen = YES;
            break;
        case 110:
            mainLabel.text = [NSString stringWithFormat:@"%.6lg", pow([mainLabel.text doubleValue], 0.5)];
            clearMainScreen = YES;
            break;
        case 111:
            if(calulateEnabled == YES)
            {
                if(currentCalculation != nil)
                {
                    if(currentCalculation.priority < 3)
                    {
                        [pastNumbersAndOps setObject:[NSNumber numberWithDouble:[lastNumber doubleValue]] forKey:currentCalculation.operate];
                        NSLog(@"%d", [pastNumbersAndOps count]);
                    }
                    else
                    {
                        [self calculate:currentCalculation];
                    }
                }
                lastNumber = [NSNumber numberWithDouble:[mainLabel.text doubleValue]];
            }
            currentCalculation = [operatorArray objectAtIndex:5];
            currentOperationLabel.text = @"x√y";
            clearMainScreen = YES;
            calulateEnabled = NO;
            break;
        //number btn pressed!
        case 201:
            if(!clearMainScreen)
            {
                //if current main screen shows "0" then replace ot with the btn number
                if([mainLabel.text isEqualToString:@"0"])
                {
                    mainLabel.text = @"1";
                }
                else
                {
                    mainLabel.text = [mainLabel.text stringByAppendingString:@"1"];
                }
            }
            else
            {
                mainLabel.text = @"1";
                clearMainScreen = NO;
                dotted = NO;
            }
            calulateEnabled = YES;
            currentOperationLabel.text = @"";
            break;
        case 202:
            if(!clearMainScreen)
            {
                if([mainLabel.text isEqualToString:@"0"])
                {
                    mainLabel.text = @"2";
                }
                else
                {
                    mainLabel.text = [mainLabel.text stringByAppendingString:@"2"];
                }
            }
            else
            {
                mainLabel.text = @"2";
                clearMainScreen = NO;
                dotted = NO;
            }
            calulateEnabled = YES;
            currentOperationLabel.text = @"";
            break;
        case 203:
            if(!clearMainScreen)
            {
                if([mainLabel.text isEqualToString:@"0"])
                {
                    mainLabel.text = @"3";
                }
                else
                {
                    mainLabel.text = [mainLabel.text stringByAppendingString:@"3"];
                }
            }
            else
            {
                mainLabel.text = @"3";
                clearMainScreen = NO;
                dotted = NO;
            }
            calulateEnabled = YES;
            currentOperationLabel.text = @"";
            break;
        case 204:
            if(!clearMainScreen)
            {
                if([mainLabel.text isEqualToString:@"0"])
                {
                    mainLabel.text = @"4";
                }
                else
                {
                    mainLabel.text = [mainLabel.text stringByAppendingString:@"4"];
                }
            }
            else
            {
                mainLabel.text = @"4";
                clearMainScreen = NO;
                dotted = NO;
            }
            calulateEnabled = YES;
            currentOperationLabel.text = @"";
            break;
        case 205:
            if(!clearMainScreen)
            {
                if([mainLabel.text isEqualToString:@"0"])
                {
                    mainLabel.text = @"5";
                }
                else
                {
                    mainLabel.text = [mainLabel.text stringByAppendingString:@"5"];
                }
            }
            else
            {
                mainLabel.text = @"5";
                clearMainScreen = NO;
                dotted = NO;
            }
            calulateEnabled = YES;
            currentOperationLabel.text = @"";
            break;
        case 206:
            if(!clearMainScreen)
            {
                if([mainLabel.text isEqualToString:@"0"])
                {
                    mainLabel.text = @"6";
                }
                else
                {
                    mainLabel.text = [mainLabel.text stringByAppendingString:@"6"];
                }
            }
            else
            {
                mainLabel.text = @"6";
                clearMainScreen = NO;
                dotted = NO;
            }
            calulateEnabled = YES;
            currentOperationLabel.text = @"";
            break;
        case 207:
            if(!clearMainScreen)
            {
                if([mainLabel.text isEqualToString:@"0"])
                {
                    mainLabel.text = @"7";
                }
                else
                {
                    mainLabel.text = [mainLabel.text stringByAppendingString:@"7"];
                }
            }
            else
            {
                mainLabel.text = @"7";
                clearMainScreen = NO;
                dotted = NO;
            }
            calulateEnabled = YES;
            currentOperationLabel.text = @"";
            break;
        case 208:
            if(!clearMainScreen)
            {
                if([mainLabel.text isEqualToString:@"0"])
                {
                    mainLabel.text = @"8";
                }
                else
                {
                    mainLabel.text = [mainLabel.text stringByAppendingString:@"8"];
                }
            }
            else
            {
                mainLabel.text = @"8";
                clearMainScreen = NO;
                dotted = NO;
            }
            calulateEnabled = YES;
            currentOperationLabel.text = @"";
            break;
        case 209:
            if(!clearMainScreen)
            {
                if([mainLabel.text isEqualToString:@"0"])
                {
                    mainLabel.text = @"9";
                }
                else
                {
                    mainLabel.text = [mainLabel.text stringByAppendingString:@"9"];
                }
            }
            else
            {
                mainLabel.text = @"9";
                clearMainScreen = NO;
                dotted = NO;
            }
            calulateEnabled = YES;
            currentOperationLabel.text = @"";
            break;
        case 210:
            if(!clearMainScreen)
            {
                if([mainLabel.text isEqualToString:@"0"])
                {
                    mainLabel.text = @"0";
                }
                else
                {
                    mainLabel.text = [mainLabel.text stringByAppendingString:@"0"];
                }
            }
            else
            {
                mainLabel.text = @"0";
                clearMainScreen = NO;
                dotted = NO;
            }
            calulateEnabled = YES;
            currentOperationLabel.text = @"";
            break;
        case 211:
            if((!clearMainScreen))
            {
                if(!dotted)
                {
                    mainLabel.text = [mainLabel.text stringByAppendingString:@"."];
                    dotted = YES;
                }
            }
            else
            {
                mainLabel.text = @"0.";
                dotted = YES;
                clearMainScreen = NO;
            }
            calulateEnabled = YES;
            currentOperationLabel.text = @"";
            break;
        //financial btn pressed!
        case 301:
            if(!readyToCpt)
            {
                [self.valueSet setObject:[NSNumber numberWithDouble:[mainLabel.text doubleValue]]  forKey:@"pv"];
            }
            else
            {
                [self compute:@"pv"];
            }
            currentOperationLabel.text = @"PV";
            clearMainScreen = YES;
            break;
        case 302:
            if(!readyToCpt)
            {
                [self.valueSet setObject:[NSNumber numberWithDouble:[mainLabel.text doubleValue]]  forKey:@"i"];
            }
            else
            {
                [self compute:@"i"];
            }
            currentOperationLabel.text = @"I";
            clearMainScreen = YES;
            break;
        case 303:
            if(!readyToCpt)
            {
                [self.valueSet setObject:[NSNumber numberWithDouble:[mainLabel.text doubleValue]]  forKey:@"fv"];
            }
            else
            {
                [self compute:@"fv"];
            }
            clearMainScreen = YES;
            currentOperationLabel.text = @"FV";
            break;
        case 304:
            if(!readyToCpt)
            {
                [self.valueSet setObject:[NSNumber numberWithDouble:[mainLabel.text doubleValue]]  forKey:@"n"];
            }
            else
            {
                [self compute:@"n"];
            }
            clearMainScreen = YES;
            currentOperationLabel.text = @"N";
            break;
        case 305:
            if(!readyToCpt)
            {
                [self.valueSet setObject:[NSNumber numberWithDouble:[mainLabel.text doubleValue]]  forKey:@"pmt"];
            }
            else
            {
                [self compute:@"pmt"];
            }
            currentOperationLabel.text = @"PMT";
            clearMainScreen = YES;
            break;
        case 306:
            readyToCpt = YES;
            currentOperationLabel.text = @"CPT";
            break;
        case 307:
            if(readyToCpt)
            {
                [self compute:@"ear"];
                currentOperationLabel.text = @"EAR";
            }
            clearMainScreen = YES;
            break;
        case 308:
            currentOperationLabel.text = [NSString stringWithFormat:@"CF%d", [cashFlows count]];
            [cashFlows addObject:[NSNumber numberWithDouble:[mainLabel.text doubleValue]]];
            clearMainScreen = YES;
            break;
        case 309:
            if(readyToCpt)
            {
                [self compute:@"npv"];
                currentOperationLabel.text = @"NPV";
                clearMainScreen = YES;
            }
            break;
        case 310:
            if(readyToCpt)
            {
                [self compute:@"irr"];
                currentOperationLabel.text = @"IRR";
                clearMainScreen = YES;
            }
            break;
        case 401:
            memoryData += [mainLabel.text doubleValue];
            clearMainScreen = YES;
            currentOperationLabel.text = @"M+";
            break;
        case 402:
            memoryData -= [mainLabel.text doubleValue];
            clearMainScreen = YES;
            currentOperationLabel.text = @"M-";
            break;
        case 403:
            memoryData = 0;
            currentOperationLabel.text = @"MC";
            break;
        case 404:
            mainLabel.text = [NSString stringWithFormat:@"%.10lg", memoryData];
            clearMainScreen = YES;
            currentOperationLabel.text = @"MR";
            break;
        case 405:
            if([mainLabel.text hasPrefix:@"-"])
            {
                mainLabel.text = [mainLabel.text substringFromIndex:1];  
            }
            else
            {
                mainLabel.text = [NSString stringWithFormat:@"-%@", mainLabel.text];
            }
            break;
            
    }
}

- (void)compute:(NSString *)what
{
    if([what isEqualToString:@"pmt"])
    {
        if([valueSet count] < 3)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ERROR!" message:@"Not enough values!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        else if([valueSet count] == 3 && [valueSet objectForKey:@"pv"] == nil)
        {
            double pv = 0;
            double fv = [(NSNumber *)[valueSet objectForKey:@"fv"] doubleValue];
            double i = [(NSNumber *)[valueSet objectForKey:@"i"] doubleValue];
            double n = [(NSNumber *)[valueSet objectForKey:@"n"] doubleValue];
            double result = (pv * pow((1 + i / 100), n) - fv) / ((1 - pow((1 + i / 100), n))/ (1 - 1 - i / 100));
            mainLabel.text = [NSString stringWithFormat:@"%.10lg", result];
        }
        else if([valueSet count] == 3 && [valueSet objectForKey:@"fv"] == nil)
        {
            double pv = [(NSNumber *)[valueSet objectForKey:@"pv"] doubleValue];
            double fv = 0;
            double i = [(NSNumber *)[valueSet objectForKey:@"i"] doubleValue];
            double n = [(NSNumber *)[valueSet objectForKey:@"n"] doubleValue];
            double result = (pv * pow((1 + i / 100), n) - fv) / ((1 - pow((1 + i / 100), n))/ (1 - 1 - i / 100));
            mainLabel.text = [NSString stringWithFormat:@"%.10lg", result];
        }
        else
        {
            if([valueSet objectForKey:@"pmt"] != nil)
            {
                mainLabel.text = [NSString stringWithFormat:@"%.10lg", [(NSNumber *)[valueSet objectForKey:@"pmt"] doubleValue]];
            }
            else
            {
                double pv = [(NSNumber *)[valueSet objectForKey:@"pv"] doubleValue];
                double fv = [(NSNumber *)[valueSet objectForKey:@"fv"] doubleValue];
                double i = [(NSNumber *)[valueSet objectForKey:@"i"] doubleValue];
                double n = [(NSNumber *)[valueSet objectForKey:@"n"] doubleValue];
                double result = (pv * pow((1 + i / 100), n) - fv) / ((1 - pow((1 + i / 100), n))/ (1 - 1 - i / 100));
                mainLabel.text = [NSString stringWithFormat:@"%.10lg", result];
            }
        }
    }
    else if([what isEqualToString:@"pv"])
    {
        if([valueSet count] < 3)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ERROR!" message:@"Not enough values!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        else if([valueSet count] == 3 && [valueSet objectForKey:@"pmt"] == nil)
        {
            double fv = [(NSNumber *)[valueSet objectForKey:@"fv"] doubleValue];
            double i = [(NSNumber *)[valueSet objectForKey:@"i"] doubleValue];
            double n = [(NSNumber *)[valueSet objectForKey:@"n"] doubleValue];
            double result = fv / pow((1 + i / 100), n);
            mainLabel.text = [NSString stringWithFormat:@"%.10lg", result];
        }
        else
        {
            double fv = [(NSNumber *)[valueSet objectForKey:@"fv"] doubleValue];
            double i = [(NSNumber *)[valueSet objectForKey:@"i"] doubleValue];
            double n = [(NSNumber *)[valueSet objectForKey:@"n"] doubleValue];
            double pmt = [(NSNumber *)[valueSet objectForKey:@"pmt"] doubleValue];
            double result = (fv - pmt * ((1 - pow((1 + i / 100), n))/ (1 - 1 - i / 100))) / pow((1 + i / 100), n);
            mainLabel.text = [NSString stringWithFormat:@"%.10lg", result];
        }
    }
    else if([what isEqualToString:@"fv"])
    {
        if([valueSet count] < 3)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ERROR!" message:@"Not enough values!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        else if([valueSet count] == 3 && [valueSet objectForKey:@"pmt"] == nil)
        {
            double pv = [(NSNumber *)[valueSet objectForKey:@"pv"] doubleValue];
            double i = [(NSNumber *)[valueSet objectForKey:@"i"] doubleValue];
            double n = [(NSNumber *)[valueSet objectForKey:@"n"] doubleValue];
            double result = pv * pow((1 + i / 100), n);
            mainLabel.text = [NSString stringWithFormat:@"%.10lg", result];
        }
        else
        {
            double pv = [(NSNumber *)[valueSet objectForKey:@"pv"] doubleValue];
            double i = [(NSNumber *)[valueSet objectForKey:@"i"] doubleValue];
            double n = [(NSNumber *)[valueSet objectForKey:@"n"] doubleValue];
            double pmt = [(NSNumber *)[valueSet objectForKey:@"pmt"] doubleValue];
            double result = pv * pow((1 + i / 100), n) + pmt * (1 - pow((1 + i / 100), n))/ (1 - 1 - i / 100);
            mainLabel.text = [NSString stringWithFormat:@"%.10lg", result];
        }
    }
    else if([what isEqualToString:@"n"])
    {
        if([valueSet count] == 3 && [valueSet objectForKey:@"pmt"] == nil)
        {
            double pv = [(NSNumber *)[valueSet objectForKey:@"pv"] doubleValue];
            double fv = [(NSNumber *)[valueSet objectForKey:@"fv"] doubleValue];
            double i = [(NSNumber *)[valueSet objectForKey:@"i"] doubleValue];
            double result = log((fv / pv)) / log(1 + i / 100);
            mainLabel.text = [NSString stringWithFormat:@"%.10lg", result];
        }
        else if([valueSet count] == 3 && [valueSet objectForKey:@"pmt"] != nil && [valueSet objectForKey:@"pv"] == nil)
        {
            double pv = 0;
            double fv = [(NSNumber *)[valueSet objectForKey:@"fv"] doubleValue];
            double i = [(NSNumber *)[valueSet objectForKey:@"i"] doubleValue];
            double pmt = [(NSNumber *)[valueSet objectForKey:@"pmt"] doubleValue];
            double result = log((fv - pmt/(1 - 1 - i/100)) / (pv - pmt/(1 - 1 - i/100))) / log(1 + i/100);
            mainLabel.text = [NSString stringWithFormat:@"%.10lg", result];
        }
        else if([valueSet count] == 3 && [valueSet objectForKey:@"pmt"] != nil && [valueSet objectForKey:@"fv"] == nil)
        {
            double pv = [(NSNumber *)[valueSet objectForKey:@"pv"] doubleValue];
            double fv = 0;
            double i = [(NSNumber *)[valueSet objectForKey:@"i"] doubleValue];
            double pmt = [(NSNumber *)[valueSet objectForKey:@"pmt"] doubleValue];
            double result = log((fv - pmt/(1 - 1 - i/100)) / (pv - pmt/(1 - 1 - i/100))) / log(1 + i/100);
            mainLabel.text = [NSString stringWithFormat:@"%.10lg", result];
        }
        else if([valueSet count] == 4 && [valueSet objectForKey:@"n"] == nil)
        {
            double pv = [(NSNumber *)[valueSet objectForKey:@"pv"] doubleValue];
            double fv = [(NSNumber *)[valueSet objectForKey:@"fv"] doubleValue];
            double i = [(NSNumber *)[valueSet objectForKey:@"i"] doubleValue];
            double pmt = [(NSNumber *)[valueSet objectForKey:@"pmt"] doubleValue];
            double result = log((fv - pmt/(1 - 1 - i/100)) / (pv - pmt/(1 - 1 - i/100))) / log(1 + i/100);
            mainLabel.text = [NSString stringWithFormat:@"%.10lg", result];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ERROR!" message:@"Not enough values!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }
    else if([what isEqualToString:@"i"])
    {
        if([valueSet count] < 3)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ERROR!" message:@"Not enough values!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        else
        {
            double pv = [(NSNumber *)[valueSet objectForKey:@"pv"] doubleValue];
            double fv = [(NSNumber *)[valueSet objectForKey:@"fv"] doubleValue];
            double n = [(NSNumber *)[valueSet objectForKey:@"n"] doubleValue];
            double result = pow((fv / pv), 1 / n);
            mainLabel.text = [NSString stringWithFormat:@"%.10lg", (result - 1) * 100];
        }
    } 
    else if([what isEqualToString:@"ear"])
    {
        if([valueSet objectForKey:@"i"] != nil && [valueSet objectForKey:@"n"] != nil)
        {
            double i = [(NSNumber *)[valueSet objectForKey:@"i"] doubleValue];
            double n = [(NSNumber *)[valueSet objectForKey:@"n"] doubleValue];
            double result = pow((1 + i / 100 / n), n) - 1;
            mainLabel.text = [NSString stringWithFormat:@"%.2lg", result * 100];
        }
    }
    else if([what isEqualToString:@"npv"])
    {
        if([valueSet objectForKey:@"i"] != nil && [cashFlows count] > 1)
        {
            double i = [(NSNumber *)[valueSet objectForKey:@"i"] doubleValue];
            double n = (NSNumber *)[valueSet objectForKey:@"n"] == nil ? 0 : [(NSNumber *)[valueSet objectForKey:@"n"] doubleValue];
            double result = 0;
            for(int t = 1; t < [cashFlows count]; t++)
            {
                result += [(NSNumber *)[cashFlows objectAtIndex:t] doubleValue] / pow((1 + i/100), t);
            }
            for(int m = 1; m < n; m++)
            {
                result += [(NSNumber *)[cashFlows lastObject] doubleValue] / pow((1 + i/100), [cashFlows count] - 1 + m);
            }
            mainLabel.text = [NSString stringWithFormat:@"%.6lg", result + [(NSNumber *)[cashFlows objectAtIndex:0] doubleValue]];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ERROR!" message:@"Not enough values!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }
    else if([what isEqualToString:@"irr"])
    {
        if([cashFlows count] > 1)
        {
            BOOL found = NO;
            double i = 1;
            double lastResult = 0;
            while(!found)
            {
                double result = 0;
                for(int n = 1; n < [cashFlows count]; n++)
                {
                    result += [(NSNumber *)[cashFlows objectAtIndex:n] doubleValue] / pow(1.0f + i/100, n);
                }
                if((lastResult < 0 && result + [(NSNumber *)[cashFlows objectAtIndex:0] doubleValue] > 0) || (lastResult > 0 && result + [(NSNumber *)[cashFlows objectAtIndex:0] doubleValue] < 0))
                {
                    found = YES;
                }
                else
                {
                    lastResult = result + [(NSNumber *)[cashFlows objectAtIndex:0] doubleValue];
                    i++;
                }
                if(i == 500)
                {
                    break;
                }
            }
            if(i == 500)
            {
                mainLabel.text = @"Error";
            }
            else
            {
                mainLabel.text = [NSString stringWithFormat:@"%g%@", i, @"%"];
            }
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ERROR!" message:@"Not enough values!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }
}

- (double)calculate:(Operator *)calculation
{

    if([calculation.operate isEqualToString:@"plus"])
    {
        return [lastNumber doubleValue] + [mainLabel.text doubleValue];       
    }
    else if([calculation.operate isEqualToString:@"minus"])
    {
        return [lastNumber doubleValue] - [mainLabel.text doubleValue];
    }
    else if([calculation.operate isEqualToString:@"multiply"])
    {
        return [lastNumber doubleValue] * [mainLabel.text doubleValue];
    }
    else if([calculation.operate isEqualToString:@"divide"])
    {
        return [lastNumber doubleValue] / [mainLabel.text doubleValue];
    }
    else if([calculation.operate isEqualToString:@"power"])
    {
        return pow([lastNumber doubleValue], [mainLabel.text doubleValue]);
    }
    else if([calculation.operate isEqualToString:@"root"])
    {
        return pow([lastNumber doubleValue], 1 / [mainLabel.text doubleValue]);
    }
    return 0;
}

- (double)calculatePastNumbers:(Operator *)op
{
    if([pastNumbersAndOps count] == 1)
    {
        NSArray *tempArr = [pastNumbersAndOps allKeys];
        double ln = [(NSNumber *)[pastNumbersAndOps objectForKey:[tempArr objectAtIndex:0]] doubleValue];
        if([[tempArr objectAtIndex:0] isEqualToString:@"plus"])
        {
            return ln + [self calculate:op];
        }
        else if([[tempArr objectAtIndex:0] isEqualToString:@"minus"])
        {
            return ln - [self calculate:op];
        }
        else if([[tempArr objectAtIndex:0] isEqualToString:@"multiply"])
        {
            return ln * [self calculate:op];
        }
        else if([[tempArr objectAtIndex:0] isEqualToString:@"divide"])
        {
            return ln / [self calculate:op];
        }  
    }
    else if([pastNumbersAndOps count] == 2)
    {
        NSArray *tempArr = [pastNumbersAndOps allKeys];
        double ln = [(NSNumber *)[pastNumbersAndOps objectForKey:[tempArr objectAtIndex:0]] doubleValue];
        double ln2 = [(NSNumber *)[pastNumbersAndOps objectForKey:[tempArr objectAtIndex:1]] doubleValue];
        if([[tempArr objectAtIndex:0] isEqualToString:@"plus"])
        {
            if([[tempArr objectAtIndex:1] isEqualToString:@"multiply"])
            {
                return ln + ln2 * [self calculate:op];
            }
            else if([[tempArr objectAtIndex:1] isEqualToString:@"divide"])
            {
                return ln + ln2 / [self calculate:op];
            }
        }
        else if([[tempArr objectAtIndex:0] isEqualToString:@"minus"])
        {
            if([[tempArr objectAtIndex:1] isEqualToString:@"multiply"])
            {
                return ln - ln2 * [self calculate:op];
            }
            else if([[tempArr objectAtIndex:1] isEqualToString:@"divide"])
            {
                return ln - ln2 / [self calculate:op];
            }
        }

    }
    return 0;
}

//trim the result, when it may contains unwanted zeros like 3.000000
- (NSString *)trimResult:(NSString *)result
{
    NSArray *arr = [result componentsSeparatedByString:@"."];
    if([(NSString *)[arr objectAtIndex:1] doubleValue] == 0)
    {
        return [arr objectAtIndex:0];
    }
    return result; 
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
        currentOperationLabel.text = @"";
        mainLabel.text = @"0";
    }
}

@end
