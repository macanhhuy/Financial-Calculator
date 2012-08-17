//
//  ViewController.h
//  Financial Calculator
//
//  Created by Shijia Qian on 1/03/12.
//  Copyright (c) 2012 UTAS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Operator.h"

@interface ViewController : UIViewController<UIAlertViewDelegate>
{
    UILabel *currentOperationLabel, *mainLabel;
    NSMutableDictionary *valueSet, *pastNumbersAndOps;
    NSMutableArray *cashFlows;
    BOOL dotted, readyToCpt, clearMainScreen, calulateEnabled, fromCalculate;
    Operator *currentCalculation;
    NSNumber *lastNumber, *firstNumber, *secondNumber;
    NSArray *operatorArray;
    double memoryData;
}

@property (nonatomic, retain) IBOutlet UILabel *currentOperationLabel;
@property (nonatomic, retain) IBOutlet UILabel *mainLabel;
@property (nonatomic, retain) NSMutableDictionary *valueSet;
@property double memoryData;

-(IBAction)btnPressed:(id)sender;
-(void)compute:(NSString *)what;
-(double)calculate:(Operator *)calculation;
-(NSString *)trimResult:(NSString *)result;
- (double)calculatePastNumbers:(Operator *)op;

@end
