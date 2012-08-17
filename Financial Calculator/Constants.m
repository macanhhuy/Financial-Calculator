//
//  Constants.m
//  Financial Calculator
//
//  Created by Shijia Qian on 28/03/12.
//  Copyright (c) 2012 UTAS. All rights reserved.
//

#import "Constants.h"

@implementation Constants

static NSDictionary *lengthArr;
static NSDictionary *weightArr;
static NSDictionary *volumeArr;
static NSDictionary *areaArr;
static int what;

+(void)initializeAllValues
{
    lengthArr = [[NSDictionary alloc] initWithObjects:
                 [NSArray arrayWithObjects:[NSNumber numberWithDouble:1000], 
                 [NSNumber numberWithDouble:1],
                 [NSNumber numberWithDouble:0.01],
                 [NSNumber numberWithDouble:0.001],
                 [NSNumber numberWithDouble:1609.344],
                 [NSNumber numberWithDouble:1852],
                 [NSNumber numberWithDouble:0.9144],
                 [NSNumber numberWithDouble:0.3048],
                 [NSNumber numberWithDouble:0.0254], nil] 
                forKeys:[NSArray arrayWithObjects:@"km", @"m", @"cm", @"mm", @"mile", @"nmile", @"yard", @"feet", @"inch", nil]];
    
    weightArr = [[NSDictionary alloc] initWithObjects:
                 [NSArray arrayWithObjects:[NSNumber numberWithDouble:1000000], 
                 [NSNumber numberWithDouble:1000],
                 [NSNumber numberWithDouble:1],
                 [NSNumber numberWithDouble:0.001],
                 [NSNumber numberWithDouble:453.59237],
                 [NSNumber numberWithDouble:28.34952],
                 [NSNumber numberWithDouble:1.771845],nil]
                 forKeys:[NSArray arrayWithObjects:@"t", @"kg", @"g", @"mg", @"lb", @"oz", @"dr", nil]];
    
    volumeArr = [[NSDictionary alloc] initWithObjects:
                 [NSArray arrayWithObjects:[NSNumber numberWithDouble:1000000], 
                  [NSNumber numberWithDouble:1000],
                  [NSNumber numberWithDouble:1],
                  [NSNumber numberWithDouble:0.001],
                  [NSNumber numberWithDouble:100000],
                  [NSNumber numberWithDouble:1000],
                  [NSNumber numberWithDouble:1],
                  [NSNumber numberWithDouble:163659.24],
                  [NSNumber numberWithDouble:4546.09], 
                  [NSNumber numberWithDouble:568.26125],
                  [NSNumber numberWithDouble:28.4130625],nil]
                  forKeys:[NSArray arrayWithObjects:@"cubic m", @"cubic dm", @"cubic cm", @"cubic mm", @"hectoliter", @"liter", @"mililiter", @"barrel", @"gallon", @"pint", @"ounce", nil]];
    
    areaArr = [[NSDictionary alloc] initWithObjects:
                 [NSArray arrayWithObjects:[NSNumber numberWithDouble:1000000], 
                  [NSNumber numberWithDouble:1],
                  [NSNumber numberWithDouble:0.0001],
                  [NSNumber numberWithDouble:2589988.110336],
                  [NSNumber numberWithDouble:0.8361274],
                  [NSNumber numberWithDouble:0.0929030],
                  [NSNumber numberWithDouble:0.0006452],
                  [NSNumber numberWithDouble:4046.8564224], 
                  [NSNumber numberWithDouble:10000],nil]
                  forKeys:[NSArray arrayWithObjects:@"square km", @"square m", @"square cm", @"square mile", @"square yard", @"square feet", @"square inch", @"acre", @"hectare", nil]];
    
}

+(NSDictionary *)getUnits:(NSString *)what
{
    if([what isEqualToString:@"length"])
    {
        return lengthArr;
    }
    else if([what isEqualToString:@"weight"])
    {
        return weightArr;
    }
    else if([what isEqualToString:@"volume"])
    {
        return volumeArr;
    }
    else if([what isEqualToString:@"area"])
    {
        return areaArr;
    }
    else 
    {
        return nil;   
    }
}

+(void)setWhat:(int) w
{
    what = w;
}

+(int)getWhat
{
    return what;
}

@end
