///////////////////////////////////////////////////////
//    EE3450 Computer Architecture - Spring 109      //
//    Project: Find Greatest Common Divisors (GCD)   //
//    Iterative method (gcdB.c)                      //
///////////////////////////////////////////////////////

#include <stdio.h>

int main(void)
{

    int a, b;

    printf("Please give 2 integers separated by enter:\n");

    scanf("%d", &a);
    scanf("%d", &b);

    // Eluclid's algorithm until a = b
    while (a != b)
    {
        // a is greater
        if (a > b)
            a -= b; // a is greater, a = a - b

        // b is greater
        else
            b -= a; // b is greater, b = b - a
    }

    printf("The greatest common divisor is %d\n", a);

    return 0;
}