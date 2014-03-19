//
//  main.c
//  PBR
//
//  Created by CSI Student on 14/03/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#include <stdio.h>
#include <math.h>


void metersToFeetAndInches(double meters, unsigned int *ftPtr, double *inPtr){
    
    double rawFeet = meters *3.281;
    unsigned int feet = (unsigned int)floor(rawFeet);
    
    if(ftPtr){
        
        printf("Storing %u to the address %p \n", feet, ftPtr);
        *ftPtr = feet;
        
    }
    
    //double fractionalFoot = rawFeet - feet;
    //double inches = fractionalFoot *12.0;
    
    double fractionalFoot;
    double inches;
    
    inches = modf(rawFeet, &fractionalFoot);
    
    inches = inches * 12.0;
    
    if(inPtr){
        
        printf("Storing %.2f to the address %p \n", inches, inPtr);
        *inPtr = inches;
        
    }
    
    
}

int main(int argc, const char * argv[])
{

    double pi = 3.14;
    double integerPart;
    double fractionPart;
    
    fractionPart = modf(pi, &integerPart);
    
    //printf("integerPart = %.f, fractionPart = %.2f\n", integerPart, fractionPart);
    
    
    double meters = 3;
    unsigned int feet;
    double inches;
    

    metersToFeetAndInches(meters, &feet, &inches);
    
    printf("%.1f meters is equal to  %d feet and %.1f inches.", meters, feet, inches);
    
}

