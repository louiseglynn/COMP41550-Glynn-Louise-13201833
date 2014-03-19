//
//  main.c
//  BMICalc
//
//  Created by CSI Student on 14/03/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#include <stdio.h>

/*struct Person{
    float heightInMeters;
    int weightInKilos;
};*/

typedef struct{
    float heightInMeters;
    int weightInKilos;
    
}Person;

float bodyMassIndex(Person p){
    
    return p.weightInKilos / (p.heightInMeters * p.heightInMeters);
}

int main(int argc, const char * argv[])
{

    //struct Person mikey;
    Person mikey;
    mikey.heightInMeters = 1.7;
    mikey.weightInKilos = 96;
    
    
    //struct Person aaron;
    Person aaron;
    aaron.heightInMeters = 1.97;
    aaron.weightInKilos = 84;
    
    printf("mikey is %.2f meters tall \n", mikey.heightInMeters);
    printf("mikey is %d kilograms \n", mikey.weightInKilos);
    printf("aaron is %.2f meters tall \n", aaron.heightInMeters);
    printf("aaron is %d kilograms \n", aaron.weightInKilos);
    
    printf("mikey's bmi is: %.2f\n",bodyMassIndex(mikey));
    printf("aaron's bmi is: %.2f\n",bodyMassIndex(aaron));
    
}

