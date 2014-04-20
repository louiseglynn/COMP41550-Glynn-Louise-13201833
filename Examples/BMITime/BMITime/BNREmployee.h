//
//  BNREmployee.h
//  BMITime
//
//  Created by CSI Student on 16/03/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//


#import "BNRPerson.h"
@class BNRAsset;

@interface BNREmployee : BNRPerson
/*{
    NSMutableArray *_assets;
}made private*/

@property (nonatomic) unsigned int employeeID;
//@property (nonatomic) unsigned int officeAlarmCode; made it private
@property (nonatomic) NSDate *hireDate;
//@property (nonatomic, copy) NSArray *assets;
@property (nonatomic, copy) NSSet *assets;

-(double)yearsOfEmployment;
-(void)addAsset:(BNRAsset *)a;
-(void)removeAsset:(BNRAsset *)a;
-(unsigned int)valueOfAssets;
@end
