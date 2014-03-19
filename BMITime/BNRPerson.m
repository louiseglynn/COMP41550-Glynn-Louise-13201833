//
//  BNRPerson.m
//  BMITime
//
//  Created by CSI Student on 15/03/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import "BNRPerson.h"

@implementation BNRPerson

/*- (float)heightInMeters{
    
    return _heightInMetres;
}

- (void)setHeightInMeters:(float)h{
    
    _heightInMetres = h;
}

- (int)weightInKilos{
    
    return _weightInKilos;
}

- (void)setWeightInKilos:(int)w{
    
    _weightInKilos = w;
}
*/

- (float)bodyMassIndex{
    
    return [self weightInKilos] / ([self heightInMetres] * [self heightInMetres]);
    
}

@end
