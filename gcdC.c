///////////////////////////////////////////////////////
//    EE3450 Computer Architecture - Spring 109      //
//    Project: Find Greatest Common Divisors (GCD)   //
//    Binary GCD (gcdC.c)                            //
///////////////////////////////////////////////////////

#include <stdio.h>

int gcd(int a, int b)
{
    // variables to store the judgements
    int a_even = 0, b_even = 0;

    a_even = (a & 1) == 0; // if a is even, a_even = 1, odd = 0
    b_even = (b & 1) == 0; // if b is even, b_even = 1, odd = 0

    // a and b are even (BG1)
    if (a_even && b_even)
        // a and b shift right 1 bit
        return gcd(a >> 1, b >> 1) << 1;

    // a is even, b is odd (BG2)
    else if (a_even)
        // a shifts right 1 bit
        return gcd(a >> 1, b);

    // a is odd, b is even (BG2)
    else if (b_even)
        // b shifts right 1 bit
        return gcd(a, b >> 1);

    // If jump into the following 3 else if statement
    // a, b are odd numbers
    // base case : a = b (E2), and a, b are odd
    else if (a == b)
        return a;

    // a is greater (E1)
    else if (a > b)
        // a is greater than b, a = a - b
        return gcd(a - b, b);

    // b is greater (E1)
    else
        // b is greater than b, b = b - a
        return gcd(a, b - a);
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