//
//  main.c
//  Cast
//
//  Created by CSI Student on 20/02/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#include <stdio.h>
#include <math.h>
#include <readline/readline.h>


int main(int argc, const char * argv[])
{

    //printf("11/3.0 = %f\n", (float)11/3);
    
    //float t = (float)11/3;
    //printf("%f",t);
    
    
    //printf("The absolute value of -5 is %d\n", abs(-5));
    
    //printf("The sin of 1 radian is %f\n", sin(1));
    
    //printf("Who is cool? ");
    //const char *name = readline(NULL);
    //printf("%s is cool!\n\n", name);
    
    int i = 7;
    int *addressOfI = &i;
    
    printf("An int is %zu bytes \n", sizeof(i));
    
    printf("An int is %zu bytes \n", sizeof(addressOfI));
    return 0;
}

