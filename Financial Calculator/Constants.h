//
//  Constants.h
//  Financial Calculator
//
//  Created by Shijia Qian on 28/03/12.
//  Copyright (c) 2012 UTAS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject

+(void)initializeAllValues;
+(NSDictionary *)getUnits:(NSString *)what;
+(void)setWhat:(int)w;
+(int)getWhat;

@end
