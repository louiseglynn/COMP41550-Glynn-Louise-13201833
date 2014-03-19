//
//  main.c
//  Angles
//
//  Created by CSI Student on 20/02/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#include <stdio.h>

float remainingAngle(float angleA, float angleB){
    
    float angleC = 180.0 - (angleA+angleB);
    return angleC;
}

int main(int argc, const char * argv[])
{

    float angleA = 30.0;
    float angleB = 60.0;
    float angleC = remainingAngle(angleA, angleB);
    printf("The third agnle is %.2f\n", angleC);
}



