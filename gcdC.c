///////////////////////////////////////////////////////
//    EE3450 Computer Architecture - Spring 109      //
//    Project: Find Greatest Common Divisors (GCD)   //
//    Binary GCD (gcdC.c)                            //
///////////////////////////////////////////////////////

#include <stdio.h>

int gcd(int a, int b)
{
    // a and b are even (BG1)
    if (((a & 1) == 0) && ((b & 1) == 0))
    {
        // a and b shift right 1 bit
        a = a >> 1;
        b = b >> 1;
        return gcd(a, b);
    }

    // a is even, b is odd (BG2)
    else if (((a & 1) == 0) && ((b & 1) != 0))
    {
        // a shifts right 1 bit
        a = a >> 1;
        return gcd(a, b);
    }

    // a is odd, b is even (BG2)
    else if (((a & 1) != 0) && ((b & 1) == 0))
    {
        // b shifts right 1 bit
        b = b >> 1;
        return gcd(a, b);
    }

    // a and b are odd
    else
    {
        // base case (E2)
        if (a == b)
            return a;

        // a is greater (E1)
        else if (a > b)
            return gcd(a - b, b);

        // b is greater (E1)
        else
            return gcd(a, b - a);
    }
}

int main(void)
{

    int a, b;

    printf("Please give 2 integers separated by enter:\n");

    scanf("%d", &a);
    scanf("%d", &b);

    a = gcd(a, b);

    printf("The greatest common divisor is %d\n", a);

    return 0;
}