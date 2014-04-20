//
//  main.c
//  BeerSong
//
//  Created by CSI Student on 12/02/2014.
//  Copyright (c) 2014 ucd. All rights reserved.
//

#include <stdio.h>

void singSongFor(int numBottles){
    
    if(numBottles == 0){
        printf("There are no more bottles of beer on the wall.\n");
    }
    else{
        printf("%d bottles of beer on the wall, %d bottles of beer, ", numBottles, numBottles);
        int oneFewer = numBottles - 1;
        printf("take one down, pass it around, %d bottles of beer on the wall.\n", oneFewer);
        
        singSongFor(oneFewer);
    }
}


int main(int argc, const char * argv[])
{

    singSongFor(4);
    return 0;
}

