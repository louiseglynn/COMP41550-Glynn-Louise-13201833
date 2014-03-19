//
//  BNRPerson.h
//  BMITime
//
//  Created by CSI Student on 15/03/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRPerson : NSObject

@property (nonatomic) float heightInMetres;
@property (nonatomic) float weightInKilos;

/*{
    //float _heightInMetres;
    //float _weightInKilos;
    
}


- (float)heightInMeters;
- (void)setHeightInMeters:(float)h;
- (int)weightInKilos;
- (void)setWeightInKilos:(int)w;*/

- (float)bodyMassIndex;

@end
