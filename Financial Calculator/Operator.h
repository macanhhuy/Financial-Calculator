//
//  Operator.h
//  Financial Calculator
//
//  Created by Shijia Qian on 3/03/12.
//  Copyright (c) 2012 UTAS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Operator : NSObject
{
    NSString *operate;
    int priority;
}

@property (copy) NSString *operate;
@property int priority;

@end
