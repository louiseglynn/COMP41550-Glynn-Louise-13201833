//
//  BNREmployee.m
//  BMITime
//
//  Created by CSI Student on 16/03/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import "BNREmployee.h"
#import "BNRAsset.h"

@interface BNREmployee()
{
    //NSMutableArray *_assets;
    NSMutableSet *_assets;
}
@property (nonatomic) unsigned int officeAlarmCode;

@end

@implementation BNREmployee

-(double)yearsOfEmployment{
    
    if(self.hireDate){
        
        NSDate *now = [NSDate date];
        NSTimeInterval secs = [now timeIntervalSinceDate:self.hireDate];
        return secs/31557600.0;
        
    }
    else{
        return 0;
    }
    
}

-(float)bodyMassIndex{
    
    float normalBMI = [super bodyMassIndex];
    return normalBMI * 0.9;
}

-(NSString *)description{
    //return [NSString stringWithFormat:@"<Employee %d>", self.employeeID];

    return [NSString stringWithFormat:@"<Employee %d: $%d in assets>", self.employeeID, self.valueOfAssets];
}

/*-(void)setAssets:(NSArray *)a{
    _assets = [a mutableCopy];
}*/

-(void)setAssets:(NSSet *)a{
    _assets = [a mutableCopy];
}

/*-(NSArray *)assets{
    return [_assets copy];
}*/

-(NSSet *)assets{
    return [_assets copy];
}

/*-(void)addAsset:(BNRAsset *)a{
    if(!_assets){
        _assets = [[NSMutableArray alloc]init];
    }
    a.employee = self;
    [_assets addObject:a];
}
-(void)removeAsset:(BNRAsset *)a{
    if(_assets){
        [_assets removeObject:a];
    }
}*/

-(void)addAsset:(BNRAsset *)a{
    if(!_assets){
        _assets = [[NSMutableSet alloc]init];
    }
    a.employee = self;
    [_assets addObject:a];
    
}
-(void)removeAsset:(BNRAsset *)a{
    if(_assets){
        [_assets removeObject:a];
    }
    
    
}

-(unsigned int)valueOfAssets{
    
    unsigned int sum = 0;
    for(BNRAsset *a in _assets){
        sum += [a resaleValue];
    }
    return sum;
}

-(void)dealloc{
    NSLog(@"deallocating %@", self);
}


@end
