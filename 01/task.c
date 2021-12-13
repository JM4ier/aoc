#! /usr/bin/tcc -run
#include <stdio.h>

#define N 10000

int main() {
    int values[N];
    int len = 0;
    int current;

    while (scanf("%d\n", &current) > 0) {
        values[len++] = current;
    }
    
    printf("got %d values.\n", len);

    int t1 = 0;
    for (int i = 1; i < len; i++) {
        t1 += (values[i] > values[i-1]);
    }

    printf("task 1: %d\n", t1);

    int t2 = 0;

    for (int i = 3; i < len; i++) {
        t2 += (values[i] > values[i-3]);
    }

    printf("task 2: %d\n", t2);


}
