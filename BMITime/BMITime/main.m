//
//  main.m
//  BMITime
//
//  Created by CSI Student on 15/03/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "BNRPerson.h"
#import "BNREmployee.h"
#import "BNRAsset.h"


int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        //BNRPerson *mikey = [[BNRPerson alloc]init];
        BNREmployee *mikey = [[BNREmployee alloc]init];
        
        NSMutableDictionary *executives = [[NSMutableDictionary alloc]init];
        
        //[mikey setWeightInKilos:96];
        //[mikey setHeightInMetres:1.8];
        
        
        mikey.weightInKilos = 96;
        mikey.heightInMetres = 1.8;
        mikey.employeeID = 12;
        mikey.hireDate = [NSDate dateWithNaturalLanguageString:@"Aug 2nd, 2010"];
        
        BNRAsset *a1 = [[BNRAsset alloc]init];
        a1.label = @"Test Asset";
        a1.resaleValue = 2.30;
        //a1.employee = mikey; moved this to the addAsset method
        
        [mikey addAsset:a1];
        [mikey removeAsset:a1];
        
    
        
        
        //NSLog(@"Mikey is %.2f meters tall and weighs %.2f kilograms, his BMI is: %.2f", [mikey heightInMetres], [mikey weightInKilos], [mikey bodyMassIndex]);
        
        NSLog(@"Mikey is %.2f meters tall and weighs %.2f kilograms, his BMI is: %.2f", mikey.heightInMetres, mikey.weightInKilos, mikey.bodyMassIndex);
        
        NSLog(@"Employee %u hired on %@", mikey.employeeID, mikey.hireDate);
        
        double years = [mikey yearsOfEmployment];
        NSLog(@"has worked with us for %.2f years", years);
        
        NSLog(@"Employee %@ hired on %@", mikey, mikey.hireDate);
        
        
        
        
        
    }
    return 0;
}

